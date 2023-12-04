package il
import mc.java.armor_stand as armor_stand

enum Color{
    red,
    orange,
    yellow,
    lime,
    green,
    light_blue,
    cyan,
    blue,
    purple,
    magenta
}
blocktag wall{
    minecraft:white_terracotta,
    minecraft:orange_terracotta,
    
    minecraft:magenta_terracotta,
    minecraft:light_blue_terracotta,
    minecraft:yellow_terracotta,
    minecraft:lime_terracotta,
    
    minecraft:pink_terracotta,
    minecraft:gray_terracotta,
    minecraft:light_gray_terracotta,
    minecraft:cyan_terracotta,
    
    minecraft:purple_terracotta,
    
    minecraft:blue_terracotta,
    minecraft:brown_terracotta,
    minecraft:green_terracotta,
    minecraft:red_terracotta,
    
    minecraft:purple_wool,
    minecraft:orange_wool,
    
    minecraft:magenta_wool,
    minecraft:light_blue_wool,
    minecraft:yellow_wool,
    minecraft:black_wool,
    
    minecraft:pink_wool,
    minecraft:gray_wool,
    minecraft:light_gray_wool,
    minecraft:cyan_wool,
    
    minecraft:blue_wool, 
    minecraft:brown_wool,
    minecraft:green_wool,
    minecraft:red_wool,
    minecraft:black_terracotta
}

class Selector with minecraft:armor_stand for mcjava{
    def __init__(Color ncolor){
        /data merge entity @s {Invisible:1,Marker:1}
        lazy int color = 1
        foreach(i in Color){
            if(ncolor == i){
                armor_stand.setModel(scute, color)
            }
            color++
        }
    }
    def move(){
        aligned(){
            if (block(~-0.51 ~ ~ ,minecraft:light) && block(~ ~ ~ ,#wall)){
                /tp @s ~-0.51 ~.5 ~
            }
        }
    }
}
scoreboard Color color
def getColor(){
    int ncolor = random.range(0, 10)
    int tries = 0
    bool cond = true
    while(cond){
        bool found = false
        with(@a, true, color == ncolor){
            found = true
        }
        if (!found){
            cond = false
        }
        if (found){
            ncolor++
            tries++
            if (tries > 10){
                cond = false
            }
        }
    }
    color = ncolor
}