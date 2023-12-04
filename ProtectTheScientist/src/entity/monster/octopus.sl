package entity.monster.octopus

import random.LCG as random

lazy Animation down = addAnimation([addTexture("spr_octopus_down_0"), addTexture("spr_octopus_down_1"), addTexture("spr_octopus_down_2"), addTexture("spr_octopus_down_3")], 2)
lazy Animation up = addAnimation([addTexture("spr_octopus_up_0"), addTexture("spr_octopus_up_1"), addTexture("spr_octopus_up_2"), addTexture("spr_octopus_up_3")], 2)
lazy Animation left = addAnimation([addTexture("spr_octopus_left_0"), addTexture("spr_octopus_left_1"), addTexture("spr_octopus_left_2"), addTexture("spr_octopus_left_3")], 2)
lazy Animation right = addAnimation([addTexture("spr_octopus_right_0"), addTexture("spr_octopus_right_1"), addTexture("spr_octopus_right_2"), addTexture("spr_octopus_right_3")], 2)

lazy Animation down_charge = addAnimation([addTexture("spr_octopus_charge_down_0"), addTexture("spr_octopus_charge_down_1"), addTexture("spr_octopus_charge_down_2"), addTexture("spr_octopus_charge_down_3")], 5)
lazy Animation up_charge = addAnimation([addTexture("spr_octopus_charge_up_0"), addTexture("spr_octopus_charge_up_1"), addTexture("spr_octopus_charge_up_2"), addTexture("spr_octopus_charge_up_3")], 5)
lazy Animation left_charge = addAnimation([addTexture("spr_octopus_charge_left_0"), addTexture("spr_octopus_charge_left_1"), addTexture("spr_octopus_charge_left_2"), addTexture("spr_octopus_charge_left_3")], 5)
lazy Animation right_charge = addAnimation([addTexture("spr_octopus_charge_right_0"), addTexture("spr_octopus_charge_right_1"), addTexture("spr_octopus_charge_right_2"), addTexture("spr_octopus_charge_right_3")], 5)

lazy Animation rock = addAnimation([addTexture("spr_octopus_rock")], 5)


class Octopus extends Monster{
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
                    new Rock()
                }
            }
        }
    }
    def override onInit(){
        setSize(2)
        step = random.range(0, 5)
        Health = 2
        speed = 2
    }
    def override onDeath(){
        objects.coin.drop(6,9)
    }
}
class Rock extends MonsterProjectile{
    def override onInit(){
        speed = 4
        damage = 2
        setAnimation(rock)
    }
}