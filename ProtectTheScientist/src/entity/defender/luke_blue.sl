package entity.defender.luke_blue

lazy Animation down = addAnimation([addTexture("spr_luke_blue_down_0"), addTexture("spr_luke_blue_down_1"), addTexture("spr_luke_blue_down_2"), addTexture("spr_luke_blue_down_3")], 2)
lazy Animation up = addAnimation([addTexture("spr_luke_blue_up_0"), addTexture("spr_luke_blue_up_1"), addTexture("spr_luke_blue_up_2"), addTexture("spr_luke_blue_up_3")], 2)
lazy Animation left = addAnimation([addTexture("spr_luke_blue_left_0"), addTexture("spr_luke_blue_left_1"), addTexture("spr_luke_blue_left_2"), addTexture("spr_luke_blue_left_3")], 2)
lazy Animation right = addAnimation([addTexture("spr_luke_blue_right_0"), addTexture("spr_luke_blue_right_1"),  addTexture("spr_luke_blue_right_2"),  addTexture("spr_luke_blue_right_3")], 2)

lazy Animation idle = addAnimation([addTexture("spr_luke_blue_work")], 2)

class LukeBlue extends Defender{
    def override onTick(){
        super.onTick()
        if (X == 0 && Z == 0){
            setAnimation(idle)
            wave.spawner.startLocked = false
        }
        else{
            moveTowardCenter(right, up, left, down)
        }
    }
    def override onInit(){
        setSize(3)
        setHealth(20)
        speed = 10
    }
    def override onDeath(){
        cutscene.gameover.start()
        wave.spawner.inWave = false
        monster.reset()
        defender.reset()
    }
    override bool canBeSelected(){
        return false
    }
}

def test(){
    new LukeBlue()
}