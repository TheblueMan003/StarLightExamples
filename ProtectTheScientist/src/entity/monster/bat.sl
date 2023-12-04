package entity.monster.bat

import random.LCG as random

lazy Animation down = addAnimation([addTexture("spr_bat_down_0"), addTexture("spr_bat_down_1"), addTexture("spr_bat_down_2"), addTexture("spr_bat_down_3")], 2)
lazy Animation up = addAnimation([addTexture("spr_bat_up_0"), addTexture("spr_bat_up_1"), addTexture("spr_bat_up_2"), addTexture("spr_bat_up_3")], 2)
lazy Animation left = addAnimation([addTexture("spr_bat_left_0"), addTexture("spr_bat_left_1"), addTexture("spr_bat_left_2"), addTexture("spr_bat_left_3")], 2)
lazy Animation right = addAnimation([addTexture("spr_bat_right_0"), addTexture("spr_bat_right_1"), addTexture("spr_bat_right_2"), addTexture("spr_bat_right_3")], 2)

lazy Animation echo = addAnimation([addTexture("spr_bat_echo_0"), addTexture("spr_bat_echo_1")], 5)


class Bat extends Monster{
    int step
    def override onTick(){
        super.onTick()
        if (!isMoving){
            step++
            if (step < 5){
                (int, int) nearest = defender.getNearest()
                moveToward(nearest._0, nearest._1, right, up, left, down)
                damageNear(2, 1, 7)
            }
            else if (step == 6){
                step = 0
                at(~ ~-0.51 ~){
                    new Echo()
                }
            }
        }
    }
    def override onInit(){
        setSize(2)
        step = random.range(0, 5)
        Health = 10
        speed = 4
    }
    def override onDeath(){
        objects.coin.drop(4,6)
    }
}
class Echo extends MonsterProjectile{
    def override onInit(){
        speed = 10
        damage = 8
        setAnimation(echo)
    }
}