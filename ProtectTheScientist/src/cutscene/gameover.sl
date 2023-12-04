package cutscene.gameover

import utils.Process
import cmd.title as title
import game.language as lang

int extraMoney

def @reset(){
    extraMoney = 0
}


def start(){
    main.start()
}
def setMoney(int value){
    if (game.money < value){
        game.money = value
    }
}
def resetMoney(){
    switch(wave.spawner.wave){
        0 -> setMoney(20 + extraMoney)
        5 -> setMoney(100 + extraMoney)
        10 -> setMoney(200 + extraMoney)
        15 -> setMoney(300 + extraMoney)
        20 -> setMoney(600 + extraMoney)
        25 -> setMoney(800 + extraMoney)
        30 -> setMoney(900 + extraMoney)
        35 -> setMoney(1000 + extraMoney)
        40 -> setMoney(1500 + extraMoney)
        45 -> setMoney(2000 + extraMoney)
        50 -> setMoney(3000 + extraMoney)
    }
    if (extraMoney < 1000){
        extraMoney *= 2
        extraMoney += 10
    }
}

Process main{
    int tick
    def main(){
        tick += 1
        if(tick == 80){
            intro.blue()
            stop()
            int w = wave.spawner.wave / 5
            wave.spawner.wave = w * 5
            wave.spawner.showWarning()
            resetMoney()
        }
    }
    def onStart(){
        tick = 0
        def lazy make(json info){
            as(@a)title.show(0, 20, 60, 20, (info["gameover"], "red"))
        }
        lang.forEach(wave.spawner.infos, make)
        wave.spawner.startLocked = true
    }
}