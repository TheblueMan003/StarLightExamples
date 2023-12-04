package entity.defender

import cmd.sound as sound

class DefenderProjectile extends Entity{
    int damage
    int damageType
    int speed
    int lifetime
    bool wasRotated

    def override onTick(){
        super.onTick()
        if (!wasRotated){
            facing(@e[sort=nearest,limit=1] in monster.Monster){
                /tp @s ~ ~ ~ ~ 0
            }
            wasRotated = true
        }
        at(@s){
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
        with(@e[distance=..1.5, limit=1] in monster.Monster){
            dealtDamage = damage(dmg, dmgType)
        }
        if (dealtDamage){
            die()
        }
    }
}
class Defender extends Entity{
    int attackUpgrade
    int speedUpgrade
    int healthUpgrade

    int regenTick

    def override onTick(){
        super.onTick()
        if (healthUpgrade > 0){
            regenTick++
            if (regenTick > 30 - healthUpgrade * 2){
                regenTick = 0
                Health++
            }
        }
    }
    def override onDamage(){
        with(@a,true)sound.play(minecraft:entity.generic.hurt)
    }
    bool canUpdateAttack(){
        if (attackUpgrade < 10){
            return true
        }
        return false
    }
    bool canUpdateSpeed(){
        if (speedUpgrade < 10){
            return true
        }
        return false
    }
    bool canUpdateHealth(){
        if (healthUpgrade < 10){
            return true
        }
        return false
    }
    void updateAttack(){
        attackUpgrade ++
    }
    void updateSpeed(){
        speedUpgrade ++
    }
    void updateHealth(){
        healthUpgrade ++
        MaxHealth += 4
        Health += 4
    }
    int getAttackUpgrade(){
        return attackUpgrade
    }
    int getSpeedUpgrade(){
        return speedUpgrade
    }
    int getHealthUpgrade(){
        return healthUpgrade
    }
    virtual int getNameIndex(){
        return -1
    }
    virtual bool canBeSelected(){
        return true
    }
}
(int, int) getNearest(){
    with((@e[sort=nearest, limit=1] in Defender) not in spike.Spike){
        return getPos()
    }
}

def @reset reset(){
    with(entity.defender.Defender){
        hideHealthBar()
        freezeEffect = null
        /kill
    }
}