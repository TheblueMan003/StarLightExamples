package hub

import mc.java.armor_stand as armor_stand
import cmd.effect as effect
import cmd.entity as entity
import cmd.gamemode as gamemode
import game as game
import mc.inventory as inventory
import game.music as music
import standard::print

import maps.theblueman003.screen as screen

def summonScreen(){
    screen.summon(1, 2, 6, 5)
    screen.onStart(){
        level.start()
    }

    screen.addCredit(0, "theblueman003"){
        print(("TheblueMan003", "bold", "gold"))
        print(("- Map Maker", "yellow"))
    }
    screen.addCredit(1, "benjamin874"){
        print(("Benjamin874", "bold", "gold"))
        print(("- Thumbnail", "yellow"))
        //print(("- Bedrock Port Help", "yellow"))
    }
    screen.addCredit(2, "liontack"){
        print(("Liontack", "bold", "gold"))
        print(("- Tester", "yellow"))
    }
    screen.addCredit(3, "kubababilon"){
        print(("KubaBabilon", "bold", "gold"))
        print(("- Tester", "yellow"))
    }
    screen.addCredit(4, "spooky_ng"){
        print(("Spooky_NG", "bold", "gold"))
        print(("- Tester", "yellow"))
    }
    if(Compiler.isJava()){
        screen.addMap(0, "map_0"){
            print(("Dimensional Rush", "yellow", "https://theblueman003.com/maps/dimensional_rush.php"))
        }
        screen.addMap(1, "map_1"){
            print(("Beat Jumper 2", "yellow", "https://theblueman003.com/maps/beat_jumper_2.php"))
        }
        screen.addMap(2, "map_2"){
            print(("Stereoscopic", "yellow", "https://theblueman003.com/maps/stereoscopic.php"))
        }
  }
}

def reset(){
    at(16 0 50){
        summonScreen()
    }
}

scoreboard int clickdelay
def @tick main(){
    entity.kill(@e[type=item])
}
def @playertick playertick(){
    effect.night_vision(999999,0,true)
    effect.saturation()
    if (gamemode.isSurvival()){
        gamemode.adventure()
    }
}

game.initPlayer(){
    join()
}

def join(){
    il.removeSelector()
    /tp @s 16.45 0.00 61.44 -180.43 -12.88
    gamemode.adventure()
    screen.start()
    music.stop()
}