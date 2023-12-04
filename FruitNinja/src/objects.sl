package objects

import math.Vector2Int
import standard::print
import mc.sprite::Sprite

int gravity = 3


class GameObject extends Sprite{
    Vector2Int speed
    int age
    def __init__(Vector2Int motion){
        speed = motion
        onInit()
        setScale(1.5,1.5,0)
        setTeleportDuration(1)
    }
    def @tick(){
        at(@s){
            switch(speed.x){
                foreach(x in -100..100){
                    x -> {
                        Compiler.insert($x, x/100.0){
                            /tp @s ~$x ~ ~
                        }
                    }
                }
            }
        }
        at(@s){
            switch(speed.y){
                foreach(y in -100..100){
                    y -> {
                        Compiler.insert($y, y/100.0){
                            /tp @s ~ ~$y ~
                        }
                    }
                }
            }
        }
        speed.y = math.clamp(-100, 100, speed.y - gravity)
        if (block(~ ~ -1, minecraft:red_concrete)){
            onDestroy()
            /kill
        }
    }
    def virtual onDestroy(){
    }
    def virtual onInit(){
    }
}
class Cutable extends GameObject{
    def virtual onCut(int strength){
    }
}