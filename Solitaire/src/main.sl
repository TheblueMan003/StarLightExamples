package solitaire

import math.raycast as rc
import mc.Click
import standard::print
import mc.pointer as pt
import cmd.effect as effect
import mc.PositionLock
import utils.Process
import cmd.gamemode as gmd
import utils.blocktags as bt

def @playertick(){
    effect.night_vision()
    effect.saturation()
}

scoreboard bool hasSelectedCard
scoreboard Card selectedCard

def launch(){
    click.start()
    lock.start()
    summon()
    endCheck.start()
}
Process endCheck{
    def main(){
        bool allValid = true
        with(Card){
            if (isInDeck >= 0){
                if (!inFoundation){
                    allValid = false
                }
            }
        }

        if (allValid){
            stop()
            endingAnimation.start()
            with(@a,true){
                sound.play(minecraft:entity.player.levelup)
                click.stop()
            }
        }
    }
}
Process endingAnimation{
    int anim_card := 52
    int tick
    def main(){
        anim_card:=52
        with(Card){
            endingAnimation()
        }
        tick++
        if (tick >= 10){
            anim_card--
            tick = 0
        }
        if (anim_card < -5){
            stop()
            with(@a){
                lock.stop()
                hub.join()
            }
        }
    }
    def onStart(){
        anim_card = 52
        tick = 0
    }
    def onStop(){
        with(CardBase){
            ./kill
        }
    }
}
PositionLock lock{
    set(-3 -39 30)
}
Click click{
    def onClick(){
        Card s
        bool found = false
        bool debug = false
        if (gmd.isCreative()){
            debug = true
        }
        rc.shoot(100, 0.5, !block(#bt.air)){
            float cx
            float cy
            float mz
            pt.run(){
                cx = nbt.x
                cy = nbt.y
                mz = nbt.z - 2
            }

            with(@e[sort=nearest,distance=..5] in Card, true){
                float x = nbt.x
                float y = nbt.y
                float z = nbt.z

                float lx = x - 1
                float ux = x + 1
                float ly = y - 1.5
                float uy = y + 1.5

                if (lx <= cx && cx <= ux && ly <= cy && cy <= uy && mz <= z){
                    s = this
                    mz = z
                    found = true
                }
            }
        }
        if (found){
            selectedCard = s
            hasSelectedCard = found
            selectedCard.onClick()
            if (debug){
                selectedCard.printAllVariable()
            }
        }
    }
    def onHold(){
        if (hasSelectedCard){
            rc.shoot(100, 0.5, !block(#bt.air)){
                selectedCard.onHold()
            }
        }
    }
    def onRelease(){
        if (hasSelectedCard){
            selectedCard.onRelease()
            selectedCard = null
            hasSelectedCard = false
        }
    }
}