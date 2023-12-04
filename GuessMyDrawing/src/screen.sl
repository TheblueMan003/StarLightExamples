package screen

import cmd.block as b

blocktag Colors{
    minecraft:white_concrete,
    minecraft:orange_concrete,
    minecraft:magenta_concrete,
    minecraft:light_blue_concrete,
    minecraft:yellow_concrete,
    minecraft:lime_concrete,
    minecraft:pink_concrete,
    minecraft:gray_concrete,
    minecraft:light_gray_concrete,
    minecraft:cyan_concrete,
    minecraft:purple_concrete,
    minecraft:blue_concrete,
    minecraft:brown_concrete,
    minecraft:green_concrete,
    minecraft:red_concrete,
    minecraft:black_concrete
}

def create(){
    b.fill(-36 0 -30,36 50 -30, minecraft:white_concrete)
    b.fill(-36 0 -31,36 50 -31, minecraft:white_concrete)

    lazy var x = 0
    lazy var y = 0
    foreach(color in #Colors){
        lazy var dx = x * 4 + 38
        lazy var dy = 50 - y * 4
        lazy var ex = dx + 3
        lazy var ey = dy - 3
        Compiler.insert(($dx, $dy, $ex, $ey), (dx, dy, ex, ey)){
            b.fill($dx $dy -30, $ex $ey -30, color)
        }
        x += 1
        if (x >= 2){
            x = 0
            y += 1
        }
    }
}