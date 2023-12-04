package deco

from mc.sprite import _

class Deco extends Sprite{
    def lazy this(int width, int height){
        setScale(width/16.0, height/16.0, 1)
        align("xyz")at({~,~height/32.0,~})./tp @s ~ ~ ~0.99
    }
}
class SignLeft extends Deco{
    def @decotick(){
        setAnimation(addAnimation([addTextureVertical("sign_arrow_left")], 100, true))
    }
}
class SignRight extends Deco{
    def @decotick(){
        setAnimation(addAnimation([addTextureVertical("sign_arrow_right")], 100, true))
    }
}
class SignUp extends Deco{
    def @decotick(){
        setAnimation(addAnimation([addTextureVertical("sign_arrow_up")], 100, true))
    }
}
class SignDown extends Deco{
    def @decotick(){
        setAnimation(addAnimation([addTextureVertical("sign_arrow_down")], 100, true))
    }
}
class OakLeave extends Particle{
    def __init__(){
        setAnimation(addAnimation([addTextureVertical("oak_leave")], 2, true))
        setScale(0.5, 0.5, 0.5)
        float x = random.rangeFloat(0.1,0.4)
        float y = random.rangeFloat(-0.1,-0.01)
        this.motion = new(x, y, 0)
        this.acceleration = new(0, -0.01, 0)
    }
}
class OakTree extends Deco{
    def @decotick(){
        setAnimation(addAnimation([addTextureVertical("oak_tree")], 100, true))
        if (@a[distance=..30]){
            int rng = random.range(0, 100)
            if (rng < 2){
                switch(random.range(0,4) for y in 0..10){
                    y -> at({~,~y,~0.02})new OakLeave()
                }
            }
        }
    }
}
class PineTree extends Deco{
    def @decotick(){
        setAnimation(addAnimation([addTextureVertical("pine_tree")], 100, true))
    }
}
class PineSkyTree extends Deco{
    def @decotick(){
        setAnimation(addAnimation([addTextureVertical("pine_sky_tree")], 100, true))
    }
}
class FlowerBlue extends Deco{
    def @decotick(){
        setAnimation(addAnimation([addTextureVertical("flower_blue")], 100, true))
    }
}
class FlowerCloud extends Deco{
    def @decotick(){
        setAnimation(addAnimation([addTextureVertical("flower_cloud")], 100, true))
    }
}
class FlowerLavender extends Deco{
    def @decotick(){
        setAnimation(addAnimation([addTextureVertical("flower_lavender")], 100, true))
    }
}
class SignHumanLeft extends Deco{
    def @decotick(){
        setAnimation(addAnimation([addTextureVertical("sign_human_left")], 100, true))
    }
}
class SignHumanRight extends Deco{
    def @decotick(){
        setAnimation(addAnimation([addTextureVertical("sign_human_right")], 100, true))
    }
}
class SignHumanUp extends Deco{
    def @decotick(){
        setAnimation(addAnimation([addTextureVertical("sign_human_up")], 100, true))
    }
}
class SignHumanDown extends Deco{
    def @decotick(){
        setAnimation(addAnimation([addTextureVertical("sign_human_down")], 100, true))
    }
}
class SignStop extends Deco{
    def @decotick(){
        setAnimation(addAnimation([addTextureVertical("sign_stop")], 100, true))
    }
}

class TrafficLight extends Deco{
    def @decotick(){
        setAnimation(addAnimation([addTextureVertical("traffic_light_"+i) for i in 0..3], 60, true))
    }
}
class WindTurbin extends Sprite{
    def lazy this(int width, int height){
        setScale(width/16.0, height/16.0, 1)
        align("xyz")at({~,~height/32.0,~})./tp @s ~ ~ ~0.995
    }
    def @decotick(){
        setAnimation(addAnimation([addTextureVertical("wind_turbine")], 60, true))
    }
}
class WindTurbinBack extends Deco{
    def @decotick(){
        setAnimation(addAnimation([addTextureVertical("wind_turbine_back")], 60, true))
    }
}

def kill_all(){
    with(Deco){
        /kill @s
    }
}
def remove_near(){
    with(@e[distance=..2] in Deco){
        /kill @s
    }
}
def wind_turbin(){
    new WindTurbinBack(32, 128)
    at(~~-1~0.02)new WindTurbin(256, 256)
}
def sign_left(){
    new SignLeft(32, 32)
}
def sign_right(){
    new SignRight(32, 32)
}
def sign_up(){
    new SignUp(32, 32)
}
def sign_down(){
    new SignDown(32, 32)
}
def oak_tree(){
    new OakTree(48, 112)
}
def pine_tree(){
    new PineTree(48, 112)
}
def pine_sky_tree(){
    new PineSkyTree(48, 112)
}
def flower_blue(){
    new FlowerBlue(16, 16)
}
def flower_cloud(){
    new FlowerCloud(16, 16)
}
def flower_lavender(){
    new FlowerLavender(16, 22)
}
def sign_human_left(){
    new SignHumanLeft(16, 80)
}
def sign_human_right(){
    new SignHumanRight(16, 80)
}
def sign_human_up(){
    new SignHumanUp(16, 80)
}
def sign_human_down(){
    new SignHumanDown(16, 80)
}
def sign_stop(){
    new SignStop(16, 80)
}
def traffic_light(){
    new TrafficLight(16, 80)
}

def @tick(){
    @decotick()
}

import mc.Click
import math.raycast as rc
Click placer{
    void=>void fct
    def onClick(){
        rc.shoot(100,0.5,!block(minecraft:air)){
            if (!block(minecraft:air) && block(~~1~, minecraft:air)){
                at(~~1~)fct()
            }
        }
    }

    def setOakTree(){
        fct = oak_tree
    }
    def setPineTree(){
        fct = pine_tree
    }
    def setPineSkyTree(){
        fct = pine_sky_tree
    }
    def setFlowerBlue(){
        fct = flower_blue
    }
    def setFlowerCloud(){
        fct = flower_cloud
    }
    def setFlowerLavender(){
        fct = flower_lavender
    }
    def setSignLeft(){
        fct = sign_left
    }
    def setSignRight(){
        fct = sign_right
    }
    def setSignUp(){
        fct = sign_up
    }
    def setSignDown(){
        fct = sign_down
    }
    def setSignHumanLeft(){
        fct = sign_human_left
    }
    def setSignHumanRight(){
        fct = sign_human_right
    }
    def setSignHumanUp(){
        fct = sign_human_up
    }
    def setSignHumanDown(){
        fct = sign_human_down
    }
    def setSignStop(){
        fct = sign_stop
    }
    def setTrafficLight(){
        fct = traffic_light
    }
}