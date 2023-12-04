import json

lang = input("language: ")

with open("raw_"+lang+".txt", "r", encoding="utf-8") as f:
    lines = f.readlines()

with open("text.json", "r", encoding="utf-8") as f:
    data = json.load(f)

data[lang] = {
    "language_set": lines[1].strip(),
    "word_found_self": lines[2].strip(),
    "word_found_other": lines[3].strip(),
    "time_warning_1min": lines[4].strip(),
    "time_warning_30sec": lines[5].strip(),
    "time_warning_10sec": lines[6].strip(),
    "scores": lines[7].strip(),
    "word": lines[8].strip(),
    "word_was": lines[9].strip(),
    "free_mod": lines[10].strip(),
    "words": []
}
data[lang]["words"] = [i.strip() for i in set(lines[13:])]

with open("text.json", "w", encoding="utf-8") as f:
    json.dump(data, f, indent=4, ensure_ascii=False)
