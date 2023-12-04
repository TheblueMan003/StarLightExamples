package info

import mc.Entity
import cmd.java.data as data
import cmd.gamemode as gm
from mc.sprite import _
import mc.java.display.DisplayText
import mc.Click as Click
import game.language as lang
import cmd.sound as sound
import utils.PProcess

lazy json infos = Compiler.readJson("resources/info_en.json", "resources/info_russian.json", "resources/info_polish.json")

interface InfoBox{
}
class InfoBoxBackground extends Sprite implements InfoBox{
    def this(){
        setTexture(addTextureVertical("info_box"))
        setScale(5,5,5)
    }
}
class InfoBoxImage extends Sprite implements InfoBox{
    def lazy this(string image){
        setTexture(addTextureVertical(image))
        setScale(5,5,5)
    }
}
class InfoBoxText extends DisplayText implements InfoBox{
    def lazy this(string text){
        setText(text)
        setBackgroundColor(0)
    }
}

bool isShowing

def lazy show(string key){
    isShowing = true
    with(@p)click.start()
    with(@a,true)sound.play(minecraft:block.note_block.bell)
    at(~~1~10){
        at(~~~-5)new InfoBoxBackground()
        at(~~~-4.98)new InfoBoxImage("info_"+key)
        def lazy make(json info){
            at(~~-2~-4.96)new InfoBoxText(info["info_"+key])
            at(~~2~-4.98)new InfoBoxText((info["info_how_to_play"], "bold"))
        }
        lang.forEach(infos, make)
    }
}
def showJump(){
    show("jump")
}
def showSpeed(){
    show("speed")
}
def showArrow(){
    show("arrow")
}
def showBar(){
    show("bar")
}
def showDoubleJump(){
    show("double_jump")
}
def showWallJump(){
    show("wall_jump")
}
def showFeatherFalling(){
    show("feather_falling")
}
def showPassThrough(){
    show("pass_through")
}
def showWind(){
    show("wind")
}
PProcess click{
    def onJoin(){
        player.holding = 0
    }
    def main(){
        if (player.holding){
            isShowing = false
            with(InfoBox){
                ./kill
            }
            stop()
        }
    }
}