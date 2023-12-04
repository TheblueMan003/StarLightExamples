package entity.monster.red_mage

import random.LCG as random
import mc.java.nbt as nbt


lazy Animation down = addAnimation([addTexture("spr_mage_red_down")], 2)
lazy Animation up = addAnimation([addTexture("spr_mage_red_up")], 2)
lazy Animation left = addAnimation([addTexture("spr_mage_red_left")], 2)
lazy Animation right = addAnimation([addTexture("spr_mage_red_right")], 2)

lazy Animation down_charge = addAnimation([addTexture("spr_mage_red_down_cast_0"), addTexture("spr_mage_red_down_cast_1")], 5)
lazy Animation up_charge = addAnimation([addTexture("spr_mage_red_up_cast_0"), addTexture("spr_mage_red_up_cast_0")], 5)
lazy Animation left_charge = addAnimation([addTexture("spr_mage_red_left_cast_0"), addTexture("spr_mage_red_left_cast_0")], 5)
lazy Animation right_charge = addAnimation([addTexture("spr_mage_red_right_cast_0"), addTexture("spr_mage_red_right_cast_0")], 5)

lazy Animation mini_star = addAnimation([addTexture("spr_mini_star_0"), addTexture("spr_mini_star_1")], 2)


class RedMage extends Monster{
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
                    if (random.range(0,2) == 0){
                        new Spell()
                    }
                    else{
                        int x = random.range(-14,15)
                        int z = random.range(-9,10)

                        nbt.x = x
                        nbt.z = z
                    }
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
        damage = 4
        damageType = 3
        setAnimation(mini_star)
    }
}