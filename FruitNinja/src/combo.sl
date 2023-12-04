package combo

from mc.sprite import _

class Combo extends Sprite{
    int UUID, Power
    int tick
    def __init__(int power, int uuid){
        with(Combo){
            if (UUID == uuid && Power < power){
                ./kill
            }
        }
        UUID = uuid
        Power = power
        switch(power){
            2 -> setTexture(addTextureVertical("spr_combo_2"))
            3 -> setTexture(addTextureVertical("spr_combo_3"))
            4 -> setTexture(addTextureVertical("spr_combo_4"))
            5 -> setTexture(addTextureVertical("spr_combo_5"))
            6 -> setTexture(addTextureVertical("spr_combo_6"))
            7 -> setTexture(addTextureVertical("spr_combo_7"))
            8 -> setTexture(addTextureVertical("spr_combo_8"))
            9 -> setTexture(addTextureVertical("spr_combo_9"))
            10..100 -> setTexture(addTextureVertical("spr_combo_x"))
        }
        setScale(2, 2, 1)
    }
    def @tick(){
        tick++
        if (tick == 2){
            interpolateScale(5,4,4,1)
        }
        if (tick == 8){
            interpolateScale(20,0,0,1)
        }
        if (tick > 60){
            ./kill
        }
    }
}

def summon(int power, int uuid){
    new Combo(power, uuid)
}