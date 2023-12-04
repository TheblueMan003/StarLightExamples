package entity.monster.mini_slime

lazy Animation down = addAnimation([addTexture("spr_mini_slime_down_0"), addTexture("spr_mini_slime_down_1")], 5)
lazy Animation up = addAnimation([addTexture("spr_mini_slime_up_0"), addTexture("spr_mini_slime_up_1")], 5)
lazy Animation left = addAnimation([addTexture("spr_mini_slime_left_0"), addTexture("spr_mini_slime_left_1")], 5)
lazy Animation right = addAnimation([addTexture("spr_mini_slime_right_0"), addTexture("spr_mini_slime_right_1")], 5)

class MiniSlime extends Monster{
    def override onTick(){
        super.onTick()
        moveTowardCenter(right, up, left, down)
        damageNear(1, 0)
    }
    def override onInit(){
        setHealth(1)
    }
    def override onDeath(){
        if (wave.spawner.wave % 10 != 9){
            objects.coin.drop(1,3)
        }
    }
}