package player

class DeathParticle extends Particle{
    def  __init__(){
        setAnimation(addAnimation([addTextureVertical("death_particle_"+i) for i in 0..7], 2, true))
        setCenterBillboard()
        setScale(0.25, 0.25, 0.25)
        float x = random.rangeFloat(-0.4,0.4)
        float y = random.rangeFloat(-0.4,0.4)
        this.motion = new(x, y, 0)
        this.acceleration = new(-x/200, -y/200, 0)
    }
    def @tick(){
        if (age == 20){
            interpolateScale(40, 0, 0, 0)
        }
    }
}

class SparkParticle extends Particle{
    def  __init__(){
        setAnimation(addAnimation([addTextureVertical("spark_"+i) for i in 0..1], 2, true))
        setCenterBillboard()
        setScale(0.5, 0.5, 0.5)
        float x = random.rangeFloat(-0.4,0.4)
        float y = random.rangeFloat(-0.4,-0.1)
        this.motion = new(x, y, 0)
        this.acceleration = new(0, 0, 0)
    }
    def @tick(){
        if (age == 20){
            interpolateScale(40, 0, 0, 0)
        }
    }
}

class WallJumpParticle extends Particle{
    def  __init__(){
        setTexture(addTextureVertical("wall_jump_particle"))
        setScale(2, 2, 1)
        this.motion = new(0, 0, 0)
        this.acceleration = new(0,0,0)
    }
    def @tick(){
        if (age == 5){
            interpolateScale(10, 0, 0, 0)
        }
    }
}

class Trail extends Sprite{
    int tick
    def __init__(Texture anim){
        setScale(2,2,1)
        setTranslation(0, 0.8, 0)
        switch(anim){
            foreach(i in 0..1000){
                i -> setTexture(i)
            }
        }
    }
    def @tick(){
        tick++
        if (tick >= 20){
            /kill
        }
    }
}

class CloudParticle extends Particle{
    def  __init__(){
        setAnimation(addAnimation([addTextureVertical("spr_cloud_0")], 2, true))
        setCenterBillboard()
        float x = random.rangeFloat(-0.5,0.5)
        float y = random.rangeFloat(-0.5,0.5)
        this.motion = new(x, y, 0)
        this.acceleration = new(0, 0, 0)
    }
    def @tick(){
        if (age == 2){
            interpolateScale(20, 0, 0, 0)
        }
    }
}

class DoubleJumpParticle extends Particle{
    def this(){
        setAnimation(addAnimation([addTextureVertical("double_jump_effect_"+i) for i in 0..6], 1, false))
        setCenterBillboard()
        setScale(4,4,4)
    }
}

class SpeedParticle extends Particle{
    def this(){
        setAnimation(addAnimation([addTextureVertical("speed_effect_"+i) for i in 0..6], 1, false))
        setCenterBillboard()
        setScale(4,4,4)
    }
}

class SlowFallParticle extends Particle{
    def this(){
        setAnimation(addAnimation([addTextureVertical("slow_fall_effect_"+i) for i in 0..6], 1, false))
        setCenterBillboard()
        setScale(4,4,4)
    }
}