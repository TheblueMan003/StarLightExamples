package text

import game.language as lang

lazy json text = Compiler.readJson("resources/text.json")

lang.addLanguage("english")
lang.addLanguage("chinese")
lang.addLanguage("dutch")
lang.addLanguage("french")
lang.addLanguage("persian")
lang.addLanguage("russian")
lang.addLanguage("polish")
lang.addLanguage("korean")