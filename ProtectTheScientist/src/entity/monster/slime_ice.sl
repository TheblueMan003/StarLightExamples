package entity.monster.ice_slime


lazy Animation down = addAnimation([addTexture("spr_ice_slime_down_0"), addTexture("spr_ice_slime_down_1"), addTexture("spr_ice_slime_down_2"), addTexture("spr_ice_slime_down_3"), addTexture("spr_ice_slime_down_4")], 2)
lazy Animation up = addAnimation([addTexture("spr_ice_slime_up_0"), addTexture("spr_ice_slime_up_1"), addTexture("spr_ice_slime_up_2"), addTexture("spr_ice_slime_up_3"),  addTexture("spr_ice_slime_up_4")], 2)
lazy Animation left = addAnimation([addTexture("spr_ice_slime_left_0"), addTexture("spr_ice_slime_left_1"), addTexture("spr_ice_slime_left_2"), addTexture("spr_ice_slime_left_3"), addTexture("spr_ice_slime_left_4")], 2)
lazy Animation right = addAnimation([addTexture("spr_ice_slime_right_0"), addTexture("spr_ice_slime_right_1"), addTexture("spr_ice_slime_right_2"), addTexture("spr_ice_slime_right_3"), addTexture("spr_ice_slime_right_4")], 2)


class IceSlime extends Monster{
    def override onTick(){
        super.onTick()
        moveTowardCenter(right, up, left, down)
        damageNear(4, 2)
    }
    def override onInit(){
        setSize(1.5)
        setHealth(10)
        speed = 2
    }
    def override onDeath(){
        at(~1~~){
            new mini_ice_slime.MiniIceSlime()
        }
        at(~~~1){
            new mini_ice_slime.MiniIceSlime()
        }
        at(~1~~1){
            new mini_ice_slime.MiniIceSlime()
        }
        new mini_ice_slime.MiniIceSlime()
    }
}