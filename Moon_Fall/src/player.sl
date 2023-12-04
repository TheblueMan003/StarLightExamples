package player

from mc.sprite import _
import mc.java.input as input
import mc.java.nbt as nbt
import standard
import cmd.effect as effect
import cmd.sound as sound
import math
import random
import mc.Click
import mc.java.display.DisplayBlock

lazy var runningLeft = addAnimation([addTextureVertical("spr_blue_run_left_0"), addTextureVertical("spr_blue_run_left_1"), addTextureVertical("spr_blue_run_left_2"), addTextureVertical("spr_blue_run_left_3")], 2, true)
lazy var runningRight = addAnimation([addTextureVertical("spr_blue_run_right_0"), addTextureVertical("spr_blue_run_right_1"), addTextureVertical("spr_blue_run_right_2"), addTextureVertical("spr_blue_run_right_3")], 2, true)
lazy var jumpLeft = addAnimation([addTextureVertical("spr_blue_jump_left")], 1, true)
lazy var jumpRight = addAnimation([addTextureVertical("spr_blue_jump_right")], 1, true)
lazy var fallLeft = addAnimation([addTextureVertical("spr_blue_fall_left")], 1, true)
lazy var fallRight = addAnimation([addTextureVertical("spr_blue_fall_right")], 1, true)
lazy var idleLeft = addAnimation([addTextureVertical("spr_blue_idle_left")], 1, true)
lazy var idleRight = addAnimation([addTextureVertical("spr_blue_idle_right")], 1, true)
lazy var hangLeft = addAnimation([addTextureVertical("spr_blue_hang_left_"+i) for i in 0..3], 1, true)
lazy var hangRight = addAnimation([addTextureVertical("spr_blue_hang_right_"+i) for i in 0..3], 1, true)
lazy var waveAtPlayer = addAnimation([addTextureVertical("spr_blue_wave_"+i) for i in 0..1], 5, true)

class Player extends Sprite{
    int speedX, speedY
    int wallJumpTick, wallJumpSpeed
    int doubleJump
    int wasOnGround
    int exitBar
    bool wasHanging
    PlayerDisplay display
    int ultraSpeed
    int ended
    int delay
    int slowFalling
    int coyoteTime

    def this(int a, void=>void loadBackground){
        display = new PlayerDisplay()
        display.setScale(2, 2, 1)
        display.setTranslation(0, 0.8, -10)
        /tag @s add player
        loadBackground()
        display.run(){
            /ride @s mount @e[tag=player,limit=1]
        }
        with(@e in Background){
            /ride @s mount @e[tag=player,limit=1]
        }
        new Room()
        with(@e in Room){
            /ride @s mount @e[tag=player,limit=1]
        }
        new TransitionOut()
        with(TransitionOut){
            /ride @s mount @e[tag=player,limit=1]
        }
        ended = 0
        delay = 40
        /tp @s ~ ~0.1 ~10
        setTeleportDuration(0)

        with(@a){
            click.start()
            wasd.start()
        }
    }
    lazy bool canWallJump(){
        return level.level > 3
    }
    def @tick(){
        if (block(~~-0.1~-10,minecraft:stone) && speedX < 0){
            speedX = -speedX
            with(@a,true)sound.play(minecraft:block.note_block.bell)
        }
        if (block(~~-0.1~-10,minecraft:black_wool) && speedX > 0){
            speedX = -speedX
            with(@a,true)sound.play(minecraft:block.note_block.bell)
        }
        if (block(~~-0.1~-10,minecraft:granite) && doubleJump < 1){
            doubleJump = 1
            at(~~~-10)new DoubleJumpParticle()
            with(@a,true)sound.play(minecraft:block.note_block.harp)
        }
        if (block(~~-0.1~-10,minecraft:yellow_concrete)){
            if (ultraSpeed != 2){
                at(~~~-10)new SpeedParticle()
                with(@a,true)sound.play(minecraft:block.note_block.xylophone)
            }
            ultraSpeed = 2
            if (speedX > 0){
                speedX = 6
            }
            if (speedX < 0){
                speedX = -6
            }
        }
        if (block(~~-0.1~-10,minecraft:oak_planks)){
            if (slowFalling != 2){
                at(~~~-10)new SlowFallParticle()
                with(@a,true)sound.play(minecraft:block.note_block.banjo)
            }
            slowFalling = 2
        }

        int eSpeedX = speedX
        if (wallJumpTick > 0){
            eSpeedX = wallJumpSpeed
            wallJumpTick--
        }
        if (delay > 0)delay--
        if (delay < 38)effect.clearblindness(@a)
        if (delay == 0){
            with(TransitionOut)./kill
        }
        if (delay == 0 && !info.isShowing){
            speedX = 3
            speedY = 0
            delay = -1
            music.play(level.level)
            timer.main.resume()
        }
        if (slowFalling > 0 && speedY < -2){
            speedY = -2
        }
        if (block(~ 257 ~-10, minecraft:quartz_block)){
            if (!isHolding() && !isHoldingDown()){
                speedY = 8
            }
            else{
                speedY = -4
            }
        }
        if (speedY > 0 && block(~ ~2.1 ~-10, #death_block)){
            death()
        }
        if (speedX > 0 && block(~0.1 ~2 ~-10,#death_block)){
            death()
        }
        if (speedX > 0 && block(~0.1 ~1 ~-10,#death_block)){
            death()
        }
        if (speedX > 0 && block(~0.1 ~ ~-10,#death_block)){
            death()
        }
        if (speedX < 0 && block(~-0.1 ~1 ~-10,#death_block)){
            death()
        }
        if (speedX < 0 && block(~-0.1 ~ ~-10,#death_block)){
            death()
        }
        if (speedY < 0 && block(~ ~-0.1 ~-10, #death_block)){
            death()
        }
        if (delay < 0){
            if (eSpeedX > 0){
                for(int i = 0;i < eSpeedX;i++){at(@s)
                    if (block(~0.5 ~ ~-10,#air) && block(~0.5 ~1 ~-10,#air) && !block(~0.5 ~ ~-10,minecraft:orange_stained_glass) && !block(~0.5 ~1 ~-10,minecraft:orange_stained_glass)){
                        /tp @s ~0.1 ~ ~
                    }
                }
            }
            if (eSpeedX < 0){
                for(int i = 0;i < -eSpeedX;i++){at(@s)
                    if (block(~-0.5 ~ ~-10,#air) && !block(~-0.5 ~ ~-10,minecraft:black_stained_glass) && block(~-0.5 ~1 ~-10,#air) && !block(~-0.5 ~1 ~-10,minecraft:black_stained_glass)){
                        /tp @s ~-0.1 ~ ~
                    }
                }
            }
            if (speedY > 0){
                for(int i = 0;i < speedY;i++){at(@s)
                    if (block(~ ~2.1 ~-10,#air) && !block(~ ~2.1 ~-10,minecraft:pink_stained_glass)){
                        /tp @s ~ ~0.1 ~
                    }
                }
            }
            if (speedY < 0){
                for(int i = 0;i < -speedY;i++){at(@s)
                    if (block(~ ~-0.1 ~-10,#air) && !block(~ ~-0.1 ~-10,minecraft:brown_stained_glass)){
                        /tp @s ~ ~-0.1 ~
                    }
                }
            }
        }
        bool jump = hasJump()
        if (ended){
            jump = false
        }
        /ride @p mount @s
        float x = nbt.x
        with(Background){
            update(x)
        }
        bool movedBar = true
        while(movedBar){
        at(@s){
            if (block(~ ~2 ~-10, #bar) && !jump && !isHoldingDown()){
                /tp @s ~ ~-0.1 ~ 
            }
            else{
                movedBar = false
            }
        }
        }
        at(@s){
            at(~~~-10){
                checkpoint.take()
            }
            if (block(~ ~2.1 ~-10, #bar) && !jump && !isHoldingDown()){
                wasOnGround--
                speedY = 0
                wallJumpTick = 0
                if (random.range(0,10)==0){
                    at(~~2~-9.5){
                        new SparkParticle()
                    }
                }
            }
            else if (block(~ ~-0.1 ~-10, #air) && !block(~ ~-0.1 ~-10,minecraft:brown_stained_glass)){
                wasOnGround--
                speedY -= 1
                if (ultraSpeed == 2){
                    ultraSpeed = 1
                }
                if (slowFalling == 2){
                    slowFalling = 1
                }
            }
            else if (speedY <= 0){
                wasOnGround = 5
                speedY = 0
                if (ultraSpeed == 1){
                    ultraSpeed = 0
                    if (speedX >= 6){
                        speedX = 3
                    }
                    if (speedX <= -6){
                        speedX = -3
                    }
                    if (eSpeedX >= 6){
                        eSpeedX = 3
                    }
                    if (eSpeedX <= -6){
                        eSpeedX = -3
                    }
                }
                if (slowFalling == 1){
                    slowFalling = 0
                }
            }
            if (jump && wasOnGround > 0 && !block(~ ~2.1 ~-10, #bar)){
                speedY = 10
            }
            else if (jump && !block(~1 ~ ~-10, #air) && eSpeedX > 0 && !block(~ ~2.1 ~-10, #bar) && canWallJump()){
                speedY = 10
                wallJumpTick = 20
                wallJumpSpeed = -eSpeedX
                with(@a,true)sound.play(minecraft:block.metal.hit,1,2)
                at(~1~~-10.01)new WallJumpParticle()
            }
            else if (jump && !block(~-1 ~ ~-10, #air) && eSpeedX < 0 && !block(~ ~2.1 ~-10, #bar) && canWallJump()){
                speedY = 10
                wallJumpTick = 20
                wallJumpSpeed = -eSpeedX
                with(@a,true)sound.play(minecraft:block.metal.hit,1,2)
                at(~-1~~-10.01)new WallJumpParticle()
            }
            else if (jump && block(~1 ~ ~-10, minecraft:orange_stained_glass) && eSpeedX > 0 && !block(~ ~2.1 ~-10, #bar) && canWallJump()){
                speedY = 10
                wallJumpTick = 20
                wallJumpSpeed = -eSpeedX
                with(@a,true)sound.play(minecraft:block.metal.hit,1,2)
                at(~1~~-10.01)new WallJumpParticle()
            }
            else if (jump && block(~-1 ~ ~-10, minecraft:black_stained_glass) && eSpeedX < 0 && !block(~ ~2.1 ~-10, #bar) && canWallJump()){
                speedY = 10
                wallJumpTick = 20
                wallJumpSpeed = -eSpeedX
                with(@a,true)sound.play(minecraft:block.metal.hit,1,2)
                at(~-1~~-10.01)new WallJumpParticle()
            }
            else if (jump && !block(~1 ~1 ~-10, #air) && eSpeedX > 0 && !block(~ ~2.1 ~-10, #bar) && canWallJump()){
                speedY = 10
                wallJumpTick = 20
                wallJumpSpeed = -eSpeedX
                with(@a,true)sound.play(minecraft:block.metal.hit,1,2)
                at(~1~~-10.01)new WallJumpParticle()
            }
            else if (jump && !block(~-1 ~1 ~-10, #air) && eSpeedX < 0 && !block(~ ~2.1 ~-10, #bar) && canWallJump()){
                speedY = 10
                wallJumpTick = 20
                wallJumpSpeed = -eSpeedX
                with(@a,true)sound.play(minecraft:block.metal.hit,1,2)
                at(~-1~~-10.01)new WallJumpParticle()
            }
            else if (jump && block(~1 ~1 ~-10, minecraft:orange_stained_glass) && eSpeedX > 0 && !block(~ ~2.1 ~-10, #bar) && canWallJump()){
                speedY = 10
                wallJumpTick = 20
                wallJumpSpeed = -eSpeedX
                with(@a,true)sound.play(minecraft:block.metal.hit,1,2)
                at(~1~~-10.01)new WallJumpParticle()
            }
            else if (jump && block(~-1 ~1 ~-10, minecraft:black_stained_glass) && eSpeedX < 0 && !block(~ ~2.1 ~-10, #bar) && canWallJump()){
                speedY = 10
                wallJumpTick = 20
                wallJumpSpeed = -eSpeedX
                with(@a,true)sound.play(minecraft:block.metal.hit,1,2)
                at(~-1~~-10.01)new WallJumpParticle()
            }
            else if (jump && doubleJump > 0 && !block(~ ~2.1 ~-10, #bar)){
                speedY = 10
                doubleJump--
                with(@a,true)sound.play(minecraft:item.armor.equip_leather)
                for(int n = 0;n < 10;n++){
                    at(~~~-10){
                        new CloudParticle()
                    }
                }
            }

            if (speedY > 0 && eSpeedX > 0){
                display.setAnimation(jumpRight)
            }
            else if (speedY > 0 && eSpeedX < 0){
                display.setAnimation(jumpLeft)
            }
            else if (speedY < 0 && eSpeedX > 0){
                display.setAnimation(fallRight)
            }
            else if (speedY < 0 && eSpeedX < 0){
                display.setAnimation(fallLeft)
            }
            else if (eSpeedX == 0 && delay > 0){
                display.setAnimation(waveAtPlayer)
            }
            else if (eSpeedX == 0 && speedX > 0){
                display.setAnimation(idleRight)
            }
            else if (eSpeedX == 0 && speedX < 0){
                display.setAnimation(idleLeft)
            }
            else if (block(~ ~2.1 ~-10, #bar) && speedX > 0){
                display.setAnimation(hangRight)
                display.setTranslation(0, 1.2, -10)
                if (!wasHanging){
                    with(@a,true)sound.play(minecraft:block.amethyst_block.hit)
                }
                wasHanging = true
            }
            else if (block(~ ~2.1 ~-10, #bar) && speedX < 0){
                display.setAnimation(hangLeft)
                display.setTranslation(0, 1.2, -10)
                if (!wasHanging){
                    with(@a,true)sound.play(minecraft:block.amethyst_block.hit)
                }
                wasHanging = true
            }
            else if (eSpeedX > 0){
                display.setAnimation(runningRight)
            }
            else if (eSpeedX < 0){
                display.setAnimation(runningLeft)
            }
            else{
                display.setAnimation(idleRight)
            }

            if (ultraSpeed > 0){
                int txt = display.getTexture()
                at(~ ~ ~-10.01){
                    new Trail(txt)
                }
            }

            if (wasHanging && !block(~ ~2.1 ~-10, #bar)){
                wasHanging = false
                display.setTranslation(0, 0.8, -10)
            }
            at(~~~-10){
                bool stopped = false
                with(End in @e[distance=..6]){
                    stopped = true
                }
                if (stopped && !ended){
                    ended = 1
                    with(@e[tag=room.background]){
                        /ride @s dismount
                    }
                    music.stop()
                    timer.main.pause()
                    new TransitionIn()
                    with(TransitionIn){
                        /ride @s mount @e[tag=player,limit=1]
                    }
                }
            }
            if (ended){
                ended++                
                if (ended >= 30){
                    effect.blindness(@a)
                    level.end()
                    with(TransitionIn){
                        /kill
                    }
                }
            }
            if (block(~~-0.1~-10, minecraft:barrier)){
                death()
            }
        }
    }
    def death(){
        if (delay < 0){
            music.stop()
            timer.main.pause()
            with(@a,true)sound.play(minecraft:block.respawn_anchor.deplete)
            at(~~~-10)new checkpoint.CheckpointParticle()
            delay = 200
            display.delete()
            for(int i = 0;i < 10;i++){
                at(~~~-5)new DeathParticle()
            }
            sleep 60
            at(Player){
                new TransitionIn()
                with(TransitionIn){
                    /ride @s mount @e[tag=player,limit=1]
                }
            }
            sleep 60
            with(TransitionIn)./kill
            with(Room){
                ./kill
            }
            level.reset()
            effect.blindness(@a)
        }
    }
    def delete(){
        display.delete()
        with(@a){
            click.stop()
            wasd.stop()
        }
        with(Background){
            delete()
        }
        with(Room){
            ./kill
        }
        /kill
    }
}
class PlayerDisplay extends Sprite{
    def delete(){
        /kill
    }
}

class End{
    def __init__(){

    }
}

def summonEnd(){
    new End()
}

def removeEnd(){
    /kill @e[name=End, distance=..10]
}