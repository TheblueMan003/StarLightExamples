package level

import cmd.block as block
import game.music as music
import cmd.title as title
import cmd.schedule as schedule
import cmd.sound as sound
import cmd.actionbar as actionbar
import cmd.title as title
import mc.blocktags as bt
import utils.PProcess
import utils.Process

int level
bool lock

def start(){
    with(@a,true){
        /tp @s ~ ~ ~ -90 0
        if (Compiler.isBedrock()){
            block.fill(44 0 51,44 13 64,sl:lime_concrete)
            block.fill(45 0 51,45 13 64,sl:lime_concrete)
            block.fill(43 0 51,43 13 64,sl:black_concrete)
        }
        il.start()
        main.start()
    }
    level = -1
    next2()
}

Process NextLevelAnimation{
    int tick
    def main(){
        tick++
        if (tick >= 60){
            tick = 0
            lock = false
            next2()
            stop()
        }
    }
    def onStart(){
        tick = 0
    }
}
Process EndingAnimation{
    int tick
    def main(){
        with(@a,true){
            hub.join()
        }
        stop()
    }
    def onStart(){
        tick = 0
    }
    def onStop(){
        with(@a,true){
            il.stop()
            main.stop()
        }
    }
}

def next(){
    lock:=false
    if (!lock){
        lock = true
        with(@a,true){
            sound.play(minecraft:entity.player.levelup)
        }
        setGreen()
        NextLevelAnimation.start()
    }
}

def next2(){
    level++
    lazy var index = 0
    block.fill(43 0 51,43 14 65,minecraft:black_terracotta)
    with(@a,true){
        music.play(level)
    }
    at(43 0 51){
        switch(level){
            foreach(lvl in @level){
                lvl.index -> {
                    lvl()
                    index++
                }
            }
        }
        il.randomizeGrid()
    }

    if (level == index){
        with(@a,true){
            music.stop()
            title.show(0,10, 80, 10,"Congratualation!")
            title.showSubtitle("You have completed the game!")
        }
        EndingAnimation.start()
    }
}

def lazy author(string name){

}

PProcess main{
    def main(){
        int dlevel = level + 1
        actionbar.show(10,10,"Level: ",dlevel,"/",85)
    }
}
blocktag white_block{
    minecraft:orange_terracotta,
    
    minecraft:magenta_terracotta,
    minecraft:light_blue_terracotta,
    minecraft:yellow_terracotta,
    minecraft:lime_terracotta,
    
    minecraft:pink_terracotta,
    minecraft:gray_terracotta,
    minecraft:light_gray_terracotta,
    minecraft:cyan_terracotta,
    
    minecraft:white_terracotta,
    minecraft:purple_terracotta,
    
    minecraft:blue_terracotta,
    minecraft:brown_terracotta,
    minecraft:green_terracotta,
    minecraft:red_terracotta
}
blocktag green_block{
    minecraft:orange_wool,
    
    minecraft:magenta_wool,
    minecraft:light_blue_wool,
    minecraft:yellow_wool,
    minecraft:black_wool,
    
    minecraft:pink_wool,
    minecraft:gray_wool,
    minecraft:light_gray_wool,
    minecraft:cyan_wool,
    
    minecraft:purple_wool,
    minecraft:purple_glazed_terracotta,

    minecraft:blue_wool,
    minecraft:brown_wool,
    minecraft:green_wool,
    minecraft:red_wool
}

def setGreen(){
    il.il.foreachCell(){
        bt.convert(#white_block, #green_block)
    }
}