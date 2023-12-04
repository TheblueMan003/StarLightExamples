package painter

import utils.Process
import mc.Click
import mc.PositionLock
import mc.blocktags as tags
import mc.pointer as pointer
import cmd.entity as entity
import mc.java.nbt as nbt
import cmd.block as block
import cmd.sound as sound
import math.raycast as raycast
import utils.draw as drw
import standard::print

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

entity drawer
entity previous
entity current
int tool
int undoCount
int undoCountMax
int undoCountMin
scoreboard int color
scoreboard int prevColor

int squareMod
int fillMod
int circleMod

blocktag air{
    minecraft:air,
    minecraft:light
}

def cycleSquareMod(){
    squareMod = (squareMod + 1) % 3
    updateSquareMod()
}
def updateSquareMod(){
    switch(squareMod for i in 0..2){
        i -> block.clone({4, 51, -34 - i}, {13, 60, -34- i}, {4, 52, -30})
    }
}

def cycleFillMod(){
    fillMod = (fillMod + 1) % 2
    updateFillMod()
}
def updateFillMod(){
    switch(fillMod for i in 0..1){
        i -> block.clone({-26, 52, -34 - i}, {-17, 61, -34 - i}, {-26, 52, -30})
    }
}

def cycleCircleMod(){
    circleMod = (circleMod + 1) % 3
    updateCircleMod()
}
def updateCircleMod(){
    switch(circleMod for i in 0..2){
        i -> block.clone({14, 52, -34 - i}, {23, 61, -34 - i}, {14, 52, -30})
    }
}

Process main{
    def main(){
        with (@a in drawer,true){
            word.show()
            int toolIndex = -1
            int sideIndex = -1
            raycast.shoot(150,0.5,!block(#air)){
                if(block(~ ~ ~-1,minecraft:oak_planks)){
                    at(~ ~ ~-2){
                        toolIndex = tags.index(#Colors)
                    }
                }
                if(block(~ ~ ~-1,minecraft:spruce_planks)){
                    at(~ ~ ~-2){
                        sideIndex = tags.index(#Colors)
                    }
                }
            }
            hoverTool(toolIndex)
            hoverSide(sideIndex)
        }
    }
}

Click click{
    bool hasChanged
    def onClick(){
        if (@s in drawer){
            hasChanged = false
            int c = color
            raycast.shoot(150,0.5,!block(#air)){
                if (tool == 1){
                    if(block(~ ~ ~-1,minecraft:white_concrete)){
                        hasChanged = true
                        if (fillMod == 0){
                            fill(c)
                        }
                        else if (fillMod == 1){
                            replace(c)
                        }
                    }
                }
                if (tool == 2){
                    prevColor = color
                    color = tags.index(#Colors)
                    selectColor(color)
                    setTool(0)
                }
                if (tool == 3){
                    at(~ ~ -29){
                        previous = pointer.newPointer(){
                        }
                        current = pointer.newPointer(){
                        }
                    }
                }
                if (tool == 4){
                    at(~ ~ -29){
                        previous = pointer.newPointer(){
                        }
                        current = pointer.newPointer(){
                        }
                    }
                }
                if (tool == 5){
                    at(~ ~ -29){
                        previous = pointer.newPointer(){
                        }
                        current = pointer.newPointer(){
                        }
                    }
                }

                if(block(~ ~ ~-1,minecraft:orange_concrete)){
                    prevColor = color
                    color = tags.index(#Colors)
                    selectColor(color)
                }
                if(block(~ ~ ~-1,minecraft:oak_planks)){
                    at(~ ~ ~-2){
                        int index = tags.index(#Colors)
                        if (index == 1 && tool == 1){
                            cycleFillMod()
                        }
                        if (index == 4 && tool == 4){
                            cycleSquareMod()
                        }
                        if (index == 5 && tool == 5){
                            cycleCircleMod()
                        }
                        setTool(tags.index(#Colors))
                    }
                }
                if(block(~ ~ ~-1,minecraft:spruce_planks)){
                    at(~ ~ ~-2){
                        switch(tags.index(#Colors)){
                            0 -> save.save()
                            1 -> undo()
                            2 -> redo()
                            3 -> clear()
                        }
                    }
                }
            }
        }
    }
    def onHold(){
        if (@s in drawer){
            int c = color
            int c2 = prevColor
            raycast.shoot(150,0.5,!block(#air)){
                if (tool == 0){
                    if (!previous || !current){
                        previous = pointer.newPointer(){
                        }
                        current = pointer.newPointer(){
                        }
                    }
                    else{
                        with(current){
                            /tp @s ~ ~ ~
                        }
                        drw.line(previous, current){
                            if (!block(#air)){
                                if(block(~ ~ ~-1,minecraft:white_concrete)){
                                    hasChanged = true
                                    tags.set(#Colors, c)
                                }
                            }
                        }
                        with(previous){
                            /tp @s ~ ~ ~
                        }
                    }
                }
                if (tool == 3){
                    at(~ ~ -29){
                        with(current){
                            /tp @s ~ ~ ~
                        }
                    }
                    block.fill(-36 0 -29,36 50 -29, minecraft:air)
                    drw.line(previous, current){
                        if (!block(~ ~ ~-1,minecraft:air)){
                            if(block(~ ~ ~-2,minecraft:white_concrete)){
                                hasChanged = true
                                tags.set(#Colors, c)
                            }
                        }
                    }
                }
                if (tool == 4){
                    at(~ ~ -29){
                        with(current){
                            /tp @s ~ ~ ~
                        }
                    }
                    block.fill(-36 0 -29,36 50 -29, minecraft:air)
                    if(block(~ ~ ~-1,#Colors)){
                        def inner(){
                            if (!block(~ ~ ~-1,minecraft:air)){
                                if(block(~ ~ ~-2,minecraft:white_concrete)){
                                    hasChanged = true
                                    tags.set(#Colors, c2)
                                }
                            }
                        }

                        square(previous, current, inner){
                            if (!block(~ ~ ~-1,minecraft:air)){
                                if(block(~ ~ ~-2,minecraft:white_concrete)){
                                    hasChanged = true
                                    tags.set(#Colors, c)
                                }
                            }
                        }
                    }
                }
                if (tool == 5){
                    at(~ ~ -29){
                        with(current){
                            /tp @s ~ ~ ~
                        }
                    }
                    block.fill(-36 0 -29,36 50 -29, minecraft:air)
                    if(block(~ ~ ~-1,#Colors)){
                        def inner(){
                            if (!block(~ ~ ~-1,minecraft:air)){
                                if(block(~ ~ ~-2,minecraft:white_concrete)){
                                    hasChanged = true
                                    tags.set(#Colors, c2)
                                }
                            }
                        }

                        elipses(previous, current, inner){
                            if(block(~ ~ ~-2,minecraft:white_concrete)){
                                hasChanged = true
                                tags.set(#Colors, c)
                            }
                        }
                    }
                }
            }
        }
    }
    def onRelease(){
        if (tool == 3){
            block.cloneMask(-36 0 -29,36 50 -29, -36 0 -30)
            block.fill(-36 0 -29,36 50 -29, minecraft:air)
        }
        if (tool == 4){
            block.cloneMask(-36 0 -29,36 50 -29, -36 0 -30)
            block.fill(-36 0 -29,36 50 -29, minecraft:air)
        }
        if (tool == 5){
            block.cloneMask(-36 0 -29,36 50 -29, -36 0 -30)
            block.fill(-36 0 -29,36 50 -29, minecraft:air)
        }
        if (hasChanged){
            commit()
        }
        with(previous){
            entity.kill()
        }
        with(current){
            entity.kill()
        }
    }
}
def selectColor(int color){
    /fill 37 52 -30 46 61 -30 minecraft:black_concrete
    color := 0
    switch(color for c in Colors){
        c.index -> Compiler.insert($c, c){
            ./fill 38 53 -30 45 60 -30 $c
        }
    }
}
def circle(){
    setTool(5)
}

def fill(int color){
    int c = tags.index(#Colors)
    if (color != c){
        def rec(){
            tags.set(#Colors, color)
            at(~-1 ~ ~)if (tags.index(#Colors) == c)rec()
            at(~1 ~ ~)if (tags.index(#Colors) == c)rec()
            at(~ ~1 ~)if (tags.index(#Colors) == c)rec()
            at(~ ~-1 ~)if (tags.index(#Colors) == c)rec()
        }
        rec()
    }
}
def replace(int color){
    int c = tags.index(#Colors)
    if (color != c){
        def recH(){
            at(~1 ~ ~)if (block(#Colors))recH()
            recV()
        }
        def recV(){
            if (tags.index(#Colors) == c)tags.set(#Colors, color)
            at(~ ~-1 ~)if (block(#Colors))recV()
        }
        at(-36 50 -30)recH()
    }
}
PositionLock lock{
    set(0 21 15)
}
def setDrawer(){
    drawer = @s
    color = 15
    selectColor(15)
    undoCount = 0
    undoCountMax = 0
    undoCountMin = 0

    squareMod = 0
    updateSquareMod()

    fillMod = 0
    updateFillMod()

    circleMod = 0
    updateCircleMod()

    setTool(0)
    clear()
    click.start()
    main.start()
    lock.start()
}
def @game.nextRound stop(){
    with(drawer,true){
        main.stop()
        click.stop()
        lock.stop()
        drawer -= @s
    }
}

def setTool(int t){
    lazy var x = 0
    foreach(i in 0..5){
        x = i*10 - 36
        Compiler.insert($x, x){
            at($x 61 -30){
                unselectBox()
            }
        }
    }
    tool = t

    switch(tool){
        foreach(i in 0..5){
            i -> {
                x = i*10 - 36
                Compiler.insert($x, x){
                    at($x 61 -30){
                        selectBox()
                    }
                }
            }
        }
    }
}
def hoverTool(int t){
    setTool(tool)
    lazy var x = 0
    switch(t){
        foreach(i in 0..5){
            i -> {
                x = i*10 - 36
                Compiler.insert($x, x){
                    at($x 61 -30){
                        hoverBox()
                    }
                }
            }
        }
    }
}
def hoverSide(int t){
    lazy var y = 0
    foreach(i in 0..3){
        y = 50 -i*10
        Compiler.insert($y, y){
            at(-47 $y -30){
                unselectBox()
            }
        }
    }
    switch(t){
        foreach(i in 0..3){
            i -> {
                y = 50 -i*10
                Compiler.insert($y, y){
                    at(-47 $y -30){
                        hoverBox()
                    }
                }
            }
        }
    }
}

def selectBox(){
    block.fill(~~~,~9~~,minecraft:lime_concrete)
    block.fill(~~~,~~-9~,minecraft:lime_concrete)
    block.fill(~~-9~,~9~-9~,minecraft:lime_concrete)
    block.fill(~9~~,~9~-9~,minecraft:lime_concrete)
}
def hoverBox(){
    block.fill(~~~,~9~~,minecraft:yellow_concrete)
    block.fill(~~~,~~-9~,minecraft:yellow_concrete)
    block.fill(~~-9~,~9~-9~,minecraft:yellow_concrete)
    block.fill(~9~~,~9~-9~,minecraft:yellow_concrete)
}
def unselectBox(){
    block.fill(~~~,~9~~,minecraft:black_concrete)
    block.fill(~~~,~~-9~,minecraft:black_concrete)
    block.fill(~~-9~,~9~-9~,minecraft:black_concrete)
    block.fill(~9~~,~9~-9~,minecraft:black_concrete)
}

def undoSave(){
    lazy var z = 0
    switch(undoCount % 21){
        foreach(i in 0..20){
            i -> {
                z = -40 - i
                Compiler.insert($z, z){
                    block.clone(-36 0 -30,36 50 -30, -36 0 $z)
                }
            }
        }
    }
}
def undoLoad(){
    lazy var z = 0
    switch(undoCount % 21){
        foreach(i in 0..20){
            i -> {
                z = -40 - i
                Compiler.insert($z, z){
                    block.clone(-36 0 $z,36 50 $z, -36 0 -30)
                }
            }
        }
    }
}
def commit(){
    undoCount++
    undoSave()
    undoCountMax = undoCount
    undoCountMin = undoCount-20
}
def undo(){
    if (undoCount > undoCountMin && undoCount > 0){
        undoCount--
        undoLoad()
    }
}
def redo(){
    if (undoCount < undoCountMax){
        undoCount++
        undoLoad()
    }
}
def clear(){
    screen.create()
    commit()
}

public lazy int square(mcposition start, mcposition end, void=>void action2, void=>void action){
    import mc.java.nbt as nbt

    int x1, y1, x2, y2 
    as(start){
        x1, y1 = nbt.x, nbt.y
    }
    as(end){
        x2, y2 = nbt.x, nbt.y
    }

    at(start){
        pointer.run(){
            int sx = (x1 < x2) ? x1 : x2
            int sy = (y1 < y2) ? y1 : y2

            int ex = (x1 > x2) ? x1 : x2
            int ey = (y1 > y2) ? y1 : y2

            for(int i = sx; i <= ex; i++){
                for(int j = sy; j <= ey; j++){
                    nbt.x = i
                    nbt.y = j
                    at(@s){
                        if (squareMod == 0){
                            if (i != sx && i != ex && j != sy && j != ey){
                            }
                            else{
                                action()
                            }
                        }
                        else if (squareMod == 1){
                            action()
                        }
                        else if (squareMod == 2){
                            if (i != sx && i != ex && j != sy && j != ey){
                                action2()
                            }
                            else{
                                action()
                            }
                        }
                    }
                }
            }
        }
    }
}
public lazy int elipses(mcposition start, mcposition end, void=>void action2, void=>void action){
    import mc.java.nbt as nbt
    def step1(){
        int sx, sy, ex, ey
        as(start){
            sx,sy = nbt.x, nbt.y
        }
        as(end){
            ex,ey = nbt.x, nbt.y
        }
        int dx = (math.abs(ex - sx) + 1)/2
        int dy = (math.abs(ey - sy) + 1)/2
        at(start){
            pointer.run(){
                int x = (sx < ex) ? sx : ex
                int y = (sy < ey) ? sy : ey

                int cx = (sx + ex)/2
                int cy = (sy + ey)/2

                nbt.x = x
                nbt.y = y
                for(int i = -1; i < dx*2+1; i++){
                    for(int j = -1; j < dy*2+1; j++){
                        at(@s){
                            int a = (dx * dx)
                            int b = (dy * dy)

                            int c = ((dx-1) * (dx-1))
                            int d = ((dy-1) * (dy-1))

                            int x_diff = x - cx
                            int y_diff = y - cy

                            float xd2 = x_diff * x_diff
                            float yd2 = y_diff * y_diff

                            float p = ((xd2 / a) + (yd2 / b))
                            
                            if (p <= 1){
                                if(block(~ ~ ~-2,minecraft:white_concrete)){
                                    at(~~~1)block.set(minecraft:stone)
                                }
                            }
                        }
                        y++
                        nbt.y = y
                    }
                    x++
                    nbt.x = x
                    y = (sy < ey) ? sy : ey
                    nbt.y = y
                }
            }
        }
    }
    def step2(){
        int x1, y1, x2, y2 
        as(start){
            x1, y1 = nbt.x, nbt.y
        }
        as(end){
            x2, y2 = nbt.x, nbt.y
        }

        at(start){
            pointer.run(){
                int sx = (x1 < x2) ? x1 : x2
                int sy = (y1 < y2) ? y1 : y2

                int ex = (x1 > x2) ? x1 : x2
                int ey = (y1 > y2) ? y1 : y2

                for(int i = sx; i <= ex; i++){
                    for(int j = sy; j <= ey; j++){
                        nbt.x = i
                        nbt.y = j
                        at(@s)if (block(~~~1,minecraft:stone)){
                            if (circleMod == 0){
                                if (!block(~~1~1, minecraft:air) && !block(~~-1~1, minecraft:air) && !block(~-1~~1, minecraft:air) && !block(~1~~1, minecraft:air)){
                                    block.set(minecraft:air)
                                }
                                else{
                                    action()
                                }
                            }
                            else if (circleMod == 1){
                                action()
                            }
                            else if (circleMod == 2){
                                if (!block(~~1~1, minecraft:air) && !block(~~-1~1, minecraft:air) && !block(~-1~~1, minecraft:air) && !block(~1~~1, minecraft:air)){
                                    action2()
                                }
                                else{
                                    action()
                                }
                            }
                        }
                    }
                }
                block.fill(-36 0 -28,36 50 -28, minecraft:air)
            }
        }
    }

    step1()
    step2()
}