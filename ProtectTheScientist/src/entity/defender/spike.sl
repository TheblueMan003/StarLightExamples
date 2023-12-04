package entity.defender.spike

lazy Texture spike = addTexture("spr_spike")

class Spike extends Defender{
    int tick
    int value
    def override onInit(){
        setTexture(spike)
        setSize(1.5)
        setHealth(10000)
        value = 1
    }
    def override onTick(){
        tick += 1
        if(tick > 20 - speedUpgrade * 2){
            int v = value + attackUpgrade
            with(@e[distance=..1] in monster.Monster,true){
                damage(v, 0)
            }
            tick = 0
        }
    }
    override int getNameIndex(){
        return 1
    }
}