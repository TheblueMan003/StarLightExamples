package fruit

lazy Animation bomb = addAnimation([addTextureVertical("spr_bomb_0"), addTextureVertical("spr_bomb_1"), addTextureVertical("spr_bomb_2"), addTextureVertical("spr_bomb_3")], 2)
lazy Animation explode = addAnimation([addTextureVertical("spr_explosion_0"), addTextureVertical("spr_explosion_1"), addTextureVertical("spr_explosion_2"), addTextureVertical("spr_explosion_3"), addTextureVertical("spr_explosion_4"), addTextureVertical("spr_explosion_5"), addTextureVertical("spr_explosion_6"), addTextureVertical("spr_explosion_7"), addTextureVertical("spr_explosion_8"), addTextureVertical("spr_explosion_9"), addTextureVertical("spr_explosion_10")], 2, false)

class Bomb extends objects.Cutable{
    def override onInit(){
        setAnimation(bomb)
        setScale(1.5, 1.5, 1)
    }
    def override onCut(int strength){
        with(@a,true)sound.play(minecraft:entity.generic.explode,1,1.5)
        new Explosion(new Vector2Int(0, 0), explode)
        with(@a in player.cutter,true)player.die()
        /kill
    }
}

class Explosion extends Sprite{
    int tick
    def override lazy __init__(Vector2Int a, Animation tex){
        setAnimation(tex)
        setScale(4, 4, 1)
        at(@s)./tp ~ ~ ~-0.1
    }
    def @tick(){
        tick++
        if (tick == 10){
            interpolateScale(20, 0, 0, 1)
        }
        if(tick > 30){
            /kill
        }
    }
}