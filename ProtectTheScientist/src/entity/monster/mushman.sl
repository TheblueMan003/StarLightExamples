package entity.monster.mushman

lazy Animation down = addAnimation([addTexture("spr_mushman_down_0"), addTexture("spr_mushman_down_1"), addTexture("spr_mushman_down_2"), addTexture("spr_mushman_down_3")], 2)
lazy Animation up = addAnimation([addTexture("spr_mushman_up_0"), addTexture("spr_mushman_up_1"), addTexture("spr_mushman_up_2"), addTexture("spr_mushman_up_3")], 2)
lazy Animation left = addAnimation([addTexture("spr_mushman_left_0"), addTexture("spr_mushman_left_1"), addTexture("spr_mushman_left_2"), addTexture("spr_mushman_left_3")], 2)
lazy Animation right = addAnimation([addTexture("spr_mushman_right_0"), addTexture("spr_mushman_right_1"), addTexture("spr_mushman_right_2"), addTexture("spr_mushman_right_3")], 2)

class Mushman extends Monster{
    def override onTick(){
        super.onTick()
        moveTowardCenter(right, up, left, down)
        damageNear(2, 0)
    }
    def override onInit(){
        setSize(2)
        speed = 4
        setHealth(3)
    }
    def override onDeath(){
        objects.coin.drop(2,4)
    }
}