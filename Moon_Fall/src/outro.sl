package outro

from mc.sprite import _
import utils.Process
import cmd.gamemode as gm
import cmd.spectate as spectate
import mc.resourcespack.sound as rpsound
import cmd.sound as sound
import mc.java.display.DisplayBlock

lazy val shine = rpsound.add("sfx/shine")
class Intro extends Sprite{}

class Background extends Intro{
    def this(){
        setTexture(addTextureVertical("outro_back"))
        setScale(20,20,20)
    }
}

class LukeBlue extends Intro{
    def this(){
        setAnimation(addAnimation([addTextureVertical("spr_blue_walk_right_"+i) for i in 0..3], 2, true))
        setScale(2,2,2)
    }
    def idle(){
        setAnimation(addAnimation([addTextureVertical("spr_blue_walk_right_0")], 2, true))
    }
    def tose(){
        setAnimation(addAnimation([addTextureVertical("spr_blue_tose_"+i) for i in 0..5], 2, false))
    }
}
class IceMage extends Intro{
    def this(){
        setAnimation(addAnimation([addTextureVertical("ice_mage_back")], 2, true))
        setScale(2,2,2)
    }
    def left(){
        setAnimation(addAnimation([addTextureVertical("ice_mage_left")], 2, true))
    }
    def right(){
        setAnimation(addAnimation([addTextureVertical("ice_mage_right")], 2, true))
    }
    def front(){
        setAnimation(addAnimation([addTextureVertical("ice_mage_front")], 2, true))
    }
    def cast(){
        setAnimation(addAnimation([addTextureVertical("ice_mage_cast_"+i) for i in 0..1], 2, true))
    }
    def elevate(){
        interpolateTranslation(20, 0, 1, 0)
        at(~~-1~-0.02)new WindBack()
        at(~~-1~0.02)new Wind()
    }
    def fallback(){
        interpolateTranslation(10, 0, 0, 0)
        setAnimation(addAnimation([addTextureVertical("ice_mage_sit")], 2, true))
    }
}
class ElderCat extends Intro{
    def this(){
        setAnimation(addAnimation([addTextureVertical("elder_cat_left")], 2, true))
        setScale(2,2,2)
    }
}
class Book extends Intro{
    float speedY
    def this(){
        setAnimation(addAnimation([addTextureVertical("book_crystal")], 2, true))
        setScale(1,1,1)
        speedY = 0.5
    }
    def tick(){
        speedY -= 0.05
        def macro tp(float y){
            with(@s)./tp @s ~0.15 ~$(y) ~
        }
        tp(speedY)
    }
    def open(){
        setAnimation(addAnimation([addTextureVertical("book_crystal_open")], 2, true))
    }
    def elevate(){
        interpolateTranslation(20, 0, 1, 0)
    }
}
class Wind extends Intro{
    def this(){
        setAnimation(addAnimation([addTextureVertical("fly_"+i) for i in 0..5], 1, true))
        setScale(4,4,4)
    }
}
class WindBack extends Intro{
    def this(){
        setAnimation(addAnimation([addTextureVertical("fly_back_"+i) for i in 0..5], 1, true))
        setScale(4,4,4)
    }
}
class SpellParticle extends Particle{
    def  __init__(){
        setTexture(addTextureVertical("spell_particle"))
        setCenterBillboard()
        setScale(0.5, 0.5, 0.5)
        float x = random.rangeFloat(-0.2,0.2)
        float y = random.rangeFloat(-0.2,0.2)
        this.motion = new(x, y, 0)
        this.acceleration = new(0, 0, 0)
    }
    def @tick(){
        if (age == 2){
            interpolateScale(40, 0, 0, 0)
        }
    }
}
class ShieldParticle extends Particle{
    def  __init__(){
        setAnimation(addAnimation([addTextureVertical("mini_star_"+i) for i in 0..1], 2, true))
        setCenterBillboard()
        setScale(0.5, 0.5, 0.5)
        float x = random.rangeFloat(-0.2,0.2)
        float y = random.rangeFloat(-0.2,0.2)
        this.motion = new(x, y, 0)
        this.acceleration = new(0, 0, 0)
    }
    def @tick(){
        if (age == 2){
            interpolateScale(40, 0, 0, 0)
        }
    }
}

class BackgroundSpace extends Intro{
    def this(){
        setTexture(addTextureVertical("background_world_0_layer_0_part_0"))
        setScale(20,20,20)
    }
}
class Earth extends Intro{
    def this(){
        setTexture(addTextureVertical("earth"))
        setScale(8,8,8)
    }
}
class EarthShield extends Intro{
    def this(){
        setTexture(addTextureVertical("earth_shield"))
        setScale(0,0,0)
    }
    def show(){
        interpolateScale(80, 8, 8, 8)
    }
}
class MageShield extends Intro{
    def this(){
        setTexture(addTextureVertical("earth_shield"))
        setScale(0,0,0)
    }
    def show(){
        interpolateScale(80, 50, 50, 50)
    }
}
class Moon extends Intro{
    def this(){
        setTexture(addTextureVertical("moon_cracked_4"))
        setScale(4,4,4)
    }
}
class Room extends DisplayBlock{
    def this(){
        setScale(30,51,51)
        setBlock(minecraft:grass_block)
        setTranslation(-15, -25.5, -25.5)
    }
}
def launch(){
    with(@a){
        /tp @s 0 100 -1000
        gm.spectator()
    }
    while(!loaded(0 100 -1000)){
        sleep 1
    }
    with(@p,true){
        /ride @s dismount
        spec.start()
        phase1()
    }
}
def phase1(){
    int tick = 0
    with(Intro)./kill
    with(player.Background)./kill
    at(~~-2~)player.loadBackground(3, 5)
    with(player.Background)update(0)
    at(~~3~-4.5)textbox.summon()
    new Room()
    at(~~1~-5)new Background()
    at(~-7~~-4.9)new LukeBlue()
    at(~~~-4.9)new IceMage()
    at(~2~~-4.9)new ElderCat()
    at(~~2~-4.88)new MageShield()

    at(~~51~-5)new BackgroundSpace()
    at(~~51~-4.9)new Earth()
    at(~~51~-4.89)new EarthShield()
    at(~-4~55~-4.91)new Moon()



    while(tick < 40){
        with(LukeBlue, true)./tp @s ~0.1 ~ ~
        tick += 1
        sleep 1
    }
    with(LukeBlue, true)idle()
    dialog.start()
}


Process dialog{
    int tick, phase
    def onStart(){
        tick = -1
        phase = 0
    }
    bool isNew(){
        if (tick == -1){
            tick = 0
            return true
        }
        else{
            return false
        }
    }
    def next(){
        tick ++
        if (tick > 30){
            tick = -1
            phase ++
        }
    }
    def main(){
        switch(phase){
            case 0: {
                with(IceMage, true)left()
                if(isNew())textbox.setText("outro_0", textbox.ElderCat)
                if (textbox.isFinished())next()
            }
            case 1: {
                if(isNew())textbox.setText("outro_1", textbox.IceMage)
                if (textbox.isFinished())next()
            }
            case 2: {
                if(isNew())textbox.setText("outro_2", textbox.Luke)
                if (textbox.isFinished())next()
            }
            case 3: {
                if(isNew())textbox.setText("outro_3", textbox.IceMage)
                if (textbox.isFinished())next()
            }
            case 4: {
                if(isNew())textbox.setText("outro_4", textbox.IceMage)
                if (textbox.isFinished())next()
            }
            case 5: {
                if(isNew())textbox.setText("outro_5", textbox.Luke)
                if (textbox.isFinished())next()
            }
            case 6: {
                if(isNew())textbox.setText("outro_6", textbox.IceMage)
                if (textbox.isFinished())next()
            }
            case 7: {
                if(isNew())textbox.setText("outro_7", textbox.Luke)
                if (textbox.isFinished())next()
            }
            case 8: {
                if(isNew())textbox.setText("outro_8", textbox.IceMage)
                if (textbox.isFinished())next()
            }
            case 9: {
                if(isNew())textbox.setText("outro_9", textbox.IceMage)
                if (textbox.isFinished())next()
            }
            case 10: {
                with(IceMage, true)right()
                if(isNew())textbox.setText("outro_10", textbox.ElderCat)
                if (textbox.isFinished())next()
            }
            case 11: {
                if(isNew())textbox.setText("outro_11", textbox.ElderCat)
                if (textbox.isFinished())next()
            }
            case 12: {
                if(isNew())textbox.setText("outro_12", textbox.IceMage)
                if (textbox.isFinished())next()
            }
            case 13: {
                if(isNew())textbox.setText("outro_13", textbox.IceMage)
                if (textbox.isFinished())next()
            }
            case 14: {
                with(IceMage, true)left()
                if(isNew())textbox.setText("outro_14", textbox.IceMage)
                if (textbox.isFinished())next()
            }
            case 15: {
                if(isNew())textbox.setText("outro_15", textbox.Luke)
                if (textbox.isFinished())next()
            }
            case 16: {
                tick ++
                if (tick == 0){
                    textbox.hide()
                    with(LukeBlue,true){
                        tose()
                        at(~~~0.02)new Book()
                    }
                }
                if (tick < 20){
                    with(Book, true)tick()
                }
                else{
                    next()
                }
            }
            case 17: {
                with(IceMage,true)front()
                with(Book,true)open()
                if(isNew())textbox.setText("outro_16", textbox.IceMage)
                if (textbox.isFinished())next()
            }
            case 18: {
                tick ++
                if (tick == 0){
                    textbox.hide()
                    with(IceMage,true)elevate()
                    with(Book,true)elevate()
                }
                if (tick == 40){
                    with(IceMage,true)cast()
                }
                if (tick > 40){
                    with(IceMage,true)at(~~~0.02)new SpellParticle()
                }
                if (tick == 60){
                    with(MageShield)show()
                    with(@a,true)sound.play(intro.charging_up)
                }
                if (tick > 120){
                    next()
                }
            }
            case 19:{
                tick ++
                if (tick == 0){
                    with(@e[tag=camera],true)./tp @s ~ ~50 ~ ~ ~5
                }
                if (tick == 10){
                    with(Book)./kill
                    with(Wind)./kill
                    with(WindBack)./kill
                    with(MageShield)./kill
                    with(EarthShield,true)show()
                }
                if (tick == 90){
                    with(@a,true)sound.play(shine)
                }
                if (tick == 100){
                    with(EarthShield,true)at(~2~2~0.02){
                        repeat(20){
                            new ShieldParticle()
                        }
                    }
                }
                if (tick > 140){
                    with(@e[tag=camera],true)./tp @s ~ ~-50 ~ ~ ~-5
                    next()
                }
            }
            case 20: {
                with(IceMage,true)fallback()
                if(isNew())textbox.setText("outro_100", textbox.Luke)
                if (textbox.isFinished())next()
            }
            case 21: {
                if(isNew())textbox.setText("outro_101", textbox.IceMage)
                if (textbox.isFinished())next()
            }
            case 22: {
                if(isNew())textbox.setText("outro_102", textbox.IceMage)
                if (textbox.isFinished())next()
            }
            case 23: {
                if(isNew())textbox.setText("outro_103", textbox.Luke)
                if (textbox.isFinished())next()
            }
            case 24: {
                if(isNew())textbox.setText("outro_104", textbox.IceMage)
                if (textbox.isFinished())next()
            }
            case 25: {
                if(isNew())textbox.setText("outro_105", textbox.IceMage)
                if (textbox.isFinished())next()
            }
            case 26: {
                if(isNew())textbox.setText("outro_106", textbox.Luke)
                if (textbox.isFinished())next()
            }
            case 27: {
                if(isNew())textbox.setText("outro_107", textbox.Luke)
                if (textbox.isFinished())next()
            }
            case 28: {
                with(IceMage,true)left()
                if(isNew())textbox.setText("outro_108", textbox.IceMage)
                if (textbox.isFinished())next()
            }
            case 29: {
                if(isNew())textbox.setText("outro_109", textbox.IceMage)
                if (textbox.isFinished())next()
            }
            case 30: {
                if(isNew())textbox.setText("outro_110", textbox.Luke)
                if (textbox.isFinished())next()
            }
            case 31: {
                if(isNew())textbox.setText("outro_111", textbox.ElderCat)
                if (textbox.isFinished())next()
            }
            case 32: {
                if(isNew())textbox.setText("outro_112", textbox.Luke)
                if (textbox.isFinished())next()
            }
            case 33:{
                at(@a)at(~20 ~ ~-3)new player.Transition()
                if (textbox.isFinished())next()
            }
            case 34: {
                textbox.hide()
                with(player.Transition)./kill
                spec.stop()
                stop()
                rm()
                title.launch()
                timer.main.stop()
            }
        }        
    }
}
Process spec{
    def main(){
        with(@a,true)spectate.spectate(@e[tag=camera,limit=1,sort=random])
    }
    def onStart(){
        ./summon item_display ~ ~1.5 ~ {Tags:["camera"],Rotation: [180f,0f]}
        ./summon item_display ~ ~1.5 ~ {Tags:["camera"],Rotation: [180f,0f]}
    }
    def onStop(){
        with(@e[tag=camera])./kill
    }
}

def rm(){
    with(Intro)./kill
    with(Room)./kill
    with(player.Background)./kill
    textbox.remove()
}