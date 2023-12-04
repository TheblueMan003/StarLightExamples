package textbox

import maps.theblueman003.Textbox
import game.language as lang

from mc.sprite import _
import utils.Process

class Background extends Sprite{
    def this(){
        setScale(8,2,0)
    }
    def hide(){
        setTexture(addTextureVertical("fly_5"))
    }
    def show(){
        setTexture(addTextureVertical("textbox"))
    }
}

class Character extends Sprite{
    def this(){
        setScale(2,2,0)
    }
    def hide(){
        setTexture(addTextureVertical("fly_5"))
    }
    def show(){
        setTexture(addTextureVertical("textbox"))
    }
}


lazy json texts = Compiler.readJson("resources/dialog_en.json", "resources/dialog_russian.json", "resources/dialog_polish.json")
Textbox.withLanguages(texts, 200)

lang.addLanguage("english")
lang.addLanguage("russian")
lang.addLanguage("polish")

Textbox box
Background background
Character character
lazy Texture Luke = addTextureVertical("talk_luke")
lazy Texture Tom = addTextureVertical("talk_tom")
lazy Texture IceMage = addTextureVertical("talk_ice_mage")
lazy Texture ElderCat = addTextureVertical("talk_elder_cat")

def summon(){
    at(~~-1~)box = new Textbox(1)
    at(~-1~~-0.1)background = new Background()
    at(~-4~~)character = new Character()
}

def remove(){
    with(box)./kill
    with(background)./kill
}

def lazy setText(string key, Texture texture){
    box.reset()
    box.display(key)
    background.show()
    character.setTexture(texture)
}
def bool isFinished(){
    return box.isFinished()
}
def hide(){
    background.hide()
    box.reset()
    box.display("empty")
    character.setTexture(addTextureVertical("fly_5"))
}
def setLanguage(int lang){
    lang.setLanguage(lang)
    //lang.print(wave.spawner.infos, "language_set")
}