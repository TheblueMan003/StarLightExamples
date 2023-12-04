package player

import cmd.entity as entity
import cmd.tag as tag
import cmd.particles as particles
import cmd.actionbar as ab
import cmd.title as title
import cmd.sound as sound
import cmd.effect as effect
import cmd.score as sb
import cmd.Team
import mc.pointer as pt
import mc.Click
import mc.PositionLock
import game.score as score
import math.raycast as rc
import utils.PProcess
import utils.Process
import utils.draw as draw


scoreboard int score
scoreboard int pb
scoreboard bool usingItem
scoreboard int UUID
scoreboard int comboTime
scoreboard int comboCount
scoreboard bool alive
scoreboard int color
int uuid
entity previousEntity
entity newEntity
int life
int invisiblityTime
int highscore
bool multiplayer
int colorCount

def reset(){
    highscore = 0
}

def removeLife(){
    if (invisiblityTime < 0){
        invisiblityTime = 60
        life--
        with(@a,true)sound.play(minecraft:entity.villager.no)
        if (life <= 0){
            with(@a,true)die()
        }
    }
}

def init(){
    uuid++
    UUID = uuid

    entity oldP = pt.newPointer(){
        UUID = uuid
    }
    previousEntity += oldP
    entity newP = pt.newPointer(){
        UUID = uuid
    }
    newEntity += newP
}

Click click{
    def onClick(){
        usingItem = true
    }
    def onRelease(){
        usingItem = false
        comboStop()
    }
}
Team player = new Team("player")
player.friendlyFire(false)
player.seeFriendlyInvisibles(false)
player.disableCollision()
/gamerule maxEntityCramming -1
def @playertick(){
    effect.saturation()
    player.join()
}
entity cutter
Process game{
    def main(){
        invisiblityTime --
        with(@a,true){
            effect.invisibility()            
            ab.show(10, 10, ("Score: ","gold", "bold"), (score, "yellow"), (" Life: ","red", "bold"), (life, "red"))
        }
    }
    def onStop(){
        with(@a,true){
            effect.clear()
        }
    }
}
def comboStop(){
    score -= comboCount
    score += comboCount * comboCount
    comboCount = 0
}
PProcess main{
    def main(){
        comboTime--
        if (comboTime <= 0){
            comboStop()
        }
        rc.shoot(100,0.5,!block(minecraft:light)){
            if (block(minecraft:barrier)){
                int a = UUID
                if (usingItem){
                    cutter += @s
                    with(previousEntity,false,a == UUID){
                        tag.add("line.previous")
                    }
                    with(newEntity,false,a == UUID){
                        tag.add("line.newpoint")
                        /tp @s ~ ~ ~
                    }
                    int strength = 0
                    int count = 0
                    int colorTrail = color
                    draw.line(@e[tag=line.previous,limit=1], @e[tag=line.newpoint,limit=1]){
                        if (block(minecraft:barrier)){
                            switch(colorTrail){
                                0 -> particles.dust(1, 1, 1, 1)
                                1 -> particles.dust(1, 0, 0, 1)
                                2 -> particles.dust(1, 1, 0, 1)
                                3 -> particles.dust(0, 1, 0, 1)
                                4 -> particles.dust(0, 1, 1, 1)
                                5 -> particles.dust(0, 0, 1, 1)
                                6 -> particles.dust(1, 0, 1, 1)
                                7 -> particles.dust(1, 0.5, 0, 1)
                            }
                        }
                        with(@e[distance=..1] in objects.Cutable,true){
                            onCut(strength)
                            count++
                        }
                        strength++
                    }
                    if (count){
                        comboTime = 7
                        comboCount += count
                    }
                    if (alive){
                        if (comboCount > 1){
                            if (count){
                                combo.summon(comboCount, UUID)
                            }
                            title.show(10, 0, 20, 10, ("", "gold", "bold"))
                            title.showSubtitle((comboCount, "gold", "bold"), (" Combo !", "gold", "bold"))
                        }
                        else{
                            title.show(10, 0, 20, 10, ("", "gold", "bold"))
                            title.showSubtitle(("", "gold", "bold"))
                        }
                    }
                    cutter -= @s
                }
                with(previousEntity,false,a == UUID){
                    /tp @s ~ ~ ~
                    tag.remove("line.previous")
                }
                with(@e[tag=line.newpoint]){
                    tag.remove("line.newpoint")
                }
            }
            if (block(minecraft:black_concrete)){
                int a = UUID
                with(previousEntity,false,a == UUID){
                    /tp @s ~ ~ ~
                }
                with(newEntity,false,a == UUID){
                    /tp @s ~ ~ ~
                }
            }
        }
    }
    def onStop(){
        player.stop()
    }
}
PositionLock lock{
    set(0 6 14)
}

def start(){
    entity.kill(previousEntity)
    entity.kill(newEntity)
    int count = 0
    colorCount = 0
    with(@a,true){
        maps.theblueman003.screen.stop()
        count ++
        init()
        score = 0
        main.start()
        click.start()
        lock.start()
        color = colorCount
        colorCount++
        colorCount %= 8
        alive = true
        music.play()
    }
    multiplayer = count > 1
    if (multiplayer){
        sb.showSidebar(score, ("Score", "gold", "bold"))
    }
    life = 3
    game.start()
    fruit.game.start()
}

def stop(){
    with(@a,true){
        main.stop()
        click.stop()
        music.stop()
    }
    gameover.start()
    game.stop()
    fruit.game.stop()
    sb.showSidebar(pb, ("Highscore", "gold", "bold"))
}

Process gameover{
    int tick
    def main(){
        tick++
        if (tick > 60){
            if (multiplayer){
                showLeaderboard()
            }
            with(@a,true){
                hub.join()
                lock.stop()
                score = 0
            }
            stop()
        }
    }
    def onStart(){
        tick = 0
        score.onNewHighScore(@a, score, highscore){
            highscore = score
            title.show(10, 10, 60, 10, ("New Highscore !", "gold", "bold"))
            title.showSubtitle((highscore, "yellow", "bold"))
        }
    }
}

def die(){
    title.show(10, 10, 60, 10, ("You died !", "red", "bold"))
    title.showSubtitle(("Score: ", "gold", "bold"), (score, "yellow"))
    main.stop()
    click.stop()
    comboStop()
    alive = false
    pb := 0
    if (score > pb){
        pb = score
        title.show(10, 10, 60, 10, ("New Personal Best !", "gold", "bold"))
        title.showSubtitle((pb, "yellow", "bold"))
    }
}

def showLeaderboard(){
    int rank = 1
    score.forEachOrdered(@a, score, false){
        standard.print(("#","green"), (rank,"green"),(" - ", "green"), (@s,"green"), (" : ", "green"), (score,"green"))
        rank++
    }
}