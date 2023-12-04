package player

from mc.wasd import WASD

scoreboard int jump
scoreboard int down
scoreboard int holding

bool hasJump(){
    bool ret = false
    with(@a,true){
        ret = jump > 0
        jump = 0
        [nbt="Rotation[0]"] scoreboard json rotx
        [nbt="Rotation[1]"] scoreboard json roty

        int rx = rotx
        int ry = roty

        if (rx != 180 && rx != -180){
            /tp @s ~ ~ ~ -180 0
        }
        if (ry != 0){
            /tp @s ~ ~ ~ -180 0
        }
    }
    return ret
}

bool isHolding(){
    bool ret = false
    with(@a,true){
        ret = holding > 0
    }
    return ret
}
bool isHoldingDown(){
    bool ret = false
    with(@a,true){
        ret = down > 0
    }
    return ret
}

Click click{
    def onClick(){
        jump = 1
        holding = 1
    }
    def onRelease(){
        holding = 0
    }
}
WASD wasd{
    def onPressW(){
        jump = 1
    }
    def onW(){
        holding = 1
    }
    def onReleaseW(){
        holding = 0
    }
    def onS(){
        down = 1
    }
    def onReleaseS(){
        down = 0
    }
}