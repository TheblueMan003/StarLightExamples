package mc.sprite

import mc.java.resourcespack.models as models
from mc.bedrock.Entity import Entity as BedrockEntity
from mc.Entity import Entity as EntityObject
import mc.java.display.DisplayItem
import cmd.entity as entity
import utils.Process
import math.Vector3

typedef int Texture
typedef int Animation


lazy var textureCount = 0
lazy var animationCount = 0
lazy var scalesCount = 0
lazy var scales = []
lazy var animations = []

BedrockEntity SpriteEntity{
    setName("sprite")
    setGeometry("sprite")
    setIsSpawnable(true)
    isPushable(false, false)
    setCollision(0, 0)
    setInvinsible()
    def lazy addTexture(string $tex){
        addTexture("$tex", "entities/$tex")
        lazy var a = textureCount + 1
        lazy var id = "set_sprite_"+a
        event(id){
            setVariant(textureCount)
        }
    }
    def lazy addScale(float scl){
        if (!(scl in scales)){
            lazy var id = "set_scale_"+scalesCount
            event(id){
                scale(scl)
            }
            scalesCount++
            scales += scl
        }
    }
}
def lazy Texture addTexture(string name){
    Compiler.insert($name,name){
        [java_rp=true] jsonfile models.item.spr_$name{
            "credit": "Made with Blockbench",
            "texture_size": [32, 32],
            "textures": {
                "0": "item/$name",
                "particle": "item/$name"
            },
            "elements": [
                {
                    "from": [0, 0, 0],
                    "to": [16, 0, 16],
                    "faces": {
                        "north": {"uv": [16, 16, 0, 0], "texture": "#0"},
                        "east": {"uv": [16, 16, 0, 0], "texture": "#0"},
                        "south": {"uv": [16, 16, 0, 0], "texture": "#0"},
                        "west": {"uv": [16, 16, 0, 0], "texture": "#0"},
                        "up": {"uv": [16, 16, 0, 0], "texture": "#0"},
                        "down": {"uv": [16, 16, 0, 0], "texture": "#0"}
                    }
                }
            ]
        }
        models.add(minecraft:acacia_boat, "item/spr_$name", textureCount+1)
    }
    SpriteEntity.addTexture(name)

    lazy var file = "bedrock_resourcepack/textures/entities/"+name+".png"
    lazy var exists = File.exists(file)
    if (exists){
    }
    else{
        if (File.exists("lib/sprite/bedrock_resourcepack/textures/entities/import_java_sprite.py")){
            lazy var cmd = "python lib/sprite/bedrock_resourcepack/textures/entities/import_java_sprite.py "+name
            Compiler.print("Converting Java Sprite to Bedrock sprite: "+name)
            File.run(cmd)
        }
    }

    lazy var id = textureCount
    textureCount++
    return id + 1
}
def lazy Texture addTextureVertical(string name){
    Compiler.insert($name,name){
        [java_rp=true] jsonfile models.item.spr_$name{
            "credit": "Made with Blockbench",
            "texture_size": [32, 32],
            "textures": {
                "0": "item/$name",
                "particle": "item/$name"
            },
            "elements": [
                {
                    "from": [0, 0, 8],
                    "to": [16, 16, 8],
                    "faces": {
                        "north": {"uv": [0, 0, 16, 16], "texture": "#0"},
                        "east": {"uv": [0, 0, 16, 16], "texture": "#0"},
                        "south": {"uv": [0, 0, 16, 16], "texture": "#0"},
                        "west": {"uv": [0, 0, 16, 16], "texture": "#0"},
                        "up": {"uv": [0, 0, 16, 16], "texture": "#0"},
                        "down": {"uv": [0, 0, 16, 16], "texture": "#0"}
                    }
                }
            ]
        }
        models.add(minecraft:acacia_boat, "item/spr_$name", textureCount+1)
    }
    SpriteEntity.addTexture(name)

    lazy var file = "bedrock_resourcepack/textures/entities/"+name+".png"
    lazy var exists = File.exists(file)
    if (exists){
    }
    else{
        if (File.exists("lib/sprite/bedrock_resourcepack/textures/entities/import_java_sprite.py")){
            lazy var cmd = "python lib/sprite/bedrock_resourcepack/textures/entities/import_java_sprite.py "+name
            Compiler.print("Converting Java Sprite to Bedrock sprite: "+name)
            File.run(cmd)
        }
    }

    lazy var id = textureCount
    textureCount++
    return id + 1
}
def lazy Animation addAnimation(json sprites, int frame_time = 1, bool loop = true, void=>void callback = null){
    def lazy @sprite.animation tick(int tick, int=>void set){
        lazy var length = Compiler.length(sprites)
        var t = tick / frame_time
        if (loop){
            switch(t % length){
                foreach(sprite in sprites){
                    sprite.index -> set(sprite)
                }
            }
        }
        else{
            switch(tick){
                foreach(sprite in sprites){
                    sprite.index -> set(sprite)
                }
            }
            if (t >= length){
                callback()
            }
        }
    }
    animations = animations + tick
    lazy var id = animationCount
    animationCount++
    return id + 1
}
def lazy Animation addAnimationFromStrip(string sprite, int count, int frame_time = 1, bool loop = true, void=>void callback = null){
    lazy var sprites_ = []
    lazy var max = count - 1
    lazy var sid = 0
    foreach(i in 0..max){
        sid = addTexture(sprite+"_"+i)
        sprites_ = sprites_ + sid
    }
    return addAnimation(sprites_, frame_time, loop, callback)
}

typedef EntityObject Parent for mcbedrock, DisplayItem Parent for mcjava
class Sprite extends Parent with sl:sprite for mcbedrock{
    int animationTick
    Animation animation
    Texture texture

    [compile.order=999999]
    public @sprite.tick void main(){
        switch(animation){
            foreach(anim in animations){
                anim.index + 1 -> anim(animationTick, setTexture)
            }
        }
        animationTick++
    }
    public void setAnimation(Animation anim){
        if (anim != animation){
            animation = anim
            animationTick = 0
        }
        animator.start()
    }
    public lazy void setTexture(int index){
        texture = index
        if (Compiler.isBedrock()){
            entity.event("set_sprite_"+index)
        }
        if (Compiler.isJava()){
            setItem("minecraft:acacia_boat", {CustomModelData: index})
        }
    }
    public int getTexture(){
        return texture
    }
    public lazy void setSize(float scale){
        if (Compiler.isJava()){
            setScale(scale, 1, scale)
        }
        if (Compiler.isBedrock()){
            setScale(scale)
        }
    }
}
class Particle extends Sprite{
    Vector3 motion
    Vector3 acceleration
    int age

    def lazy __init__(Animation animation, Vector3 motion, Vector3 acceleration){
        setAnimation(animation)
        setCenterBillboard()
        this.motion = motion
        this.acceleration = acceleration
    }
    def lazy __init__(Animation animation, float mx, float my, float mz, float ax, float ay, float az){
        setAnimation(animation)
        setCenterBillboard()
        this.motion = new Vector3(mx, my, mz)
        this.acceleration = new Vector3(ax, ay, az)
    }

    public virtual int getMaxAge(){
        return 60
    }
    public @sprite.tick void main2(){
        float dx = motion.x
        while(dx > 0.1)at(@s){
            dx -= 0.1
            /tp @s ~0.1 ~ ~
        }
        while(dx < -0.1)at(@s){
            dx += 0.1
            /tp @s ~-0.1 ~ ~
        }

        float dy = motion.y
        while(dy > 0.1)at(@s){
            dy -= 0.1
            /tp @s ~ ~0.1 ~
        }
        while(dy < -0.1)at(@s){
            dy += 0.1
            /tp @s ~ ~-0.1 ~
        }

        float dz = motion.z
        while(dz > 0.1)at(@s){
            dz -= 0.1
            /tp @s ~ ~ ~0.1
        }
        while(dz < -0.1)at(@s){
            dz += 0.1
            /tp @s ~ ~ ~-0.1
        }

        motion += acceleration
        age += 1

        if (age >= getMaxAge()){
            /kill
        }
    } 
}

Process animator{
    def main(){
        @sprite.tick()
    }
}

def start(){
    animator.start()
}
def stop(){
    animator.stop()
}
