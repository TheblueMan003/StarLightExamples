package entity.monster.ghost_purple

lazy Animation down = addAnimation([addTexture("spr_ghost_purple_down_0"), addTexture("spr_ghost_purple_down_1")], 5)
lazy Animation up = addAnimation([addTexture("spr_ghost_purple_up_0"), addTexture("spr_ghost_purple_up_1")], 5)
lazy Animation left = addAnimation([addTexture("spr_ghost_purple_left_0"), addTexture("spr_ghost_purple_left_1")], 5)
lazy Animation right = addAnimation([addTexture("spr_ghost_purple_right_0"), addTexture("spr_ghost_purple_right_1")], 5)

class GhostPurple extends Monster{
    def override onTick(){
        super.onTick()
        moveTowardCenter(right, up, left, down)
        damageNear(6, 0)
    }
    def override onInit(){
        speed = 4
        setHealth(20)
        setSize(2)
    }
    def override onDeath(){
        objects.coin.drop(5,7)
    }
}