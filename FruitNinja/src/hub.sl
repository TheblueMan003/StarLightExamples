package hub

import game
import maps.theblueman003.screen as screen
import standard.debug
import standard::print

def reset(){
    at(0 7 26){
        screen.summon(1,2,5,6)
    }
    screen.onStart(){
        with(@a,true)./tp @s ~ ~ ~ -180 0
        player.start()
    }
    screen.addCredit(0, "theblueman003"){
        print(("TheblueMan003", "bold", "gold"))
        print(("- Map Maker", "yellow"))
    }
    screen.addCredit(1, "benjamin874"){
        print(("Benjamin874", "bold", "gold"))
        print(("- Thumbnail", "yellow"))
    }
    screen.addCredit(2, "spooky_ng"){
        print(("Spooky_NG", "bold", "gold"))
        print(("- Tester", "yellow"))
    }
    screen.addCredit(3, "kubababilon"){
        print(("KubaBabilon", "bold", "gold"))
        print(("- Tester", "yellow"))
    }
    screen.addCredit(4, "thebelal"){
        print(("TheBelal", "bold", "gold"))
        print(("- Tester", "yellow"))
    }
    screen.addCredit(9, "noteblock"){
        print(("Music Credit", "bold", "gold"))
        print(("SOUND AIRYLUVS by ISAo https://airyluvs.com/", "yellow"))
        print(("Music by Matthew Pablo www.matthewpablo.com", "yellow"))
    }
    screen.setInfo("This map is a recreation of the Phone App Fruit Ninja.")
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

def @tick(){
    game.initPlayer(){
        join()
    }
}

def join(){
    /tp @s 0.31 7.00 40.70 -180 -6.56
    screen.start()
}