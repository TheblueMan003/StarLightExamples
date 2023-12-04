package level

import utils.Process
import cmd.effect as effect

typedef player.Player Player

int level
int tutorial
def backgroundCity(){
    player.loadBackground(0, 6)
}
def backgroundPlains(){
    player.loadBackground(1, 5)
}
def backgroundOwl(){
    player.loadBackground(2, 7)
}
def backgroundDog(){
    player.loadBackground(3, 5)
}

def level1(){
    at(21 224 0)new Player(0, backgroundCity)
    at(21 224 0)if (tutorial == 0){
        tutorial = 1
        info.showJump()
    }
}

def level2(){
    at(10 208 500)new Player(0, backgroundCity)
    at(10 208 500)if (tutorial == 1){
        tutorial = 2
        info.showArrow()
    }
}

def level3(){
    at(14 208 1000)new Player(0, backgroundCity)
    at(14 208 1000)if (tutorial == 2){
        tutorial = 3
        info.showDoubleJump()
    }
}

def level4(){
    at(24 192 1500)new Player(0, backgroundPlains)
    at(24 192 1500)if (tutorial == 3){
        tutorial = 4
        info.showWallJump()
    }
}

def level5(){
    at(9 192 2000)new Player(0, backgroundPlains)
    at(9 192 2000)if (tutorial == 4){
        tutorial = 5
        info.showBar()
    }
}

def level6(){
    at(9 192 2500)new Player(0, backgroundPlains)
    at(9 192 2500)if (tutorial == 5){
        tutorial = 6
        info.showPassThrough()
    }
}

def level7(){
    at(32 160 3000)new Player(0,backgroundOwl)
    at(32 160 3000)if (tutorial == 6){
        tutorial = 7
        info.showSpeed()
    }
}

def level8(){
    at(37 177 3500)new Player(0,backgroundOwl)
}

def level9(){
    at(13 224 4000)new Player(0,backgroundOwl)
}

def level10(){
    at(20 209 4500)new Player(0,backgroundDog)
    at(20 209 4500)if (tutorial == 7){
        tutorial = 10
        info.showFeatherFalling()
    }
}
def level11(){
    at(17 225 5000)new Player(0,backgroundDog)
}
def level12(){
    at(26 193 5500)new Player(0,backgroundDog)
    at(26 193 5500)if (tutorial == 10){
        tutorial = 12
        info.showWind()
    }
}

def end(){
    level++
    checkpoint.clear()
    loadLevel()
}
def reset(){
    loadLevel()
}
def resetCount(){
    level = 1
    tutorial = 0
    checkpoint.clear()
}
def clearPlayer(){
    with(player.Player){
        delete()
    }
}

def loadLevel(){
    clearPlayer()
    if (!checkpoint.loadPlayer()){
        switch(level){
            1 -> ./tp @a 21 224 0
            2 -> ./tp @a 10 208 500
            3 -> ./tp @a 14 208 1000
            4 -> ./tp @a 24 192 1500
            5 -> ./tp @a 9 192 2000
            6 -> ./tp @a 9 192 2500
            7 -> ./tp @a 32 160 3000
            8 -> ./tp @a 37 177 3500
            9 -> ./tp @a 13 224 4000
            10 -> ./tp @a 20 209 4500
            11 -> ./tp @a 17 225 5000
            12 -> ./tp @a 26 193 5500
        }
    }
    load.start()
    if (level == 13){
        as(@a)effect.clear()
        outro.launch()
    }
}

Process load{
    def main(){
        if (checkpoint.hasCheckpoint){
            if (checkpoint.loadCharacter()){
                stop()
            }
        }
        else{
            if (loaded(0 0 0) && level == 1){
                level1()
                stop()
            }
            if (loaded(0 0 500) && level == 2){
                level2()
                stop()
            }
            if (loaded(0 0 1000) && level == 3){
                level3()
                stop()
            }
            if (loaded(0 0 1500) && level == 4){
                level4()
                stop()
            }
            if (loaded(0 0 2000) && level == 5){
                level5()
                stop()
            }
            if (loaded(0 0 2500) && level == 6){
                level6()
                stop()
            }
            if (loaded(0 0 3000) && level == 7){
                level7()
                stop()
            }
            if (loaded(0 0 3500) && level == 8){
                level8()
                stop()
            }
            if (loaded(0 0 4000) && level == 9){
                level9()
                stop()
            }
            if (loaded(0 0 4500) && level == 10){
                level10()
                stop()
            }
            if (loaded(0 0 5000) && level == 11){
                level11()
                stop()
            }
            if (loaded(0 0 5500) && level == 12){
                level12()
                stop()
            }
        }
    }
}

def incLevel(){
    level++
    checkpoint.clear()
    loadLevel()
    standard.print("Level: " + level)
}
def decLevel(){
    level--
    checkpoint.clear()
    loadLevel()
    standard.print("Level: " + level)
}