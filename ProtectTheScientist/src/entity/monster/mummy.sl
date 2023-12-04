package entity.monster.mummy

lazy Animation down = addAnimation([addTexture("spr_mummy_down_0"), addTexture("spr_mummy_down_1"), addTexture("spr_mummy_down_2"), addTexture("spr_mummy_down_3")], 2)
lazy Animation up = addAnimation([addTexture("spr_mummy_up_0"), addTexture("spr_mummy_up_1"), addTexture("spr_mummy_up_2"), addTexture("spr_mummy_up_3")], 2)
lazy Animation left = addAnimation([addTexture("spr_mummy_left_0"), addTexture("spr_mummy_left_1"), addTexture("spr_mummy_left_2"), addTexture("spr_mummy_left_3")], 2)
lazy Animation right = addAnimation([addTexture("spr_mummy_right_0"), addTexture("spr_mummy_right_1"), addTexture("spr_mummy_right_2"), addTexture("spr_mummy_right_3")], 2)

class Mummy extends Monster{
    def override onTick(){
        super.onTick()
        moveTowardCenter(right, up, left, down)
        damageNear(6, 1)
    }
    def override onInit(){
        setSize(3)
        speed = 4
        setHealth(40)
    }
    def override onDeath(){
        objects.coin.drop(10,16)
    }
}