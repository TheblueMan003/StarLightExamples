package entity.monster.queen_bat

import cmd.Bossbar

lazy Animation down = addAnimation([addTexture("spr_bat_down_0"), addTexture("spr_bat_down_1"), addTexture("spr_bat_down_2"), addTexture("spr_bat_down_3")], 2)

lazy Animation echo = addAnimation([addTexture("spr_bat_echo_0"), addTexture("spr_bat_echo_1")], 5)

Bossbar bar = new Bossbar("queen_bat")

class QueenBat extends Monster{
    int step
    int dir
    def override onTick(){
        super.onTick()
        bar.setValue(Health, MaxHealth)
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
                if (step % 20 == 5){
                    at(~-2~~)new Echo()
                    new Echo()
                    at(~2~~)new Echo()
                }
                else if (step % 20 == 10){
                    new bat.Bat()
                }
                else if (step % 20 == 15){
                    new Echo()
                }
                else if (step % 20 == 16){
                    new Echo()
                }
                else{
                    setAnimation(down)
                }
            }
        }
    }
    def override onInit(){
        setSize(5)
        setHealth(2000)
        setAnimation(down)
        speed = 4
        bar.setColor("purple")
        bar.showEveryone()
        bar.setName(("Queen Bat"))
    }
    def override onDeath(){
        objects.coin.drop(40,50)
        bar.hide()
    }
}
class Echo extends MonsterProjectile{
    def override onInit(){
        speed = 6
        damage = 10
        setSize(2)
        setAnimation(echo)
    }
}
def @reset @reset.mob reset(){
    bar.hide()
}