import sys
import re
import json
import html

def main():
    # Read raw bytes from stdin and decode, replacing errors
    html_bytes = sys.stdin.buffer.read()
    html_content = html_bytes.decode('utf-8', errors='replace')

    results = {}
    
    block_regex = re.compile(r'<div class="dirresult[1234]">(.*?)</div> <!--dirresult end-->', re.DOTALL)
    
    for match in block_regex.finditer(html_content):
        block = match.group(1)
        
        thai_match = re.search(r'<p class="ThaiText">(.*?)</p>', block, re.DOTALL)
        if not thai_match:
            continue
        
        thai = re.sub(r'<[^>]*>', '', thai_match.group(1)).strip()
        if not thai:
            continue

        trans_de = ''
        trans_de_match = re.search(r'<p class="News">(.*?)</p>', block, re.DOTALL)
        if trans_de_match:
            initial_trans_de = re.sub(r'<[^>]*>', '', trans_de_match.group(1))
            trans_de = html.unescape(initial_trans_de)
            trans_de = re.sub(r'[\\/-]', '', trans_de)
            trans_de = re.sub(r'\s+', ' ', trans_de).strip()
        
        meaning_de = ''
        meaning_match1 = re.search(r"<a class='ShortDef'>Kurzdefinition: </a>(.*?)</p>", block, re.DOTALL)
        if meaning_match1:
            meaning_de = re.sub(r'<[^>]*>', '', meaning_match1.group(1)).strip()
        else:
            meaning_match2 = re.search(r'<p class="Text">(.*?)<br />', block, re.DOTALL)
            if meaning_match2:
                meaning_de = re.sub(r'<[^>]*>', '', meaning_match2.group(1)).strip()
            else: # Handle "Keine Übersetzung vorhanden" or other single-line meanings
                meaning_match3 = re.search(r'<p class="Text">(.*?)</p>', block, re.DOTALL)
                if meaning_match3:
                    temp_meaning = re.sub(r'<[^>]*>', '', meaning_match3.group(1)).strip()
                    if temp_meaning == 'Keine &Uuml;bersetzung vorhanden' or temp_meaning == '?':
                        meaning_de = '' # Set to empty string
                    else:
                        meaning_de = temp_meaning


        # Convert empty strings to None (which json.dumps converts to null)
        # for proper JSON null handling, but keep original thai value
        if not trans_de:
            trans_de_val = None
        else:
            trans_de_val = trans_de
        
        if not meaning_de:
            meaning_de_val = None
        else:
            meaning_de_val = meaning_de


        # If both trans_de and meaning_de are None, set the entire entry to None
        if trans_de_val is None and meaning_de_val is None:
            results[thai] = None
        else:
            results[thai] = {
                'trans_de': trans_de_val,
                'meaning_de': meaning_de_val,
                'thai': thai,
            }
        
    # --- Post-processing: Remove null entries if sub-parts are translated ---
    translated_keys = [k for k, v in results.items() if v is not None]
    keys_to_remove = []

    for thai_key, value in results.items():
        if value is None:
            for translated_key in translated_keys:
                # Check if the null entry (thai_key) contains a translated sub-part
                # and is not itself a translated word (e.g. "แขยง" contains "แข")
                if translated_key in thai_key and thai_key != translated_key:
                    keys_to_remove.append(thai_key)
                    break # Mark for removal and move to next null entry

    for key in keys_to_remove:
        del results[key]

    # --- End Post-processing ---
        
    print(json.dumps(results, indent=2, ensure_ascii=False))

if __name__ == "__main__":
    main()