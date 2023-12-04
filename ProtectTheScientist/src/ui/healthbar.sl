package ui.healthbar

from mc.sprite import _

lazy Texture heart_0 = addTexture("spr_heart_0")
lazy Texture heart_1 = addTexture("spr_heart_1")
lazy Texture heart_2 = addTexture("spr_heart_2")
lazy Texture heart_3 = addTexture("spr_heart_3")
lazy Texture heart_4 = addTexture("spr_heart_4")

class Heart extends Sprite{
    def lazy __init__(int value){
        switch(value){
            -1000..0 -> setTexture(heart_0)
            1 -> setTexture(heart_1)
            2 -> setTexture(heart_2)
            3 -> setTexture(heart_3)
            4..10000 -> setTexture(heart_4)
        }
    }
    def lazy update(int value){
        switch(value){
            -1000..0 -> setTexture(heart_0)
            1 -> setTexture(heart_1)
            2 -> setTexture(heart_2)
            3 -> setTexture(heart_3)
            4..10000 -> setTexture(heart_4)
        }
        teleport(~ ~ ~)
    }
}
class HealthBar{
    Heart hearts_0, hearts_1, hearts_2, hearts_3, hearts_4, hearts_5, hearts_6, hearts_7, hearts_8, hearts_9, hearts_10
    Heart hearts_11, hearts_12, hearts_13, hearts_14, hearts_15, hearts_16, hearts_17, hearts_18, hearts_19, hearts_20

    int Value
    int Max
    def __init__(int value, int max){
        Value = value
        Max = max
        foreach(heart in 0..20){
            if (heart.index*4 < max){
                at({~heart.index, ~0.05, ~-2}){
                    if (heart == 0)hearts_0 = new Heart(value)
                    if (heart == 1)hearts_1 = new Heart(value)
                    if (heart == 2)hearts_2 = new Heart(value)
                    if (heart == 3)hearts_3 = new Heart(value)
                    if (heart == 4)hearts_4 = new Heart(value)
                    if (heart == 5)hearts_5 = new Heart(value)
                    if (heart == 6)hearts_6 = new Heart(value)
                    if (heart == 7)hearts_7 = new Heart(value)
                    if (heart == 8)hearts_8 = new Heart(value)
                    if (heart == 9)hearts_9 = new Heart(value)
                    if (heart == 10)hearts_10 = new Heart(value)
                    if (heart == 11)hearts_11 = new Heart(value)
                    if (heart == 12)hearts_12 = new Heart(value)
                    if (heart == 13)hearts_13 = new Heart(value)
                    if (heart == 14)hearts_14 = new Heart(value)
                    if (heart == 15)hearts_15 = new Heart(value)
                    if (heart == 16)hearts_16 = new Heart(value)
                    if (heart == 17)hearts_17 = new Heart(value)
                    if (heart == 18)hearts_18 = new Heart(value)
                    if (heart == 19)hearts_19 = new Heart(value)
                    if (heart == 20)hearts_20 = new Heart(value)

                    value -= 4
                }
            }
        }
    }
    def update(int value){
        foreach(heart in 0..20){
            if (heart.index*4 < Max){
                at({~heart.index, ~0.05, ~-2}){
                    if (heart == 0)hearts_0.update(value)
                    if (heart == 1)hearts_1.update(value)
                    if (heart == 2)hearts_2.update(value)
                    if (heart == 3)hearts_3.update(value)
                    if (heart == 4)hearts_4.update(value)
                    if (heart == 5)hearts_5.update(value)
                    if (heart == 6)hearts_6.update(value)
                    if (heart == 7)hearts_7.update(value)
                    if (heart == 8)hearts_8.update(value)
                    if (heart == 9)hearts_9.update(value)
                    if (heart == 10)hearts_10.update(value)
                    if (heart == 11)hearts_11.update(value)
                    if (heart == 12)hearts_12.update(value)
                    if (heart == 13)hearts_13.update(value)
                    if (heart == 14)hearts_14.update(value)
                    if (heart == 15)hearts_15.update(value)
                    if (heart == 16)hearts_16.update(value)
                    if (heart == 17)hearts_17.update(value)
                    if (heart == 18)hearts_18.update(value)
                    if (heart == 19)hearts_19.update(value)
                    if (heart == 20)hearts_20.update(value)

                    value -= 4
                }
            }
        }
    }
    def override __destroy__(){
        hearts_0 = null
        hearts_1 = null
        hearts_2 = null
        hearts_3 = null
        hearts_4 = null
        hearts_5 = null
        hearts_6 = null
        hearts_7 = null
        hearts_8 = null
        hearts_9 = null
        hearts_10 = null
        hearts_11 = null
        hearts_12 = null
        hearts_13 = null
        hearts_14 = null
        hearts_15 = null
        hearts_16 = null
        hearts_17 = null
        hearts_18 = null
        hearts_19 = null
        hearts_20 = null
    }
}