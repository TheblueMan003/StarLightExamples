package wave.spawner

import cmd.title as title
import utils.Process
import random as rng
import cmd.schedule as schedule
import cmd.block as block
import game.music as msc
import game.language as lang

lazy json mobs = Compiler.readJson("resources/mobs.sjson")
lazy json waves = Compiler.readJson("resources/waves.sjson")
lazy json infos = Compiler.readJson("resources/text_infos_en.sjson", "resources/text_infos_ru.sjson", "resources/text_infos_fr.sjson", "resources/text_infos_nl.sjson", "resources/text_infos_zh.sjson", "resources/text_infos_pl.sjson")


def mini_slime(){new entity.monster.mini_slime.MiniSlime()}
def slime(){new entity.monster.slime.Slime()}
def mushman(){new entity.monster.mushman.Mushman()}
def ghost(){new entity.monster.ghost.Ghost()}
def octopus(){new entity.monster.octopus.Octopus()}
def trunk(){new entity.monster.trunk.Trunk()}
def wind_fairy(){new entity.monster.wind_fairy.WindFairy()}
def firey(){new entity.monster.firey.Firey()}
def big_firey(){new entity.monster.big_firey.BigFirey()}
def firelion(){new entity.monster.firelion.FireLion()}
def king_slime(){new entity.monster.king_slime.KingSlime()}
def ice_slime(){new entity.monster.ice_slime.IceSlime()}
def mini_ice_slime(){new entity.monster.mini_ice_slime.MiniIceSlime()}
def lyndworm(){new entity.monster.lyndworm.Lyndworm()}
def black_knight(){new entity.monster.black_knight.BlackKnight()}
def mummy(){new entity.monster.mummy.Mummy()}
def ghost_purple(){new entity.monster.ghost_purple.GhostPurple()}
def necromancer(){new entity.monster.necromancer.Necromancer()}
def red_mage(){new entity.monster.red_mage.RedMage()}
def ice_mage(){new entity.monster.ice_mage.IceMage()}
def bat(){new entity.monster.bat.Bat()}
def queen_bat(){new entity.monster.queen_bat.QueenBat()}



def left(void=>void action){
    switch(rng.range(-10, 11)){
        foreach(i in -10..10){
            i -> at({-16, 1, i})action()
        }
    }
}
def right(void=>void action){
    switch(rng.range(-10, 11)){
        foreach(i in -10..10){
            i -> at({16, 1, i})action()
        }
    }
}
def top(void=>void action){
    switch(rng.range(-15, 16)){
        foreach(i in -15..16){
            i -> at({i, 1, -11})action()
        }
    }
}
def topCenter(void=>void action){
    at({0, 1, -11})action()
}
def bottom(void=>void action){
    switch(rng.range(-15, 16)){
        foreach(i in -15..16){
            i -> at({i, 1, 11})action()
        }
    }
}
def warningTop(){
    block.fill(-15 0 -10, 15 0 -10, minecraft:orange_concrete)
}
def warningBottom(){
    block.fill(-15 0 10, 15 0 10, minecraft:light_blue_concrete)
}
def warningRight(){
    block.fill(15 0 -10, 15 0 10, minecraft:white_concrete)
}
def warningLeft(){
    block.fill(-15 0 -10, -15 0 10, minecraft:magenta_concrete)
}
def resetWarning(){
    block.fill(-15 0 -10, 15 0 -10, minecraft:lime_concrete)
    block.fill(-15 0 10, 15 0 10, minecraft:lime_concrete)
    block.fill(-15 0 -10, -15 0 10, minecraft:lime_concrete)
    block.fill(15 0 -10, 15 0 10, minecraft:lime_concrete)
}
def showWarning(){
    resetWarning()
    switch(wave){
        foreach(w in waves){
            w.index -> {
                foreach(m in w["warning"]){
                    m()
                }
            }
        }
    }
    showNextWave()
}

def showNextWave(){
    def lazy make(json info){
        print((info["title"], "gold", "bold"))
        switch(wave){
            foreach(w in waves){
                w.index -> {
                    foreach(m in w["mobs"]){
                        print((w["mobs"][m], "yellow", "bold"), ("x ", "yellow", "bold"), (info[m], "yellow"))
                    }
                }
            }
        }
    }
    lang.forEach(infos, make)
}

int wave
bool inWave
bool spawning
bool startLocked
def complete(){
    if (inWave && !spawning){
        main.stop()
        inWave = false
        wave++
        def lazy make(json info){
            as(@a)title.show(10, 5, 40, 20, (info["wave_cleared"], "green"))
        }
        lang.forEach(infos, make)
        with(entity.defender.Defender, true){
            heal(100)
        }
        if (wave >= 50){
            with(@a,true)msc.stop()
            schedule.add(60){
                cutscene.ending.start()
            }
        }
        else{
            showWarning()
            with(@a,true)msc.play("calm")
        }
    }
}
def @reset reset(){
    wave = 0
    inWave = false
    showWarning()
}
def nextWave(){
    ui.tmenu.close()
    with(entity.defender.Defender, true){
        heal(100)
    }
    inWave = true
    spawning = true
    main.start()
    int dWave = wave + 1
    def lazy make(json info){
        as(@a)title.show(10, 5, 40, 10, ("Wave ", "green"), (dWave, "green"), (" !", "green"))
    }
    lang.forEach(infos, make)
    spawner.start()
    if (dWave % 10 == 0){
        with(@a,true)msc.play("boss")
    }
    else if (dWave <= 25){
        with(@a,true)msc.play("battle_0")
    }
    else{
        with(@a,true)msc.play("battle_1")
    }
}

Process spawner{
    int i = 0
    int j = 0
    int tickSkip
    def main(){
        lazy void=>void fct
        tickSkip++
        tickSkip %= 4
        for(int k = 0;k < game.speed && tickSkip == 0;k++){
            switch(wave){
                foreach(w in waves){
                    w.index -> {
                        foreach(m in w["mobs"]){
                            if (j == m.index){
                                fct = mobs[m]
                                if(i < w["mobs"][m]){
                                    switch(rng.range(0, Compiler.length(w["direction"]))){
                                        foreach(d in w["direction"]){
                                            d.index -> {
                                                d(fct)
                                            }
                                        }
                                    }
                                    i++
                                }
                                else{
                                    i = 0
                                    j ++
                                }
                            }
                        }
                        if (j == Compiler.length(w["mobs"])){
                            spawning = false
                            stop()
                        }
                    }
                }
            }
        }
    }
    def onStart(){
        i = 0
        j = 0
    }
}

bool hasEnded(){
    int count = 0
    with(entity.monster.Monster){
        count++
    }
    if (count <= 0){
        return true
    }
    else{
        return false
    }
}

def check(){
    if (hasEnded()){
        complete()
    }
}

Process main{
    int tick
    def main(){
        tick++
        if (tick == 20){
            check()
            tick = 0
        }
    }
}