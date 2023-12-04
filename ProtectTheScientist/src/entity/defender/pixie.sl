package entity.defender.pixie

lazy Animation down = addAnimation([addTexture("spr_pixie_down_0"), addTexture("spr_pixie_down_1"), addTexture("spr_pixie_down_2"), addTexture("spr_pixie_down_3")], 2)
lazy Animation up = addAnimation([addTexture("spr_pixie_up_0"), addTexture("spr_pixie_up_1"), addTexture("spr_pixie_up_2"), addTexture("spr_pixie_up_3")], 2)
lazy Animation left = addAnimation([addTexture("spr_pixie_left_0"), addTexture("spr_pixie_left_1"), addTexture("spr_pixie_left_2"), addTexture("spr_pixie_left_3")], 2)
lazy Animation right = addAnimation([addTexture("spr_pixie_right_0"), addTexture("spr_pixie_right_1"), addTexture("spr_pixie_right_2"), addTexture("spr_pixie_right_3")], 2)

class Pixie extends Defender{
    int healDelay
    int spin
    def override onTick(){
        super.onTick()
        healDelay++
        if (healDelay > 60 - speedUpgrade*5){
            int inc = attackUpgrade
            with (@e[distance=..2] in defender.Defender){
                heal(1 + inc)
            }
            healDelay = 0
        }
        if (!isMoving){
            if(spin == 0){
                moveRight()
            }else if(spin == 1){
                moveUp()
            }else if(spin == 2){
                moveLeft()
            }else if(spin == 3){
                moveDown()
            }
            spin += 1
            spin %= 4
        }
    }
    def override onInit(){
        setSize(1)
        healDelay = 0
        setHealth(12)
        setAnimation(down)
    }
    override int getNameIndex(){
        return 3
    }
}

(int, int) getNearest(){
    with(@e[sort=nearest, limit=1] in Pixie){
        return getPos()
    }
}