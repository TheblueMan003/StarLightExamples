package entity.monster.ice_mage

import random.LCG as random

lazy Animation down = addAnimation([addTexture("spr_mage_ice_down")], 2)
lazy Animation up = addAnimation([addTexture("spr_mage_ice_up")], 2)
lazy Animation left = addAnimation([addTexture("spr_mage_ice_left")], 2)
lazy Animation right = addAnimation([addTexture("spr_mage_ice_right")], 2)

lazy Animation down_charge = addAnimation([addTexture("spr_mage_ice_down_cast_0"), addTexture("spr_mage_ice_down_cast_1")], 5)
lazy Animation up_charge = addAnimation([addTexture("spr_mage_ice_up_cast_0"), addTexture("spr_mage_ice_up_cast_1")], 5)
lazy Animation left_charge = addAnimation([addTexture("spr_mage_ice_left_cast_0"), addTexture("spr_mage_ice_left_cast_1")], 5)
lazy Animation right_charge = addAnimation([addTexture("spr_mage_ice_right_cast_0"), addTexture("spr_mage_ice_right_cast_1")], 5)

lazy Animation mini_star = addAnimation([addTexture("spr_mini_star_0"), addTexture("spr_mini_star_1")], 2)


class IceMage extends Monster{
    int step
    def override onTick(){
        super.onTick()
        if (!isMoving){
            step++
            if (step < 5){
                moveTowardCenter(right, up, left, down)
            }
            else if (step == 6){
                setDirectionalAnimation(right_charge, up_charge, left_charge, down_charge)
            }
            else if (step > 66){
                step = 0
                at(~ ~-0.51 ~){
                    new Spell()
                }
            }
        }
    }
    def override onInit(){
        setSize(3)
        step = random.range(0, 5)
        setHealth(30)
        speed = 2
    }
    def override onDeath(){
        objects.coin.drop(4,6)
    }
}
class Spell extends MonsterProjectile{
    def override onInit(){
        speed = 4
        damage = 2
        damageType = 2
        setAnimation(mini_star)
    }
}