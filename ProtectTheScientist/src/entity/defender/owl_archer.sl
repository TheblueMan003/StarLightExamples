package entity.defender.owl_archer

lazy Animation down = addAnimation([addTexture("spr_archer_owl_down_0"), addTexture("spr_archer_owl_down_1"), addTexture("spr_archer_owl_down_2"), addTexture("spr_archer_owl_down_3")], 2)
lazy Animation up = addAnimation([addTexture("spr_archer_owl_up_0"), addTexture("spr_archer_owl_up_1"), addTexture("spr_archer_owl_up_2"), addTexture("spr_archer_owl_up_3")], 2)
lazy Animation left = addAnimation([addTexture("spr_archer_owl_left_0"), addTexture("spr_archer_owl_left_1"), addTexture("spr_archer_owl_left_2"), addTexture("spr_archer_owl_left_3")], 2)
lazy Animation right = addAnimation([addTexture("spr_archer_owl_right_0"), addTexture("spr_archer_owl_right_1"), addTexture("spr_archer_owl_right_2"), addTexture("spr_archer_owl_right_3")], 2)

lazy Animation down_attack = addAnimation([addTexture("spr_archer_owl_attack_down_0"), addTexture("spr_archer_owl_attack_down_1"), addTexture("spr_archer_owl_attack_down_2"), addTexture("spr_archer_owl_attack_down_3")], 2)
lazy Animation up_attack = addAnimation([addTexture("spr_archer_owl_attack_up_0"), addTexture("spr_archer_owl_attack_up_1"), addTexture("spr_archer_owl_attack_up_2"), addTexture("spr_archer_owl_attack_up_3")], 2)
lazy Animation left_attack = addAnimation([addTexture("spr_archer_owl_attack_left_0"), addTexture("spr_archer_owl_attack_left_1"), addTexture("spr_archer_owl_attack_left_2"), addTexture("spr_archer_owl_attack_left_3")], 2)
lazy Animation right_attack = addAnimation([addTexture("spr_archer_owl_attack_right_0"), addTexture("spr_archer_owl_attack_right_1"), addTexture("spr_archer_owl_attack_right_2"), addTexture("spr_archer_owl_attack_right_3")], 2)

lazy Animation arrow = addAnimation([addTexture("spr_arrow")], 2)

class OwlArcher extends Defender{
    int attackDelay
    def override onTick(){
        super.onTick()
        attackDelay++
        int speed = 0
        switch(speedUpgrade){
            0 -> speed = 10
            1 -> speed = 14
            2 -> speed = 17
            3 -> speed = 20
            4 -> speed = 24
            5 -> speed = 27
            6 -> speed = 30
            7 -> speed = 34
            8 -> speed = 37
            9 -> speed = 40
        }
        if (attackDelay > 40 - speed){
            if (@e[distance=..10] in monster.Monster){
                (int, int) nearest = monster.getNearest()
                motionDir = direction.getFloor(nearest._0 - X, nearest._1 - Z)
                setDirectionalAnimation(right_attack, up_attack, left_attack, down_attack)

                attackDelay = 0
                new Arrow()
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
        return 4
    }
}
class Arrow extends DefenderProjectile{
    def override onInit(){
        setAnimation(arrow)
        speed = 15
        damage = 3
        damageType = 0
        int extra_dmg = 0
        with(@e[sort=nearest,limit=1] in OwlArcher){
            extra_dmg = attackUpgrade
        }
        damage += extra_dmg
    }
}