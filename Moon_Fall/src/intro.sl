package intro

from mc.sprite import _
import utils.Process
import cmd.gamemode as gm
import cmd.spectate as spectate
import mc.resourcespack.sound as rpsound
import cmd.sound as sound
import mc.java.display.DisplayBlock

lazy val shock = rpsound.add("sfx/shockwave")
lazy val explode = rpsound.add("sfx/explode")
lazy val charging_up = rpsound.add("sfx/charging_up")
lazy val shoot = rpsound.add("sfx/shoot")

class Intro extends Sprite{}

class Background extends Intro{
    def this(){
        setTexture(addTextureVertical("intro_back"))
        setScale(20,20,20)
    }
}

class LukeBlue extends Intro{
    def this(){
        setAnimation(addAnimation([addTextureVertical("spr_blue_walk_right_"+i) for i in 0..3], 2, true))
        setScale(2,2,2)
    }
    def idle(){
        setAnimation(addAnimation([addTextureVertical("spr_blue_left_idle")], 2, true))
    }
    def shoot(){
        setAnimation(addAnimation([addTextureVertical("spr_blue_sky_buster")], 2, true))
    }
}
class Tom extends Intro{
    def this(){
        setAnimation(addAnimation([addTextureVertical("spr_tom_walk_right_"+i) for i in 0..3], 2, true))
        setScale(2,2,2)
    }
    def idle(){
        setAnimation(addAnimation([addTextureVertical("spr_tom_walk_right_0")], 2, true))
    }
    def walk(){
        setAnimation(addAnimation([addTextureVertical("spr_tom_walk_right_"+i) for i in 0..3], 2, true))
    }
}
class Charge extends Intro{
    def this(){
        setAnimation(addAnimation([addTextureVertical("teleport_start_"+i) for i in 0..5], 2, true))
        setScale(2,2,2)
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
class Release extends Intro{
    def this(){
        setAnimation(addAnimation([addTextureVertical("thunder_land_"+i) for i in 0..6], 2, false))
        setScale(6,6,6)
    }
}
class White extends Intro{
    def this(){
        setAnimation(addAnimation([addTextureVertical("white")], 2, true))
        setScale(100,100,100)
    }
}
class Beam extends Intro{
    def this(){
        setAnimation(addAnimation([addTextureVertical("beam_"+i) for i in 0..3], 2, true))
        setScale(4,4,4)
    }
}
class ExplosionParticle extends Particle{
    def  __init__(){
        setAnimation(addAnimation([addTextureVertical("spr_explosion_"+i) for i in 0..10], 5, true))
        setCenterBillboard()
        setScale(4, 4, 4)
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
class Room extends DisplayBlock{
    def this(){
        setScale(30,51,51)
        setBlock(minecraft:grass_block)
        setTranslation(-15, -25.5, -25.5)
    }
}
def launch(){
    with(@a){
        /tp @s 0 256 -1000
        /ride @s dismount
        gm.spectator()
    }
    while(!loaded(0 256 -1000)){
        sleep 1
    }
    with(@p,true){
        spec.start()
        phase1()
    }
}
def phase1(){
    int tick = 0
    with(Intro)./kill
    with(player.Background)./kill
    at(~~-2~)player.loadBackground(0, 6)
    with(player.Background)update(0)
    with(player.Moon)setTexture(addTextureVertical("moon_full"))
    at(~~3~-4.5)textbox.summon()
    new Room()
    at(~~1~-5)new Background()
    at(~-5~~-4.9)new LukeBlue()
    at(~-7~~-4.9)new Tom()
    while(tick < 60){
        with(LukeBlue, true)./tp @s ~0.1 ~ ~
        with(Tom, true)./tp @s ~0.1 ~ ~
        tick += 1
        sleep 1
    }
    with(LukeBlue, true)idle()
    with(Tom, true)idle()


    bool ret = false
    textbox.setText("intro_0", textbox.Luke)
    while(!ret){
        sleep 1
        ret = textbox.isFinished()
    }
    ret = false
    sleep 20
    textbox.setText("intro_1", textbox.Luke)
    while(!ret){
        sleep 1
        ret = textbox.isFinished()
    }
    ret = false
    sleep 20
    textbox.setText("intro_2", textbox.Luke)
    while(!ret){
        sleep 1
        ret = textbox.isFinished()
    }
    ret = false
    sleep 20
    textbox.setText("intro_3", textbox.Tom)
    while(!ret){
        sleep 1
        ret = textbox.isFinished()
    }
    ret = false
    sleep 20
    textbox.setText("intro_4", textbox.Luke)
    while(!ret){
        sleep 1
        ret = textbox.isFinished()
    }
    ret = false
    sleep 20
    textbox.setText("intro_5", textbox.Tom)
    while(!ret){
        sleep 1
        ret = textbox.isFinished()
    }
    ret = false
    sleep 20
    textbox.setText("intro_6", textbox.Luke)
    while(!ret){
        sleep 1
        ret = textbox.isFinished()
    }
    ret = false
    sleep 20

    textbox.hide()

    phase2()
}
def phase2(){
    int tick = 0
    with(Charge)./kill
    with(Wind)./kill
    with(WindBack)./kill
    with(LukeBlue, true){
        shoot()
        at(~0.5~0.5~-0.02)new Charge()
        at(~~-1~-0.02)new WindBack()
        at(~~-1~0.02)new Wind()
    }
    sleep 2
    with(Charge, true)interpolateScale(200, 4, 4, 4)

    with(@a,true)sound.play(charging_up)
    
    sleep 20
    with(Tom, true)walk()
    while(tick < 60){
        with(Tom, true)./tp @s ~-0.05 ~ ~
        tick += 1
        sleep 1
    }
    with(Tom, true)idle()

    bool ret = false
    textbox.setText("intro_7", textbox.Luke)
    while(!ret){
        sleep 1
        ret = textbox.isFinished()
    }
    ret = false
    sleep 20
    textbox.setText("intro_8", textbox.Luke)
    while(!ret){
        sleep 1
        ret = textbox.isFinished()
    }
    ret = false
    sleep 20

    textbox.hide()

    sleep 60

    phase3()
}

def phase3(){
    int tick = 0
    with(Charge)./kill
    with(Wind)./kill
    with(WindBack)./kill
    with(LukeBlue, true){
        at(~0.5~0.5~-0.02)new Release()
        at(~~~-0.04)new White()
        at(~2~2~-0.04)new Beam()
    }
    with(@a,true)sound.play(shock)
    sleep 20
    with(White)./kill
    with(Release)./kill

    with(@a,true)sound.play(shoot)

    sleep 60

    with(player.Moon, true){
        setTexture(addTextureVertical("moon_cracked"))
    }
    with(LukeBlue, true){
        at(~2~4~-0.12)new Release()
        for(int i = 0; i < 10; i++){
            at(~2~4~-0.13)new ExplosionParticle()
        }
    }
    with(@a,true)sound.play(explode)
    
    sleep 20
    with(Beam)./kill
    with(Release)./kill
    sleep 60
    end_dialog.start()
}

Process end_dialog{
    int index,tick
    def main(){
        if (textbox.isFinished()){
            tick++
            if (tick > 20){
                tick = 0
                index++
                switch(index){
                    1 -> textbox.setText("intro_10", textbox.Tom)
                    2 -> textbox.setText("intro_11", textbox.Luke)
                    3 -> textbox.setText("intro_12", textbox.Luke)
                    4 -> stop()
                }
            }
        }
    }
    def onStop(){
        textbox.hide()
        at(@a)at(~20 ~ ~-3)new player.Transition()
        sleep 40
        with(player.Transition)./kill
        with(@a)gm.adventure()
        spec.stop()
        rm()
        import cmd.effect as effect
        as(@a)effect.blindness()
        level.resetCount()
        level.reset()
        timer.main.start()
    }
    def onStart(){
        tick, index = 0
        textbox.setText("intro_9", textbox.Luke)
    }
}
Process spec{
    def main(){
        with(@a)spectate.spectate(@e[tag=camera,limit=1])
    }
    def onStart(){
        ./summon armor_stand ~ ~ ~ {Tags:["camera"],Rotation: [180f,0f], NoGravity:1, Invisible:1}
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