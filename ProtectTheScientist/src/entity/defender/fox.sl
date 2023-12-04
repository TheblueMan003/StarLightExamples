package entity.defender.fox

lazy Animation down = addAnimation([addTexture("spr_fox_down_0"), addTexture("spr_fox_down_1"), addTexture("spr_fox_down_2"), addTexture("spr_fox_down_3")], 2)
lazy Animation up = addAnimation([addTexture("spr_fox_up_0"), addTexture("spr_fox_up_1"), addTexture("spr_fox_up_2"), addTexture("spr_fox_up_3")], 2)
lazy Animation left = addAnimation([addTexture("spr_fox_left_0"), addTexture("spr_fox_left_1"), addTexture("spr_fox_left_2"), addTexture("spr_fox_left_3")], 2)
lazy Animation right = addAnimation([addTexture("spr_fox_right_0"), addTexture("spr_fox_right_1"), addTexture("spr_fox_right_2"), addTexture("spr_fox_right_3")], 2)

lazy Animation idle_left = addAnimation([addTexture("spr_fox_idle_left")], 2)
lazy Animation idle_right = addAnimation([addTexture("spr_fox_idle_right")], 2)

class Fox extends Defender{
    int attackDelay
    int spin
    int deltaHeal
    def override onTick(){
        super.onTick()
        attackDelay++
        if (attackDelay > 30 - speedUpgrade * 2){
            attackDelay = 0
            int extra_dmg = attackUpgrade
            with(@e[distance=..2,limit=1,sort=nearest] in monster.Monster){
                damage(1 + extra_dmg, 0)
            }
            deltaHeal++
            if (Health < MaxHealth && deltaHeal % 2 == 0){
                Health++
            }
        }
        if (!isMoving){
            if (Health <= 4){
                speed = 20 + speedUpgrade * 2
                (int, int) nearest = pixie.getNearest()
                if (X == nearest._0 && Z == nearest._1){
                    setAnimation(idle_left)
                }
                else{
                    moveToward(nearest._0, nearest._1, right, up, left, down)
                }
            }
            else{
                speed = 10 + speedUpgrade * 2
                if (@e[distance=..15] in monster.Monster){
                    (int, int) nearest = monster.getNearest()
                    moveToward(nearest._0, nearest._1, right, up, left, down)
                }
                else{
                    int cellCount = 0
                    with(@e[distance=..1] in defender.Defender){
                        cellCount++
                    }
                    if (cellCount > 1){
                        int motionDir = random.range(0, 4)
                        switch(motionDir){
                            0 -> moveRight()
                            1 -> moveUp()
                            2 -> moveLeft()
                            3 -> moveDown()
                        }
                        setDirectionalAnimation(right, up, left, down)
                    }
                    else{
                        if (block(minecraft:black_concrete)){
                            moveTowardCenter(right, up, left, down)
                        }
                        else if (motionDir < 2)
                            setAnimation(idle_right)
                        else
                            setAnimation(idle_left)
                    }
                }
            }
        }
    }
    def override onInit(){
        setSize(2)
        attackDelay = 0
        setHealth(12)
        speed = 10
        setAnimation(idle_right)
    }
    override int getNameIndex(){
        return 2
    }
}