package entity.monster.slime

lazy Animation down = addAnimation([addTexture("spr_slime_down_0"), addTexture("spr_slime_down_1"), addTexture("spr_slime_down_2"), addTexture("spr_slime_down_3"), addTexture("spr_slime_down_4")], 2)
lazy Animation up = addAnimation([addTexture("spr_slime_up_0"), addTexture("spr_slime_up_1"), addTexture("spr_slime_up_2"), addTexture("spr_slime_up_3"),  addTexture("spr_slime_up_4")], 2)
lazy Animation left = addAnimation([addTexture("spr_slime_left_0"), addTexture("spr_slime_left_1"), addTexture("spr_slime_left_2"), addTexture("spr_slime_left_3"), addTexture("spr_slime_left_4")], 2)
lazy Animation right = addAnimation([addTexture("spr_slime_right_0"), addTexture("spr_slime_right_1"), addTexture("spr_slime_right_2"), addTexture("spr_slime_right_3"), addTexture("spr_slime_right_4")], 2)


class Slime extends Monster{
    def override onTick(){
        super.onTick()
        moveTowardCenter(right, up, left, down)
        damageNear(2, 0)
    }
    def override onInit(){
        setSize(1.5)
        setHealth(2)
    }
    def override onDeath(){
        at(~1~~){
            new mini_slime.MiniSlime()
        }
        new mini_slime.MiniSlime()
    }
}