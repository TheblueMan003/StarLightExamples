package entity.objects.coin

import random.LCG as random
import cmd.sound as sound

lazy Animation bronze = addAnimation([addTexture("spr_coin_bronze_0"), addTexture("spr_coin_bronze_1")], 2)
lazy Animation silver = addAnimation([addTexture("spr_coin_silver_0"), addTexture("spr_coin_silver_1")], 2)
lazy Animation gold = addAnimation([addTexture("spr_coin_gold_0"), addTexture("spr_coin_gold_1")], 2)

class Coin extends Sprite{
    int tick
    int value

    def @tick(){
        tick += 1
        if(tick > 20){
            game.money += value
            with(@a,true)sound.play(minecraft:block.note_block.bell)
            /kill
        }
    }
}


class BronzeCoin extends Coin{
    def __init__(){
        setAnimation(bronze)
        value = 1
    }
}

class SilverCoin extends Coin{
    def __init__(){
        setAnimation(silver)
        value = 10
    }
}

class GoldCoin extends Coin{
    def __init__(){
        setAnimation(gold)
        value = 20
    }
}
def drop(int min, int max){
    drop(random.range(min, max + 1))
}
def drop(int value){
    while(value > 0){
        switch(random.range(-10, 10)){
            foreach(x in -10..10){
                x -> switch(random.range(-10, 10)){
                    foreach(z in -10..10){
                        z -> at({~x/10.0, ~, ~z/10.0}){
                            if (value > 20){
                                new GoldCoin()
                                value -= 20
                            }
                            else if (value > 10){
                                new SilverCoin()
                                value -= 10
                            }
                            else{
                                new BronzeCoin()
                                value -= 1
                            }
                        }
                    }
                }
            }
        }
    }
}