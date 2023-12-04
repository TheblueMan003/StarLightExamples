package hub

import maps.theblueman003.screen as screen
import cmd.entity as entity
import cmd.effect as effect
import cmd.gamemode as gmd
import game
import standard.debug
import standard::print

def reset(){
    at(-3 -39 56)screen.summon(1,2,5,6)
    screen.onStart(){
        solitaire.launch()
    }
    screen.addCredit(0, "theblueman003"){
        print(("TheblueMan003", "bold", "gold"))
        print(("- Map Maker", "yellow"))
    }
    screen.addCredit(1, "thebelal"){
        print(("TheBelal", "bold", "gold"))
        print(("- Tester", "yellow"))
    }
    screen.addCredit(2, "spooky_ng"){
        print(("Spooky_NG", "bold", "gold"))
        print(("- Tester", "yellow"))
    }
    screen.addCredit(3, "beiyao520"){
        print(("beiyao520", "bold", "gold"))
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
    screen.setInfo("This map is a creation of Microsoft Solitaire in Minecraft.")
}
def @tick(){
    game.initPlayer(){
        join()
    }
    entity.kill(@e[type=item])
}
def join(){
    /execute in minecraft:overworld run tp @s -2.51 -39.00 73.51 179.09 -6.00
    screen.start()
    gmd.adventure()
}