package hub

import maps.theblueman003.screen as screen
import cmd.entity as entity
import cmd.effect as effect
import cmd.gamemode as gmd
import game
import standard.debug
import maps.theblueman003.title as title

def @playertick(){
    effect.saturation()
}

def reset(){
    at(0 19 -20)screen.summon(1,2,3,6)
    screen.onStart(){
        title.launch(0 100 -20){
            cutscene.intro.start()
        }
    }
    screen.addCredit(0, "theblueman003"){
        print(("TheblueMan003", "bold", "gold"))
        print(("- Map Maker", "yellow"))
    }
    screen.addCredit(1, "spooky_ng"){
        print(("Spooky_NG", "bold", "gold"))
        print(("- Tester", "yellow"))
        print(("- Wave Balancer", "yellow"))
        print(("- Translator", "yellow"))
    }
    screen.addCredit(2, "liontack"){
        print(("Liontack", "bold", "gold"))
        print(("- Tester", "yellow"))
    }
    screen.addCredit(3, "jase0n"){
        print(("Jase0n", "bold", "gold"))
        print(("- Tester", "yellow"))
    }
    screen.addCredit(4, "nutt_j"){
        print(("Nutt_J", "bold", "gold"))
        print(("- Tester", "yellow"))
        print(("- Translator", "yellow"))
    }
    screen.addCredit(5, "beiyao"){
        print(("beiyao", "bold", "gold"))
        print(("- Tester", "yellow"))
    }
    screen.addCredit(6, "thebelal"){
        print(("TheBelal", "bold", "gold"))
        print(("- Tester", "yellow"))
    }
    screen.addCredit(7, "heimnad"){
        print(("Heimnad", "bold", "gold"))
        print(("- Translator", "yellow"))
    }
    screen.addCredit(8, "beiyao"){
        print(("Beiyao", "bold", "gold"))
        print(("- Translator", "yellow"))
    }
    screen.addCredit(9, "noteblock"){
        print(("Music Credit", "bold", "gold"))
        print(("controllerhead https://opengameart.org/users/controllerhead", "yellow"))
        print(("bart https://opengameart.org/users/bart", "yellow"))
        print(("Alexandr Zhelanov https://www.youtube.com/@AlexandrZhelanovsMusic", "yellow"))
        print(("syncopika https://opengameart.org/users/syncopika", "yellow"))
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

    screen.setInfo("Lower FOV is recommanded.\n- Spooky_NG")
    screen.addSettingEnum(["English", "Russian", "French", "Dutch", "Chinese", "Polish"], cutscene.dialog.setLanguage)
}
def @tick(){
    entity.kill(@e[type=item])
}
def join(){
    /tp @s 0.33 19.00 0.81 179.29 -5.27
    screen.start()
    gmd.adventure()
}
game.initPlayer(){
    join()
}