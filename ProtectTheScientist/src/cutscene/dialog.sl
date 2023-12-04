package cutscene.dialog

import maps.theblueman003.Textbox
import game.language as lang

Textbox box

lazy json texts = Compiler.readJson("resources/text_dialog_en.sjson", "resources/text_dialog_ru.sjson", "resources/text_dialog_fr.sjson", "resources/text_dialog_nl.sjson", "resources/text_dialog_zh.sjson", "resources/text_dialog_pl.sjson")
Textbox.withLanguages(texts, 200)

lang.addLanguage("english")
lang.addLanguage("russian")
lang.addLanguage("french")
lang.addLanguage("dutch")
lang.addLanguage("chinese")
lang.addLanguage("polish")

def [compile.order = -1] summon(){
    box = new Textbox(5)
    box.setFloor()
    box.reset()
}
def dismiss(){
    box = null
}
def lazy setText(string key){
    box.display(key)
}
def bool isFinished(){
    return box.isFinished()
}
def setLanguage(int lang){
    lang.setLanguage(lang)
    lang.print(wave.spawner.infos, "language_set")
}