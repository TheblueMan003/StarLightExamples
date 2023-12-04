package fruit

from mc.sprite import _
import cmd.sound as sound

class FruitBase extends objects.Cutable{
    def override onCut(int strength){
        with(@a in player.cutter,true){
            sound.play(minecraft:block.note_block.harp,1,1.5)
            player.score++
        }
        /kill
    }
    def override onDestroy(){
        player.removeLife()
    }
}

class FruitCut extends objects.GameObject{
    def lazy __init__(Vector2Int vec, Texture tex){
        __init__(vec)
        setTexture(tex)
    }
}
class FruitSplat extends Sprite{
    int tick
    def override lazy __init__(Vector2Int vec, Texture tex){
        setTexture(tex)
        setScale(0, 0, 1)
        at(@s)./tp ~ ~ ~-0.1
    }
    def @tick(){
        tick++
        if (tick == 1){
            interpolateScale(2, 6, 6, 1)
        }
        if (tick == 10){
            interpolateScale(40, 0, 0, 1)
        }
        at(@s)./tp ~ ~ ~-0.001
        if(tick > 50){
            /kill
        }
    }
}