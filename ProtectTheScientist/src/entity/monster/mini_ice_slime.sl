package entity.monster.mini_ice_slime

lazy Animation down = addAnimation([addTexture("spr_ice_slime_mini_down_0"), addTexture("spr_ice_slime_mini_down_1")], 5)
lazy Animation up = addAnimation([addTexture("spr_ice_slime_mini_up_0"), addTexture("spr_ice_slime_mini_up_1")], 5)
lazy Animation left = addAnimation([addTexture("spr_ice_slime_mini_left_0"), addTexture("spr_ice_slime_mini_left_1")], 5)
lazy Animation right = addAnimation([addTexture("spr_ice_slime_mini_right_0"), addTexture("spr_ice_slime_mini_right_1")], 5)

class MiniIceSlime extends Monster{
    def override onTick(){
        super.onTick()
        moveTowardCenter(right, up, left, down)
        damageNear(3, 2)
    }
    def override onInit(){
        setHealth(10)
        speed = 3
    }
    def override onDeath(){
        objects.coin.drop(5,7)
    }
}