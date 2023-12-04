package entity.monster.trunk

import random.LCG as random

lazy Animation down = addAnimation([addTexture("spr_trunk_down_0"), addTexture("spr_trunk_down_1"), addTexture("spr_trunk_down_2"), addTexture("spr_trunk_down_3")], 2)
lazy Animation up = addAnimation([addTexture("spr_trunk_up_0"), addTexture("spr_trunk_up_1"), addTexture("spr_trunk_up_2"), addTexture("spr_trunk_up_3")], 2)
lazy Animation left = addAnimation([addTexture("spr_trunk_left_0"), addTexture("spr_trunk_left_1"), addTexture("spr_trunk_left_2"), addTexture("spr_trunk_left_3")], 2)
lazy Animation right = addAnimation([addTexture("spr_trunk_right_0"), addTexture("spr_trunk_right_1"), addTexture("spr_trunk_right_2"), addTexture("spr_trunk_right_3")], 2)

lazy Animation down_idle = addAnimation([addTexture("spr_trunk_down_0")], 2)
lazy Animation up_idle = addAnimation([addTexture("spr_trunk_up_0")], 2)
lazy Animation left_idle = addAnimation([addTexture("spr_trunk_left_0")], 2)
lazy Animation right_idle = addAnimation([addTexture("spr_trunk_right_0")], 2)

lazy Animation tree = addAnimation([addTexture("spr_trunk_tree_0"), addTexture("spr_trunk_tree_1"), addTexture("spr_trunk_tree_2"), addTexture("spr_trunk_tree_3"), addTexture("spr_trunk_tree_4"), addTexture("spr_trunk_tree_5")], 2, false)


class Trunk extends Monster{
    int step
    def override onTick(){
        super.onTick()
        if (!isMoving){
            step++
            if (step < 5){
                moveTowardCenter(right, up, left, down)
            }
            else if (step == 6){
                setDirectionalAnimation(right_idle, up_idle, left_idle, down_idle)
            }
            else if (step > 66){
                step = 0
                at(~ ~-0.51 ~){
                    new TreeSpawner()
                }
            }
        }
    }
    def override onInit(){
        setSize(2)
        setHealth(10)
        speed = random.range(1, 3)
        step = random.range(0, 5)
    }
    def override onDeath(){
        objects.coin.drop(6,10)
    }
}
class TreeSpawner extends MonsterProjectile{
    int timer = 0
    def override onInit(){
        speed = 4
        damage = 0
    }
    def override onTick(){
        super.onTick()
        timer ++
        if (timer > 10){
            new Tree()
            timer = 0
        }
    }
}
class Tree extends MonsterProjectile{
    def override onInit(){
        speed = 0
        damage = 3
        setAnimation(tree)
        setSize(2)
    }
}