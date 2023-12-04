package entity.monster.black_knight

import random.LCG as random

lazy Animation down = addAnimation([addTexture("spr_black_knight_down_0"), addTexture("spr_black_knight_down_1"), addTexture("spr_black_knight_down_2"), addTexture("spr_black_knight_down_3")], 2)
lazy Animation up = addAnimation([addTexture("spr_black_knight_up_0"), addTexture("spr_black_knight_up_1"), addTexture("spr_black_knight_up_2"), addTexture("spr_black_knight_up_3")], 2)
lazy Animation left = addAnimation([addTexture("spr_black_knight_left_0"), addTexture("spr_black_knight_left_1"), addTexture("spr_black_knight_left_2"), addTexture("spr_black_knight_left_3")], 2)
lazy Animation right = addAnimation([addTexture("spr_black_knight_right_0"), addTexture("spr_black_knight_right_1"), addTexture("spr_black_knight_right_2"), addTexture("spr_black_knight_right_3")], 2)

lazy Animation down_idle = addAnimation([addTexture("spr_black_knight_down_0")], 2)
lazy Animation up_idle = addAnimation([addTexture("spr_black_knight_up_0")], 2)
lazy Animation left_idle = addAnimation([addTexture("spr_black_knight_left_0")], 2)
lazy Animation right_idle = addAnimation([addTexture("spr_black_knight_right_0")], 2)

lazy Animation down_skel = addAnimation([addTexture("spr_black_knight_skeleton_down_0"), addTexture("spr_black_knight_skeleton_down_1"), addTexture("spr_black_knight_skeleton_down_2"), addTexture("spr_black_knight_skeleton_down_3")], 5)
lazy Animation up_skel = addAnimation([addTexture("spr_black_knight_skeleton_up_0"), addTexture("spr_black_knight_skeleton_up_1"), addTexture("spr_black_knight_skeleton_up_2"), addTexture("spr_black_knight_skeleton_up_3")], 5)
lazy Animation left_skel = addAnimation([addTexture("spr_black_knight_skeleton_left_0"), addTexture("spr_black_knight_skeleton_left_1"), addTexture("spr_black_knight_skeleton_left_2"), addTexture("spr_black_knight_skeleton_left_3")], 5)
lazy Animation right_skel = addAnimation([addTexture("spr_black_knight_skeleton_right_0"), addTexture("spr_black_knight_skeleton_right_1"), addTexture("spr_black_knight_skeleton_right_2"), addTexture("spr_black_knight_skeleton_right_3")], 5)

lazy Animation sword = addAnimation([addTexture("spr_iron_sword")], 5)

class BlackKnight extends Monster{
    int step
    def override onTick(){
        super.onTick()
        if (!isMoving){
            step++
            if (step < 5){
                if (Health < MaxHealth / 2){
                    moveTowardCenter(right_skel, up_skel, left_skel, down_skel)   
                    speed = 4 
                }
                else{
                    moveTowardCenter(right, up, left, down)
                }
            }
            else if (step == 6){
                setDirectionalAnimation(right_idle, up_idle, left_idle, down_idle)
            }
            else if (step > 46){
                step = 0
                new Sword()
            }
        }
        damageNear(8, 0)
    }
    def override onInit(){
        speed = 2
        step = random.range(0, 5)
        setHealth(50)
        setSize(3)
    }
    def override onDeath(){
        objects.coin.drop(6,8)
    }
}
class Sword extends MonsterProjectile{
    def override onInit(){
        speed = 10
        damage = 8
        setAnimation(sword)
    }
}