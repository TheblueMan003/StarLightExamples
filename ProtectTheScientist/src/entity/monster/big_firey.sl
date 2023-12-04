package entity.monster.big_firey

lazy Animation down = addAnimation([addTexture("spr_firey_down_0"), addTexture("spr_firey_down_1"), addTexture("spr_firey_down_2"), addTexture("spr_firey_down_3"), addTexture("spr_firey_down_4"), addTexture("spr_firey_down_5"), addTexture("spr_firey_down_6"), addTexture("spr_firey_down_7")], 1)
lazy Animation up = addAnimation([addTexture("spr_firey_up_0"), addTexture("spr_firey_up_1"), addTexture("spr_firey_up_2"), addTexture("spr_firey_up_3"), addTexture("spr_firey_up_4"), addTexture("spr_firey_up_5"), addTexture("spr_firey_up_6"), addTexture("spr_firey_up_7")], 1)
lazy Animation left = addAnimation([addTexture("spr_firey_left_0"), addTexture("spr_firey_left_1"), addTexture("spr_firey_left_2"), addTexture("spr_firey_left_3"), addTexture("spr_firey_left_4"), addTexture("spr_firey_left_5"), addTexture("spr_firey_left_6"), addTexture("spr_firey_left_7")], 1)
lazy Animation right = addAnimation([addTexture("spr_firey_right_0"), addTexture("spr_firey_right_1"), addTexture("spr_firey_right_2"), addTexture("spr_firey_right_3"), addTexture("spr_firey_right_4"), addTexture("spr_firey_right_5"), addTexture("spr_firey_right_6"), addTexture("spr_firey_right_7")], 1)

class BigFirey extends Monster{
    def override onTick(){
        super.onTick()
        (int, int) nearest = defender.getNearest()
        moveToward(nearest._0, nearest._1, right, up, left, down)
        damageNear(2, 1, 5)
    }
    def override onInit(){
        setSize(2.5)
        speed = 2
        setHealth(6)
    }
    def override onDeath(){
        at(~1~~){
            new firey.Firey()
        }
        at(~~~1){
            new firey.Firey()
        }
        at(~1~~1){
            new firey.Firey()
        }
    }
}