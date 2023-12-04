package fruit

import cmd.entity as entity
import math.Vector2Int
import random

int bombProbability = 5
def summon(){
    int x,y = random.range(-30,30), random.range(60, 80)
    if (random.range(100) <= bombProbability){
        new Bomb(new Vector2Int(x,y))
    }
    else{
        switch(random.range(12)){
            0 -> new Apple(new Vector2Int(x,y))
            1 -> new Banana(new Vector2Int(x,y))
            2 -> new Beetroot(new Vector2Int(x,y))
            3 -> new Carrot(new Vector2Int(x,y))
            4 -> new Blueberry(new Vector2Int(x,y))
            5 -> new Coconut(new Vector2Int(x,y))
            6 -> new Grapes(new Vector2Int(x,y))
            7 -> new Pepper(new Vector2Int(x,y))
            8 -> new Potato(new Vector2Int(x,y))
            9 -> new Raspberry(new Vector2Int(x,y))
            10 -> new Turnip(new Vector2Int(x,y))
        }
    }
}

def spawn(){
    switch(random.range(-3,3)){
        foreach(x in -3..3){
            x -> Compiler.insert($x, x){
                at($x 0 1){
                    summon()
                }
            }
        }
    }
}

Process game{
    int tick, dtick
    int delay
    int multipleProbability
    int multipleCount
    int round

    def main(){
        tick++
        dtick++
        if (tick > delay){
            tick = 0
            int count = 0
            if (random.range(100) < multipleProbability){
                count = random.range(2,multipleCount)
            }
            else{
                count = 1
            }
            for(int i = 0;i < count;i++){
                spawn()
            }
        }
        if (dtick > 20){
            round++
            dtick = 0
            if (round % 20 == 0){
                if (delay > 3)delay--
                multipleProbability += 5
            }
            if (round % 40 == 0 && multipleCount < 7){
                multipleCount++
            }
        }
    }
    def onStart(){
        delay = 20
        tick = 0
        multipleProbability = 10
        multipleCount = 4
        round = 0
    }
}