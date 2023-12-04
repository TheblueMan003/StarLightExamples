package entity.monster.firelion

lazy Animation down = addAnimation([addTexture("spr_fire_lion_yellow_down_0"), addTexture("spr_fire_lion_yellow_down_1"), addTexture("spr_fire_lion_yellow_down_2"), addTexture("spr_fire_lion_yellow_down_3")], 2)
lazy Animation up = addAnimation([addTexture("spr_fire_lion_yellow_up_0"), addTexture("spr_fire_lion_yellow_up_1"), addTexture("spr_fire_lion_yellow_up_2"), addTexture("spr_fire_lion_yellow_up_3")], 2)
lazy Animation left = addAnimation([addTexture("spr_fire_lion_yellow_left_0"), addTexture("spr_fire_lion_yellow_left_1"), addTexture("spr_fire_lion_yellow_left_2"), addTexture("spr_fire_lion_yellow_left_3")], 2)
lazy Animation right = addAnimation([addTexture("spr_fire_lion_yellow_right_0"), addTexture("spr_fire_lion_yellow_right_1"), addTexture("spr_fire_lion_yellow_right_2"), addTexture("spr_fire_lion_yellow_right_3")], 2)

lazy Animation down_idle = addAnimation([addTexture("spr_fire_lion_yellow_idle_down_0"), addTexture("spr_fire_lion_yellow_idle_down_1"), addTexture("spr_fire_lion_yellow_idle_down_2"), addTexture("spr_fire_lion_yellow_idle_down_3")], 5)
lazy Animation up_idle = addAnimation([addTexture("spr_fire_lion_yellow_idle_up_0"), addTexture("spr_fire_lion_yellow_idle_up_1"), addTexture("spr_fire_lion_yellow_idle_up_2"), addTexture("spr_fire_lion_yellow_idle_up_3")], 5)
lazy Animation left_idle = addAnimation([addTexture("spr_fire_lion_yellow_idle_left_0"), addTexture("spr_fire_lion_yellow_idle_left_1"), addTexture("spr_fire_lion_yellow_idle_left_2"), addTexture("spr_fire_lion_yellow_idle_left_3")], 5)
lazy Animation right_idle = addAnimation([addTexture("spr_fire_lion_yellow_idle_right_0"), addTexture("spr_fire_lion_yellow_idle_right_1"), addTexture("spr_fire_lion_yellow_idle_right_2"), addTexture("spr_fire_lion_yellow_idle_right_3")], 5)


class FireLion extends Monster{
    def override onTick(){
        super.onTick()
        moveTowardCenter(right, up, left, down)
        damageNear(5, 1)
    }
    def override onInit(){
        setSize(2)
        speed = 3
        setHealth(35)
    }
    def override onDeath(){
        objects.coin.drop(6,8)
    }
}