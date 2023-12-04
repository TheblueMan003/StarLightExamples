package entity.defender.ice_mage

lazy Animation down = addAnimation([addTexture("spr_ice_mage_attack_down_0"), addTexture("spr_ice_mage_attack_down_1")], 2)
lazy Animation up = addAnimation([addTexture("spr_ice_mage_attack_up_0"), addTexture("spr_ice_mage_attack_up_1")], 2)
lazy Animation left = addAnimation([addTexture("spr_ice_mage_attack_left")], 2)
lazy Animation right = addAnimation([addTexture("spr_ice_mage_attack_right")], 2)
lazy Animation idle = addAnimation([addTexture("spr_ice_mage_down")], 2)

lazy Animation spell = addAnimation([addTexture("spr_mini_star_0"), addTexture("spr_mini_star_1")], 2)

class IceMage extends Defender{
    int attackDelay
    def override onTick(){
        super.onTick()
        attackDelay++
        if (Compiler.isJava()){
            setTranslation(0, 0, 0.5)
        }
        int speed = 0
        switch(speedUpgrade){
            0 -> speed = 30
            1 -> speed = 34
            2 -> speed = 37
            3 -> speed = 40
            4 -> speed = 44
            5 -> speed = 47
            6 -> speed = 50
            7 -> speed = 54
            8 -> speed = 57
            9 -> speed = 60
        }
        if (attackDelay > 100 - speed){
            if (@e[distance=..15,tag=!freezed] in monster.Monster){
                (int, int) nearest = monster.getNearestNotFreezed()
                motionDir = direction.getFloor(nearest._0 - X, nearest._1 - Z)
                setDirectionalAnimation(right, up, left, down)

                attackDelay = 0
                new Spell()
            }
            else{
                setAnimation(idle)
            }
        }
    }
    def override onInit(){
        setSize(2)
        attackDelay = 0
        setHealth(28)
        setAnimation(idle)
    }
    override int getNameIndex(){
        return 6
    }
}
class Spell extends DefenderProjectile{
    def override onInit(){
        setAnimation(spell)
        speed = 10
        damage = 16
        damageType = 2
        int extra_dmg = 0
        with(@e[sort=nearest,limit=1] in IceMage){
            extra_dmg = attackUpgrade
        }
        damage += extra_dmg
    }
}