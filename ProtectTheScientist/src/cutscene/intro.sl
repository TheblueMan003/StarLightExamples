package cutscene.intro

from mc.sprite import _
import cmd.spectate as sp
import cmd.gamemode as gmd
import cmd.entity as entity
import utils.Process
import game.music as msc

lazy Texture story_0 = addTexture("spr_story_0")
lazy Texture story_1 = addTexture("spr_story_1")
lazy Texture story_2 = addTexture("spr_story_2")
lazy Texture story_3 = addTexture("spr_story_3")
lazy Texture story_4 = addTexture("spr_story_4")
lazy Texture story_5 = addTexture("spr_story_5")

class StoryBillboard extends Sprite{
    def override __init__(){
        setTexture(story_0)
        setSize(20)
    }
    def set(int index){
        switch(index){
            0 -> setTexture(story_0)
            1 -> setTexture(story_1)
            2 -> setTexture(story_2)
            3 -> setTexture(story_3)
            4 -> setTexture(story_4)
            5 -> setTexture(story_5)
        }
    }
}
Process main{
    int index, tick
    StoryBillboard billboard
    entity marker
    def main(){
        if (dialog.isFinished()){
            tick++
            if(tick >= 20*4){
                tick = 0
                index++
                switch(index){
                    foreach(i in 1..5){
                        i -> dialog.setText("intro_"+i)
                    }
                }
                if(index == 6){
                    end()
                    stop()
                }
                else{
                    dialog.box.reset()
                    billboard.set(index)
                }
            }
        }
        as(@a)sp.spectate(marker)
    }
    def onStart(){
        index = 0
        tick = 0
        at(0 42 0)billboard = new StoryBillboard()
        at(0 42 10)dialog.summon()
        at(0 55 0){
            marker = entity.summon(minecraft:armor_stand, {NoGravity:1,Invisible:1}){
                /tp @s ~ ~ ~ -180 90
            }
        }
        as(@a)gmd.spectator()
        dialog.setText("intro_0")
    }
    def onStop(){
        billboard = null
        entity.kill(marker)
        as(@a){
            gmd.adventure()
            /tp @s 0 19 0 -180.0 90.00
        }
    }
}
def start(){
    main.start()
}
def end(){
    game.start()
    with(entity.defender.luke_blue.LukeBlue){
        /kill
    }
    blue()
}
def blue(){
    with(@a,true)msc.play("calm")
    at(-16 1 -8){
        new entity.defender.luke_blue.LukeBlue()
    }
}