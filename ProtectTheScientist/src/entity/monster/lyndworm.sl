package entity.monster.lyndworm

import cmd.Bossbar

lazy Animation idle = addAnimation([addTexture("spr_lyndworm_down")], 2)
lazy Animation angry = addAnimation([addTexture("spr_lyndworm_down_angry")], 2)
lazy Animation attack = addAnimation([addTexture("spr_lyndworm_down_shoot")], 2)

lazy Animation fireball = addAnimation([addTexture("spr_lyndworm_fireball")], 2)

Bossbar bar = new Bossbar("lyndworm")

class Lyndworm extends Monster{
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
                    setAnimation(attack)
                    at(~-2~~)new Fireball()
                    new Fireball()
                    at(~2~~)new Fireball()
                }
                else if (step % 20 == 10){
                    setAnimation(attack)
                    new firey.Firey()
                    at(~-2~~)new firey.Firey()
                    at(~2~~)new firey.Firey()
                }
                else if (step % 20 == 15){
                    setAnimation(attack)
                    new Fireball()
                }
                else if (step % 20 == 16){
                    setAnimation(attack)
                    new Fireball()
                }
                else{
                    setAnimation(angry)
                }
            }
        }
    }
    def override onInit(){
        setSize(4)
        setHealth(1000)
        setAnimation(idle)
        speed = 6
        bar.setColor("red")
        bar.showEveryone()
        bar.setName(("Lyndworm"))
    }
    def override onDeath(){
        objects.coin.drop(100,150)
        bar.hide()
    }
}
class Fireball extends MonsterProjectile{
    def override onInit(){
        speed = 20
        damage = 8
        setAnimation(fireball)
    }
}
def @reset @reset.mob reset(){
    bar.hide()
}