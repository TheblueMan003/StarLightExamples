package entity.monster

import cmd.sound as sound

class MonsterProjectile extends Entity{
    int damage
    int damageType
    int speed
    int lifetime

    def override onTick(){
        super.onTick()
        facing((@e[sort=nearest,limit=1] in defender.Defender) not in defender.spike.Spike){
            switch(speed){
                foreach(i in 0..20){
                    i -> Compiler.insert($i, (i / 20.0)){
                        /tp @s ^ ^ ^$i
                    }
                }
            }
        }
        lifetime ++
        if(lifetime > 60){
            die()
        }
        int dmg = damage
        int dmgType = damageType
        bool dealtDamage = false
        with(@e[distance=..1] in defender.Defender,true){
            dealtDamage = damage(dmg, dmgType)
        }
        if (dealtDamage){
            die()
        }
    }
}
class Monster extends Entity{
    int damageDelay
    def override onTick(){
        super.onTick()
        if (damageDelay > 0){
            damageDelay --
        }
    }

    def damageNear(int dmg, int dmgType, int delay = 20){
        if (damageDelay <= 0){
            bool dealtDamage = false
            with(@e[distance=..1] in defender.Defender){
                dealtDamage = damage(dmg, dmgType)
            }
            if (dealtDamage){
                damageDelay = delay
            }
        }
    }
    def override onDamage(){
        with(@a,true)sound.play(minecraft:entity.generic.hurt, 0.1, 1)
    }
}
(int, int) getNearest(){
    with(@e[sort=nearest, limit=1] in Monster){
        return getPos()
    }
}
(int, int) getNearestNotFreezed(){
    with(@e[sort=nearest,limit=1,tag=!freezed] in Monster){
        return getPos()
    }
}

def killAll(){
    with(Monster, true){
        die()
    }
}

def @reset reset(){
    with(entity.monster.Monster){
        hideHealthBar()
        freezeEffect = null
        /kill
    }
    @reset.mob()
}