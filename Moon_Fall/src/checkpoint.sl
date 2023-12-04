package checkpoint

from mc.sprite import _
import cmd.sound as sound
import mc.pointer as pointer

bool hasCheckpoint := false
int id
int checkpoint_x
int checkpoint_y
int checkpoint_z
def clear(){
    hasCheckpoint = false
    id = 0
}
[nbt="Pos[0]"] scoreboard json position_x
[nbt="Pos[1]"] scoreboard json position_y
[nbt="Pos[2]"] scoreboard json position_z
def test(){
    standard.print(hasCheckpoint,",",checkpoint_x,",", checkpoint_y,",", checkpoint_z)
}
macro void tpAt(int x, int y, int z){
    ./tp @a $(x) $(y) $(z)
}
bool loadPlayer(){
    if (hasCheckpoint){
        tpAt(checkpoint_x, checkpoint_y, checkpoint_z)
        return true
    }
    else{
        return false
    }
}
macro bool isLoaded(int x, int y, int z){
    if (loaded("$(x) $(y) $(z)")){
        return true
    }
    else{
        return false
    }
}
bool loadCharacter(){
    if (isLoaded(checkpoint_x, checkpoint_y, checkpoint_z)){
        with(Checkpoint){
            align("z")at(~~~0.5)summonPlayer()
        }
        return true
    }
    else{
        return false
    }
}

class Checkpoint extends Sprite{
    def lazy this(int width, int height){
        setScale(width/16.0, height/16.0, 1)
        align("xyz")at({~,~height/32.0,~})./tp @s ~ ~ ~0.99
    }
    def @tick(){
        int a = this :> int
        if (a != id){
            setAnimation(addAnimation([addTextureVertical("checkpoint_"+i) for i in 0..3], 4, true))
        }
        else{
            setAnimation(addAnimation([addTextureVertical("checkpoint_taken_"+i) for i in 0..3], 4, true))
        }
    }
    def check(){
        int a = this :> int
        if (id != a || !hasCheckpoint){
            id = a
            hasCheckpoint = true
            checkpoint_x = position_x
            checkpoint_y = position_y
            checkpoint_z = position_z
            with(@a,true)sound.play(minecraft:entity.player.levelup)
            at(@s){
                at(~~~0.1)new CheckpointParticle()
                repeat(10){
                    at(~~~0.1)new StarParticle()
                }
            }
        }
    }
    def summonPlayer(){
        int a = this :> int
        if (id == a && hasCheckpoint){
            at(@s)at(~~-1~){
                if (level.level <= 3){
                    new player.Player(0, level.backgroundCity)
                }
                else if (level.level <= 6){
                    new player.Player(0, level.backgroundPlains)
                }
                else if (level.level <= 9){
                    new player.Player(0, level.backgroundOwl)
                }
                else if (level.level <= 12){
                    new player.Player(0, level.backgroundDog)
                }
            }
        }
    }
}
class StarParticle extends Particle{
    def this(){
        setAnimation(addAnimation([addTextureVertical("mini_star_"+i) for i in 0..1], 2, true))
        setCenterBillboard()
        setScale(0.5, 0.5, 0.5)
        float x = random.rangeFloat(-0.2,0.2)
        float y = random.rangeFloat(-0.2,0.2)
        this.motion = new(x, y, 0)
        this.acceleration = new(0, 0, 0)
    }
}
class CheckpointParticle extends Particle{
    def this(){
        setAnimation(addAnimation([addTextureVertical("checkpoint_particle_"+i) for i in 0..6], 1, false))
        setCenterBillboard()
        setScale(4,4,4)
    }
}
def summon(){
    new Checkpoint(32, 32)
}
def remove_near(){
    with(@e[distance=..3] in Checkpoint){
        ./kill
    }
}
def take(){
    with(@e[distance=..3] in Checkpoint){
        check()
    }
}
