package entity.monster.ghost

lazy Animation down = addAnimation([addTexture("spr_ghost_down_0"), addTexture("spr_ghost_down_1")], 5)
lazy Animation up = addAnimation([addTexture("spr_ghost_up_0"), addTexture("spr_ghost_up_1")], 5)
lazy Animation left = addAnimation([addTexture("spr_ghost_left_0"), addTexture("spr_ghost_left_1")], 5)
lazy Animation right = addAnimation([addTexture("spr_ghost_right_0"), addTexture("spr_ghost_right_1")], 5)

class Ghost extends Monster{
    def override onTick(){
        super.onTick()
        moveTowardCenter(right, up, left, down)
        damageNear(2, 0)
    }
    def override onInit(){
        speed = 2
        setHealth(5)
        setSize(2)
    }
    def override onDeath(){
        objects.coin.drop(3,6)
    }
}