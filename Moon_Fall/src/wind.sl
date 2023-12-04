package wind

from mc.sprite import _

class Handler{
    int tick
    def this(){
    }
    def @tick(){
        tick++
        if (tick %40 == 0 && @a[distance=..50]){
            new Wind()
        }
    }
}
class Wind extends Sprite{
    int tick
    def this(){
        setAnimation(addAnimation([addTextureVertical("wind_"+i) for i in 0..19], 1, true))
        setScale(2,4,0)
        align("xyz")./tp @s ~ ~ ~0.9
    }
    def @tick(){
        /tp @s ~ ~0.2 ~
        tick ++
        if (tick > 300){
            ./kill
        }
    }
}

def summon(){
    new Handler()
}
def remove_near(){
    with(@e[distance=..2] in Handler){
        ./kill
    }
}
