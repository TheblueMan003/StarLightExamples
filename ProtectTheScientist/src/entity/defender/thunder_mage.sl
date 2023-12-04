package entity.defender.thunder_mage

import cmd.sound as sound

def death(){
    /kill
}

lazy Animation down = addAnimation([addTexture("spr_thunder_mage_0"), addTexture("spr_thunder_mage_1")], 2)
lazy Animation thunder = addAnimation([addTexture("spr_thunder_0"), addTexture("spr_thunder_1"), addTexture("spr_thunder_2")], 2)
lazy Animation circle = addAnimation([addTexture("spr_thunder_land_0"), addTexture("spr_thunder_land_1"), addTexture("spr_thunder_land_2"), addTexture("spr_thunder_land_3"), addTexture("spr_thunder_land_4"), addTexture("spr_thunder_land_5")], 2, false, death)

class ThunderMage extends Defender{
    int attackDelay
    def override onTick(){
        super.onTick()
        attackDelay++
        int speed = 0
        switch(speedUpgrade){
            0 -> speed = 20
            1 -> speed = 30
            2 -> speed = 40
            3 -> speed = 50
            4 -> speed = 60
            5 -> speed = 70
            6 -> speed = 80
            7 -> speed = 90
            8 -> speed = 100
            9 -> speed = 110
        }
        if (attackDelay > 160 - speed){
            if (@e[distance=..15] in monster.Monster){
                with(@e[sort=random,limit=1,distance=..15] in monster.Monster,true){
                    new Thunder()
                    new Circle()
                }
                attackDelay = 0
            }
            else{
                setAnimation(down)
            }
        }
    }
    def override onInit(){
        setSize(3)
        attackDelay = 0
        setHealth(20)
        setAnimation(down)
    }
    override int getNameIndex(){
        return 5
    }
}
class Thunder extends DefenderProjectile{
    int tick
    def override onTick(){
        tick ++
        if (tick > 20){
            /kill
        }
    }
    def override onInit(){
        setAnimation(thunder)
        setSize(16)
        with(@a,true)sound.play(minecraft:entity.lightning_bolt.thunder)
        at(~ ~ ~)./tp @s ~ ~ ~-7

        int extra_dmg = 0
        with(@e[sort=nearest,limit=1] in ThunderMage){
            extra_dmg = attackUpgrade
        }
        with(@e[distance=..3] in monster.Monster){
            damage(10 + extra_dmg, 0)
        }
        speed = 0
        damage = 0
        damageType = 0
        wasRotated = true
    }
}
class Circle extends Entity{
    int tick
    def onTick(){
        tick ++
        if (tick > 20){
            /kill
        }
    }
    def override onInit(){
        setAnimation(circle)
        setSize(5)
    }
}