package hub

import maps.theblueman003.screen as screen
import game
import cmd.spawnpoint as sp
import cmd.gamemode as gm
import standard::print
import game.language as lang
import math.Time

def reset(){
    at(-1 16 32){
        screen.summon(1,2,3,5)
        screen.onStart(){
            with(@a){
                screen.stop()
            }
            game.start()
        }
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
        print(("- Russian Translation", "yellow"))
    }
    screen.addCredit(3, "knifecreepster"){
        print(("knifecreepster", "bold", "gold"))
        print(("- Tester", "yellow"))
    }
    screen.addCredit(4, "thebelal"){
        print(("TheBelal", "bold", "gold"))
        print(("- Tester", "yellow"))
        print(("- Persian Translation", "yellow"))
    }

    screen.addCredit(5, "liontack"){
        print(("Liontack", "bold", "gold"))
        print(("- Dutch Translation", "yellow"))
    }
    screen.addCredit(6, "kubababilon"){
        print(("KubaBabilon", "bold", "gold"))
        print(("- Polish Translation", "yellow"))
    }
    screen.addCredit(7, "itspigeon_cn"){
        print(("ItsPigeon_CN, beiyao, Seayay, Roser7419, IamSGZhenYun, XieXiLin", "bold", "gold"))
        print(("- Chinese Translation", "yellow"))
        print(("- Tester", "yellow"))
    }
    screen.addCredit(8, "nutt_j"){
        print(("Nutt_J", "bold", "gold"))
        print(("- Russian Translation", "yellow"))
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

    screen.addSettingEnum(["All Words", "Default\nWords", "Custom\nWords"], setWordSelection)
    screen.addSettingEnum(["No Hint", "Small Hint", "Big Hint"], setHintLevel)
    screen.addSettingEnum(["Time: 1 min", "Time: 2 min", "Time: 5 min", "Time: 10 min", "Time: 60 min"], setDrawingTime)
    screen.addSettingEnum(["English", "Chinese", "Dutch", "French", "Persian", "Russian", "Polish", "Korean"], setLanguage)
}
def setLanguage(int value){
    lang.setLanguage(value)
    lang.print(text.text, "language_set")
}
def setDrawingTime(int value){
    switch(value){
        0 -> word.DrawingTime = new Time(0, 1, 0, 0)
        1 -> word.DrawingTime = new Time(0, 2, 0, 0)
        2 -> word.DrawingTime = new Time(0, 5, 0, 0)
        3 -> word.DrawingTime = new Time(0, 10, 0, 0)
        4 -> word.DrawingTime = new Time(1, 0, 0, 0)
    }
}
def setHintLevel(int value){
    word.showWordHint = value
}
def setWordSelection(int value){
    wordSelection = value
}
game.initPlayer(){
    join()
}
def @playertick(){
    if (@s[tag=!custom_word] && block({~,14,~}, minecraft:blue_concrete)){
        screen.stop()
        customword.word.start()
        /tag @s add custom_word
    }
    if (@s[tag=custom_word] && !block({~,14,~}, minecraft:blue_concrete)){
        /tag @s remove custom_word
        customword.word.stop()
        screen.start()
    }
}
def join(){
    /tp @s -0.15 16.00 59.45 179.24 -4.20
    gm.adventure()
    screen.start()
}
int wordSelection
sp.setWorld(0 16 59)