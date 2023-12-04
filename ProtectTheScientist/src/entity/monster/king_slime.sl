package entity.monster.king_slime

import cmd.Bossbar

lazy Animation idle = addAnimation([addTexture("spr_king_slime_0"), addTexture("spr_king_slime_1"), addTexture("spr_king_slime_2"), addTexture("spr_king_slime_3")], 2)

Bossbar bar = new Bossbar("king_slime")

class KingSlime extends Monster{
    int step
    int dir
    def override onTick(){
        super.onTick()
        bar.setValue(Health, MaxHealth)
        damageNear(4, 0, 10)
        if (!isMoving){
            step++
            if (step < 5){
                moveDown()
            }
            else{
                if (dir == 0){
                    if (X > -10){
                        moveLeft()
                    }
                    else{
                        dir = 1
                        if (Z != 0){
                            moveDown()
                        }
                    }
                }
                else{
                    if (X < 10){
                        moveRight()
                    }
                    else{
                        dir = 0
                    }
                }
                if (step % 10 == 5){
                    at(~-2~~)new slime.Slime()
                    new slime.Slime()
                    at(~2~~)new slime.Slime()
                }
            }
        }
    }
    def override onInit(){
        setSize(4)
        setHealth(200)
        setAnimation(idle)
        speed = 2
        bar.setColor("blue")
        bar.showEveryone()
        bar.setName(("King Slime"))
    }
    def override onDeath(){
        objects.coin.drop(40,50)
        bar.hide()
    }
}
def @reset @reset.mob reset(){
    bar.hide()
}