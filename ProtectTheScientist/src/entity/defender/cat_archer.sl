package entity.defender.cat_archer

lazy Animation down = addAnimation([addTexture("spr_cat_archer_down")], 2)
lazy Animation up = addAnimation([addTexture("spr_cat_archer_up")], 2)
lazy Animation left = addAnimation([addTexture("spr_cat_archer_left")], 2)
lazy Animation right = addAnimation([addTexture("spr_cat_archer_right")], 2)
lazy Animation idle = addAnimation([addTexture("spr_cat_archer_idle")], 2)

lazy Animation arrow = addAnimation([addTexture("spr_arrow")], 2)

class CatArcher extends Defender{
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
        if (attackDelay > 60 - speed){
            if (@e[distance=..7] in monster.Monster){
                (int, int) nearest = monster.getNearest()
                motionDir = direction.getFloor(nearest._0 - X, nearest._1 - Z)
                setDirectionalAnimation(right, up, left, down)

                attackDelay = 0
                new Arrow()
            }
            else{
                setAnimation(idle)
            }
        }
    }
    def override onInit(){
        setSize(2)
        attackDelay = 0
        setHealth(12)
        setAnimation(idle)
    }
    override int getNameIndex(){
        return 0
    }
}
class Arrow extends DefenderProjectile{
    def override onInit(){
        setAnimation(arrow)
        speed = 10
        damage = 1
        damageType = 0
        int extra_dmg = 0
        with(@e[sort=nearest,limit=1] in CatArcher){
            extra_dmg = attackUpgrade
        }
        damage += extra_dmg
    }
}