package title

import mc.Entity
import cmd.ride as ride
import utils.PProcess
import cmd.java.data as data
import cmd.gamemode as gm
from mc.sprite import _
import mc.java.display.DisplayBlock
import mc.java.display.DisplayText
import mc.wasd as wasd
import mc.Click as Click
import cmd.sound as sound
import maps.theblueman003.screen as screen
import game

/forceload add -40 -1000 40 -1000
game.initPlayer{
    gm.adventure()
    launch()
}

def lazy makeCharacterDoll(string name){
    if (Compiler.isJava()){
        lazy var file = "lib/theblueman_screen/java_resourcepack/assets/minecraft/textures/item/credit_character_"+name+".png"
        lazy var exists = File.exists(file)
        if (exists){
        }
        else{
            lazy var cmd = "python lib/theblueman_screen/java_resourcepack/assets/minecraft/textures/item/credit_character_generator.py "+name
            Compiler.print("Downloading character: "+name)
            File.run(cmd)
        }
    }
}

class GameTitle extends Sprite{
    def this(){
        setTexture(addTextureVertical("title"))
        setScale(5,5,5)
    }
}
class Controlls extends Sprite{
    def this(){
        setTexture(addTextureVertical("menu_control"))
        setScale(2,2,2)
    }
}
class Version extends DisplayText{
    def this(){
        setScale(0.5,0.5,0.5)
        setBackgroundColor(0)
    }
    def update(){
        setText("v"+Compiler.getProjectVersionMajor()+"." +Compiler.getProjectVersionMinor() + "." + Compiler.getProjectVersionPatch())
    }
}
class Minecart extends Entity with minecraft:item_display for mcjava{
    def this(){
        data.set({NoGravity:1b})
    }
}
class Room extends DisplayBlock{
    def this(){
        setScale(51,51,51)
        setBlock(minecraft:grass_block)
        setTranslation(-25.5, -25.5, -25.5)
    }
}
class Button extends Sprite{
    DisplayText name
    void=>void action
    int index
    int state
    def this(string text, void=>void func){
        setTexture(addTextureVertical("button"))
        setScale(2,0.5,1)
        at(~~-0.15~0.02)name = new DisplayText(text)
        name.setBackgroundColor(0)
        action = func
        index = button_count
        button_count++
    }
    def virtual select(){
        setTexture(addTextureVertical("button_selected"))
    }
    def virtual unselect(){
        setTexture(addTextureVertical("button"))
    }
    def virtual grow(){
        interpolateScale(10, 2.5,0.75,1)
        name.interpolateScale(10, 1.25,1.25,1.25)
    }
    def virtual shrink(){
        interpolateScale(5, 2,0.5,1)
        name.interpolateScale(5, 1,1,1)
    }
    def update(){
        if (index == button_selected % button_count){
            if (state == 0){
                grow()
                state = 1
                with(@a,true)sound.play(minecraft:ui.button.click)
            }
            select()
        }
        else{
            unselect()
            if (state == 1){
                shrink()
                state = 0
            }
        }
    }
    def remove(){
        name.run{
            ./kill
        }
        ./kill
    }
}
class CreditButton extends Button{
    void=>void selectImage
    void=>void unselectImage
    def lazy this(string texture, string text, void=>void func){
        makeCharacterDoll(texture)
        setTexture(addTextureVertical("credit_character_"+texture))
        selectImage = () => {
            setTexture(addTextureVertical("credit_character_"+texture+"_selected"))
        }
        unselectImage = () => {
            setTexture(addTextureVertical("credit_character_"+texture))
        }
        setScale(1,1,1)
        at(~~-0.75~0.02)name = new DisplayText(text)
        name.setBackgroundColor(0)
        action = func
        index = button_count
        button_count++
    }
    def override select(){
        selectImage()
    }
    def override unselect(){
        unselectImage()
    }
    def override grow(){
        interpolateScale(10, 1.25,1.25,1.25)
        name.interpolateScale(10, 1.25,1.25,1.25)
    }
    def override shrink(){
        interpolateScale(5, 1,1,1)
        name.interpolateScale(5, 1,1,1)
    }
}
int button_count
int button_selected
scoreboard Minecart minecart
PProcess main{
    float t
    Room room
    GameTitle title
    Version version
    Controlls controlls
    def main(){
        if (gm.isAdventure()){
            with(player.Background)update(t)
            t+=0.1

            [nbt="Rotation[0]"] scoreboard json rotx
            [nbt="Rotation[1]"] scoreboard json roty

            int rx = rotx
            int ry = roty

            if (rx != 180 && rx != -180){
                /tp @s ~ ~ ~ -180 0
            }
            if (ry != 0){
                /tp @s ~ ~ ~ -180 0
            }

            Minecart m = minecart
            m.run{
                /tp @s 1000 100 -1000
            }
            ride.ride(m)

            with(Button)update()
            version.update()
        }
    }
    def onJoin(){
        minecart = new Minecart()
        room = new Room()
    }
    def onLeave(){
        ride.dismount()
        minecart.run{
            ./kill
        }
        room.run{
            ./kill
        }
        title.run{
            ./kill
        }
        version.run{
            ./kill
        }
        controlls.run{
            ./kill
        }
        with(Button)remove()
    }
    def closeHint(){
        controlls.run{
            ./kill
        }
    }
    def showHint(){
        at(~-4~-2~)controlls = new Controlls()
    }
    def init(){
        title = new GameTitle()
        at(~2~-0.5~0.02)version = new Version()
        at(~-4~-2~)controlls = new Controlls()
    }
    def onStop(){
        with(player.Background)./kill
        detect.stop()
        click.stop()
    }
}
wasd.WASD detect{
    def onPressW(){
        button_selected--
    }
    def onPressS(){
        button_selected++
    }
    def onPressA(){
        button_selected--
    }
    def onPressD(){
        button_selected++
    }
}
Click click{
    def onRelease(){
        with(Button){
            if (index == button_selected % button_count){
                action()
            }
        }
    }
}
def initMenu(void=>void func){
    button_count = 0
    button_selected = 0
    with(Button)remove()
    at(1000 100 -1000){
        func()
    }
}
def openMain(){
    initMenu{
        at({~,102,~-4})main.showHint()
        at({~,101.5,~-4})new Button("Start"){
            as(@a)main.stop()
            title_sequence.launch()
        }
        at({~,100.5,~-4})new Button("Setting"){openSetting()}
        at({~,99.5,~-4})new Button("Info"){openCredit()}
    }
}
def openSetting(){
    main.closeHint()
    initMenu{
        at({~,101.5,~-4})new Button("Language"){cycleLangauge()}
        at({~,100.5,~-4})new Button("Back"){openMain()}
    }
}
def openCredit(){
    main.closeHint()
    initMenu{
        at({~-4,101.5,~-5})new CreditButton("theblueman003", "TheblueMan003"){
            standard.print(("===[TheblueMan003]===", "gold", "bold"))
            standard.print(("Map Creator", "yellow"))
        }
        at({~-2,101.5,~-5})new CreditButton("benjamin874", "Benjamin874"){
            standard.print(("===[Benjamin874]===", "gold", "bold"))
            standard.print(("Background Artist", "yellow"))
        }
        at({~0,101.5,~-5})new CreditButton("spookyng", "SpookyNG"){
            standard.print(("===[SpookyNG]===", "gold", "bold"))
            standard.print(("Tester", "yellow"))
            standard.print(("Translation", "yellow"))
        }
        at({~2,101.5,~-5})new CreditButton("nutt_j", "Nutt_J"){
            standard.print(("===[Nutt_J]===", "gold", "bold"))
            standard.print(("Tester", "yellow"))
            standard.print(("Translation", "yellow"))
        }
        at({~4,101.5,~-5})new CreditButton("kubababilon", "KubaBabilon"){
            standard.print(("===[KubaBabilon]===", "gold", "bold"))
            standard.print(("Translation", "yellow"))
        }
        at({~,99.5,~-4})new Button("Back"){openMain()}
    }
}

def launch(){
    with(@a){
        /tp @s 1000 100 -1000
        gm.adventure()
    }
    while(!loaded(1000 100 -1000)){
        sleep 1
    }
    with(@p,true){
        main.start()
        detect.start()
        click.start()
        at({~,100,~-4})player.loadBackground(0, 6)
        at({~,103,~-4})main.init()
        openMain()
    }
}

import game.language as lang
int lang2 := 0
def cycleLangauge(){
    lang2++
    lang2 %= 3
    lang.setLanguage(lang2)
    lang.print(info.infos, "language_set")
}