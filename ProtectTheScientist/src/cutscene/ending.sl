package cutscene.ending

from mc.sprite import _
import cmd.spectate as sp
import cmd.gamemode as gmd
import cmd.entity as entity
import cmd.actionbar as actionbar
import utils.Process

lazy Texture story_0 = addTexture("spr_end_0")
lazy Texture story_1 = addTexture("spr_end_1")
lazy Texture story_2 = addTexture("spr_end_2")

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
                    foreach(i in 1..2){
                        i -> dialog.setText("outro_"+i)
                    }
                }
                if(index == 3){
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
        at(0 42 0){
            billboard = new StoryBillboard()
        }
        at(0 42 10)dialog.summon()
        at(0 55 0){
            marker = entity.summon(minecraft:armor_stand, {NoGravity:1,Invisible:1}){
                /tp @s ~ ~ ~ -180 90
            }
        }
        as(@a){
            gmd.spectator()
        }
        dialog.setText("outro_0")
    }
    def onStop(){
        billboard = null
        entity.kill(marker)
        as(@a){
            gmd.adventure()
            /tp @s 0 19 0 -180.0 90.00
            hub.join()
        }
    }
}
def start(){
    main.start()
    with(@a,true){
        ui.selector.main.stop()
        actionbar.force("")
    }
}