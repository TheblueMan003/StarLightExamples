package entity.monster.necromancer

import cmd.Bossbar

lazy Animation idle = addAnimation([addTexture("spr_necromancer_idle")], 2)
lazy Animation attack = addAnimation([addTexture("spr_necromancer_attack_0"), addTexture("spr_necromancer_attack_1")], 2)

lazy Animation skull = addAnimation([addTexture("spr_necromancer_skull_0"), addTexture("spr_necromancer_skull_1")], 2, false)

Bossbar bar = new Bossbar("necromancer")

class Necromancer extends Monster{
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
                    at(~-2~~)new Skull()
                    new Skull()
                    at(~2~~)new Skull()
                }
                else if (step % 20 == 10){
                    setAnimation(attack)
                    new ghost.Ghost()
                    at(~-2~~)new ghost.Ghost()
                    at(~2~~)new ghost.Ghost()
                }
                else if (step % 20 == 15){
                    setAnimation(attack)
                    new Skull()
                }
                else if (step % 20 == 16){
                    setAnimation(attack)
                    new Skull()
                }
                else{
                    setAnimation(idle)
                }
            }
        }
    }
    def override onInit(){
        setSize(4)
        setHealth(500)
        setAnimation(idle)
        speed = 6
        bar.setColor("yellow")
        bar.showEveryone()
        bar.setName(("The Necromancer"))
    }
    def override onDeath(){
        objects.coin.drop(40,50)
        bar.hide()
    }
}
class Skull extends MonsterProjectile{
    def override onInit(){
        speed = 2
        damage = 8
        setAnimation(skull)
    }
}
def @reset @reset.mob reset(){
    bar.hide()
}