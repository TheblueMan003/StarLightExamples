package ui.selector

import cmd.actionbar as actionbar
from mc.sprite import _
import utils.PProcess
import cmd.tp as tp
import math.raycast as rc
import mc.Click
import mc.Entity
import mc.java.input as input
import math
import game.language as lang

blocktag floor{
    minecraft:lime_concrete,
    minecraft:black_concrete,
    minecraft:white_concrete,
    minecraft:orange_concrete,
    minecraft:magenta_concrete,
    minecraft:light_blue_concrete
}

lazy Animation anim = addAnimation([addTexture("spr_entity_selector_top_0"), addTexture("spr_entity_selector_top_1"), addTexture("spr_entity_selector_top_2"), addTexture("spr_entity_selector_top_3"), addTexture("spr_entity_selector_top_4"),
                                            addTexture("spr_entity_selector_top_3"),addTexture("spr_entity_selector_top_2"), addTexture("spr_entity_selector_top_1")], 2)


entity user
class Selector extends Sprite{
    entity.defender.Defender moving
    bool isMovingStuff
    def __init__(){
        setAnimation(anim)
        setSize(2)
    }
    def select(entity.defender.Defender m){
        moving = m
        isMovingStuff = true
    }
    def delete(){
        /kill
    }
    def setTarget(int state, bool shift){
        /tp @s ~ ~ ~
        at(@s){
            bool buttonMod = false
            if (isMovingStuff){
                moving.teleport(~~0.01~)
            }
            if (block(~~-1.52~,#floor)){
                setSize(2)
            }
            if (block(~~-1.52~,minecraft:black_concrete)){
                /tp @s ~0.5 ~ ~0.5
                setSize(4)
                buttonMod = true
            }
            if (isMovingStuff){
                if (state == 3 && block(~~-1.52~,#floor)){
                    int count = 0
                    with(@e[distance=..0.5,sort=nearest] in entity.defender.Defender, true)count++
                    if (count <= 1 && !block(~~-1.52~,minecraft:black_concrete)){
                        moving.setPosition()
                        isMovingStuff = false
                    }
                }
            }
            else{
                bool button = false
                with(@e[distance=..2,sort=nearest,limit=1] in button.Button,false, buttonMod){
                    button = true
                    if (state >= 1){
                        hold()
                    }
                    else{
                        select()
                    }
                    if (state == 1){
                        click()
                    }
                }
                with(@e[distance=..4,sort=nearest,limit=1] in button.ExtraLargeButton,false){
                    button = true
                    if (state >= 1){
                        hold()
                    }
                    else{
                        select()
                    }
                    if (state == 1){
                        click()
                    }
                }
                if (!isMovingStuff && !button){
                    bool found = false
                    with(@e[distance=..1,sort=nearest,limit=1] in entity.defender.Defender, true){
                        showHealthBar()
                        if (canBeSelected()){
                            int ua = getAttackUpgrade()
                            int us = getSpeedUpgrade()
                            int uh = getHealthUpgrade()
                            def lazy make(json info){
                                with(user, true)actionbar.show(100,10, (info["money"], "gold", "bold"), (game.money, "yellow"), " - ", (info["attack_upgrade_value"], "gold", "bold"), (ua, "yellow"), " - ", (info["speed_upgrade_value"], "gold", "bold"), (us, "yellow"), " - ", (info["health_upgrade_value"], "gold", "bold"), (uh, "yellow"))
                            }
                            lang.forEach(wave.spawner.infos, make)
                        }
                        found = true
                    }
                    if (found && state == 3 && !wave.spawner.inWave){
                        entity.defender.Defender s
                        with(@e[sort=nearest,limit=1] in entity.defender.Defender, true){
                            __refCount = 100000
                            s = __ref :> entity.defender.Defender
                        }
                        Selector sel = __ref :> Selector
                        if (s.canBeSelected()){
                            if (!shift){
                                tmenu.summon(s, sel)
                            }
                            else{
                                select(s)
                            }
                        }
                    }
                }
            }
        }
    }
}
scoreboard Selector selector
scoreboard int clickState
[criterion="minecraft.custom:minecraft.sneak_time"] scoreboard int sneak2
PProcess main{
    def main(){
        int s = clickState
        user += @s
        int dwave = wave.spawner.wave + 1
        dwave = math.clamp(dwave, 1, 50)
        lazy int length = Compiler.length(wave.spawner.waves)
        def lazy make(json info){
            actionbar.show(10,10, (info["money"], "gold", "bold"), (game.money, "yellow"), " - ", (info["wave"], "gold", "bold"), (dwave, "yellow"),("/"+length,"yellow"))
        }
        lang.forEach(wave.spawner.infos, make)
        bool sneak = false
        if (sneak2 >= 1){sneak = true}
        sneak2 = 0
        rc.shoot(40, 0.5, block(#floor)){
            int y = tp.getY()
            if (y < 5){
                align("xyz")at(~0.5 ~1.54 ~0.5){
                    selector.setTarget(s, sneak)
                }
            }
        }
        user -= @s
        if (clickState == 3){
            clickState = 2
        }
        if (clickState == 1){
            clickState = 0
        }
    }
    def beforAll(){
        with(button.Button){
            unselect()
        }
    }
    def override onStart(){
        selector.delete()
        selector = new Selector()
        selector.setAnimation(anim)
        selector.setSize(2)
        click.start()
    }
    def override onStop(){
        selector.delete()
        selector = null
        click.stop()
    }
}
Click click{
    def onClick(){
        clickState = 3
    }
    def onRelease(){
        clickState = 1
    }
    def onHold(){
    }
}