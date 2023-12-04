package maps.theblueman003.title

from mc.sprite import _
import utils.Process
import cmd.gamemode as gm
import cmd.spectate as spectate
import cmd.effect as effect
import cmd.sound as sound
import mc.java.display.DisplayText

class Title extends Sprite{}

class Background extends Title{
    def this(){
        setTexture(addTextureVertical("theblueman003_title/black"))
        setScale(50,50,50)
    }
}
class TextBack extends Title{
    def this(){
        setTexture(addTextureVertical("theblueman003_title/title_2"))
        setScale(0,0,20)
    }
    def step1(){
        interpolateScale(20,19.20,10.80,20)
    }
    def step2(){
        interpolateScale(10,0,0,20)
    }
}
class Light extends Title{
    def this(){
        setTexture(addTextureVertical("theblueman003_title/title_1"))
        setScale(19.20,10.80,20)
    }
    def step2(){
        interpolateTranslation(50, 40, 0, 0)
    }
}
class Hidder extends Title{
    def this(){
        setTexture(addTextureVertical("theblueman003_title/title_0"))
        setScale(0,0,20)
    }
    def step1(){
        interpolateScale(20,19.20,10.80,20)
    }
    def step2(){
        interpolateScale(10,0,0,20)
    }
}
class StarLightIcon extends Title{
    def this(){
        setTexture(addTextureVertical("theblueman003_title/starlight"))
        setScale(0,0,20)
    }
    def step1(){
        interpolateScale(20,4,4,20)
    }
    def step2(){
        interpolateTranslation(20,-5,0,0)
    }
    def step3(){
        interpolateTranslation(10,0,0,0)
    }
    def step4(){
        interpolateScale(10,0,0,20)
    }
}

def lazy launch(mcposition pos, void=>void callback){
    with(@a){
        Compiler.insert($pos, pos){
            /tp @s $pos
        }
        gm.spectator()
    }
    while(!loaded(pos)){
        sleep 1
    }
    with(@p,true){
        spec.start()
        phase1(){
            callback()
        }
    }
}
def phase1(void=>void callback){
    DisplayText starLightTitle
    DisplayText starLightSubTitle

    with(Title)./kill
    at(~~2~-9.01)new Background()
    at(~~2~-9)new TextBack()
    at(~-20~2~-8.98)new Light()
    at(~~2~-8.96)new Hidder()
    at(~~2~-8.98)new StarLightIcon()
    at(~2~3~-8.98)starLightTitle = new DisplayText()
    at(~1.5~~-8.98)starLightSubTitle = new DisplayText()
    at(~34.6~2~-8.96)new Background()
    at(~-34.6~2~-8.96)new Background()
    sleep 20
    with(TextBack)step1()
    with(Hidder)step1()
    sleep 20
    with(Light)step2()
    sleep 70
    with(TextBack)step2()
    with(Hidder)step2()
    sleep 30
    with(StarLightIcon)step1()
    sleep 20
    with(StarLightIcon)step2()
    sleep 30
    starLightTitle.setScale(4,4,4)
    starLightTitle.setBackgroundColor(0)
    starLightTitle.setText("Made with StarLight")

    starLightSubTitle.setScale(1.5,1.5,1.5)
    starLightSubTitle.setBackgroundColor(0)
    starLightSubTitle.setText("More information about the Compiler at:\nhttps://github.com/TheblueMan003/StarLight")
    starLightSubTitle.setLeft()
    starLightSubTitle.setLineWidth(10000)
    sleep 100
    with(StarLightIcon)step3()
    starLightSubTitle.setText("")
    starLightTitle.setText("")
    sleep 10
    with(StarLightIcon)step4()
    sleep 20
    spec.stop()
    with(Title)./kill
    starLightTitle = null
    starLightSubTitle = null
    callback()
}
Process spec{
    def main(){
        with(@a)spectate.spectate(@e[tag=title.camera,limit=1,sort=random])
    }
    def onStart(){
        ./summon armor_stand ~ ~ ~ {Tags:["title.camera"],Rotation: [180f,0f], NoGravity:1, Invisible:1}
        ./summon armor_stand ~ ~ ~ {Tags:["title.camera"],Rotation: [180f,0f], NoGravity:1, Invisible:1}
    }
    def onStop(){
        with(@e[tag=title.camera])./kill
    }
}
