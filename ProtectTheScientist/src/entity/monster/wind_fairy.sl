package entity.monster.wind_fairy

import cmd.Bossbar

lazy Animation idle = addAnimation([addTexture("spr_wind_fairy_idle")], 2)
lazy Animation attack_tornado = addAnimation([addTexture("spr_wind_fairy_attack_tornado")], 2)
lazy Animation attack_trunk = addAnimation([addTexture("spr_wind_fairy_attack_trunk")], 2)
lazy Animation attack_arrow = addAnimation([addTexture("spr_wind_fairy_attack_arrow")], 2)


lazy Animation tornado = addAnimation([addTexture("spr_tornado_0"), addTexture("spr_tornado_1"), addTexture("spr_tornado_2"), addTexture("spr_tornado_3"), addTexture("spr_tornado_4"), addTexture("spr_tornado_5")], 2, false)
lazy Animation arrow = addAnimation([addTexture("spr_arrow")], 2)

Bossbar bar = new Bossbar("wind_fairy")

class WindFairy extends Monster{
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
                    setAnimation(attack_tornado)
                    at(~-2~~)new Tornado()
                    new Tornado()
                    at(~2~~)new Tornado()
                }
                else if (step % 20 == 10){
                    setAnimation(attack_trunk)
                    new trunk.Trunk()
                }
                else if (step % 20 == 15){
                    setAnimation(attack_arrow)
                    new Arrow()
                }
                else if (step % 20 == 16){
                    setAnimation(attack_arrow)
                    new Arrow()
                }
                else{
                    setAnimation(idle)
                }
            }
        }
    }
    def override onInit(){
        setSize(4)
        setHealth(300)
        setAnimation(idle)
        speed = 6
        bar.setColor("green")
        bar.showEveryone()
        bar.setName(("Sylphy: Goddess of Wind"))
    }
    def override onDeath(){
        objects.coin.drop(120,150)
        bar.hide()
    }
}
class Tornado extends MonsterProjectile{
    def override onInit(){
        speed = 2
        damage = 5
        setAnimation(tornado)
    }
}
class Arrow extends MonsterProjectile{
    def override onInit(){
        speed = 10
        damage = 5
        setAnimation(arrow)
    }
}
def @reset @reset.mob reset(){
    bar.hide()
}