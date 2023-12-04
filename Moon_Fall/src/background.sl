package player

class FlyingCar extends Sprite{
    int direction
    def  __init__(int direction){
        setTeleportDuration(1)
        this.direction = direction
        if (direction == -1){
            switch(random.range(0, 4)){
                0 -> setAnimation(addAnimation([addTextureVertical("flying_car_blue_left_"+i) for i in 0..3], 2, true))
                1 -> setAnimation(addAnimation([addTextureVertical("flying_car_lime_left_"+i) for i in 0..3], 2, true))
                2 -> setAnimation(addAnimation([addTextureVertical("flying_car_red_left_"+i) for i in 0..3], 2, true))
                3 -> setAnimation(addAnimation([addTextureVertical("flying_car_purple_left_"+i) for i in 0..3], 2, true))
            }
        }
        else{
            switch(random.range(0, 4)){
                0 -> setAnimation(addAnimation([addTextureVertical("flying_car_blue_right_"+i) for i in 0..3], 2, true))
                1 -> setAnimation(addAnimation([addTextureVertical("flying_car_lime_right_"+i) for i in 0..3], 2, true))
                2 -> setAnimation(addAnimation([addTextureVertical("flying_car_red_right_"+i) for i in 0..3], 2, true))
                3 -> setAnimation(addAnimation([addTextureVertical("flying_car_purple_right_"+i) for i in 0..3], 2, true))
            }
        }
        setScale(5, 5, 1)
    }
    def @tick(){
        if (direction == -1){
            /tp @s ~-0.6 ~ ~
        }
        else{
            /tp @s ~0.6 ~ ~
        }
        if (!@a[distance=..70]){
            ./kill
        }
    }
}
class MoonDebris extends Sprite{
    def  __init__(){
        setTeleportDuration(1)
        setTexture(addTextureVertical("moon_debris"))
        setScale(5, 5, 1)
    }
    def @tick(){
        /tp @s ~-0.6 ~-0.6 ~
        if (!@a[distance=..70]){
            ./kill
        }
    }
}
class Background extends Sprite{
    float shift
    float previous
    float speed
    bool master
    int world
    int animationDelay
    def lazy __init__(float shift, float zshift, float speed, Texture texture, int master, int world){
        this.shift = shift
        this.speed = speed
        this.master = master
        this.world = world
        setTexture(texture)
        setScale(30,30,1)
        setTranslation(0, 1, zshift)
        setTeleportDuration(0)
    }
    def update(float pos){
        float delta = ((pos * speed + 60) % (120)) - 60
        float befor = delta
        delta -= shift
        nbt.setNBT(delta, "transformation.translation[0]", "float", 0.001)
        float r = math.abs(delta - previous)
        if (r < 10.0){
            data.set({"start_interpolation": 0, "interpolation_duration": 1})
        }
        previous = delta        
        at(@s)if (master){
            if (world == 0){
                animationDelay--
                if (animationDelay < 0){
                    switch(random.range(0, 20)){
                        foreach(i in 0..9){
                            i -> at({~-30, ~(i.index-4)*1.5, ~-11})new FlyingCar(1)
                        }
                        foreach(i in 10..19){
                            i -> at({~30, ~(i.index-4)*1.5, ~-11})new FlyingCar(-1)
                        }
                    }
                    animationDelay = 30
                }
            }
            if (world == 3){
                animationDelay--
                if (animationDelay < 0){
                    switch(random.range(0, 20)){
                        foreach(i in 0..9){
                            i -> at({~30, ~(i.index+2)*1.5, ~-11})new MoonDebris()
                        }
                        foreach(i in 10..29){
                            i -> at({~30, ~(i.index+2)*1.5, ~-9})new MoonDebris()
                        }
                    }
                    animationDelay = 60
                }
            }
        }
    }
    def delete(){
        /kill
    }
}
class Room extends DisplayBlock{
    def this(){
        setScale(50,30,51)
        setBlock(minecraft:grass_block)
        setTranslation(-25, -15, -25.5)
        /tag @s add room.background
    }
    def delete(){
        /kill
    }
}
class Moon extends Background{
    def lazy __init__(Texture texture, float zshift){
        this.shift = -10
        this.speed = 0
        setTexture(texture)
        setScale(10,10,1)
        setTranslation(0, 10, zshift)
    }
    def delete(){
        /kill
    }
}
def lazy loadLayer(int world, int layer, float speed){
    Compiler.insert(($layer, $world), (layer, world)){
        new Background(120.0, -15 + layer /10.0, speed, addTextureVertical("background_world_$world_layer_$layer_part_0"), layer == 0, world)
        new Background(90.0, -15 + layer /10.0, speed, addTextureVertical("background_world_$world_layer_$layer_part_1"), false, world)
        new Background(60.0, -15 + layer /10.0, speed, addTextureVertical("background_world_$world_layer_$layer_part_2"), false, world)
        new Background(30.0, -15 + layer /10.0, speed, addTextureVertical("background_world_$world_layer_$layer_part_3"), false, world)
        new Background(00.0, -15 + layer /10.0, speed, addTextureVertical("background_world_$world_layer_$layer_part_0"), false, world)
        new Background(-030.0, -15 + layer /10.0, speed, addTextureVertical("background_world_$world_layer_$layer_part_1"), false, world)
        new Background(-060.0, -15 + layer /10.0, speed, addTextureVertical("background_world_$world_layer_$layer_part_2"), false, world)
        new Background(-90.0, -15 + layer /10.0, speed, addTextureVertical("background_world_$world_layer_$layer_part_3"), false, world)
    }
}
def lazy loadBackground(int world, int count){
    lazy int max = count-1
    foreach(i in 0..max){
        loadLayer(world, i, -i / 10.0)
    }
    switch(world){
        0 -> new Moon(addTextureVertical("moon_cracked"), -15.0 + 0.05)
        1 -> new Moon(addTextureVertical("moon_cracked_2"), -15.0 + 0.05)
        2 -> new Moon(addTextureVertical("moon_cracked_3"), -15.0 + 0.05)
        3 -> new Moon(addTextureVertical("moon_cracked_4"), -15.0 + 0.05)
    }
}