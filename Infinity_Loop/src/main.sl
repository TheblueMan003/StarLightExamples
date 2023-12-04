package il

import cmd.effect as effect
import cmd.block as block
from cmd.entity import _
import cmd.tag as tag
import math.raycast as raycast
import mc.Click
import mc.PositionLock
import utils.PProcess
import utils
import random
import standard::print

[name="PlayerID"] scoreboard int PlayerID

lazy int gridSize = 15


enum Blocks(mcobject source, mcobject next, int constraints){
    white_terracotta(minecraft:white_terracotta, minecraft:orange_terracotta, (4 + 1)),
    orange_terracotta(minecraft:orange_terracotta, minecraft:white_terracotta, (2 + 8)),
    
    magenta_terracotta(minecraft:magenta_terracotta, minecraft:light_blue_terracotta, (4 + 2)),
    light_blue_terracotta(minecraft:light_blue_terracotta, minecraft:yellow_terracotta, (2 + 1)),
    yellow_terracotta(minecraft:yellow_terracotta, minecraft:lime_terracotta, (8 + 1)),
    lime_terracotta(minecraft:lime_terracotta, minecraft:magenta_terracotta, (4 + 8)),
    
    pink_terracotta(minecraft:pink_terracotta, minecraft:gray_terracotta, (2 + 4 + 1)),
    gray_terracotta(minecraft:gray_terracotta, minecraft:light_gray_terracotta, (2 + 1 + 8)),
    light_gray_terracotta(minecraft:light_gray_terracotta, minecraft:cyan_terracotta, (8 + 1 + 4)),
    cyan_terracotta(minecraft:cyan_terracotta, minecraft:pink_terracotta, (4 + 2 + 8)),
    
    purple_terracotta(minecraft:purple_terracotta, minecraft:purple_terracotta, (4 + 2 + 8 + 1)),
    
    blue_terracotta(minecraft:blue_terracotta, minecraft:brown_terracotta, (4)),
    brown_terracotta(minecraft:brown_terracotta, minecraft:green_terracotta, (2)),
    green_terracotta(minecraft:green_terracotta, minecraft:red_terracotta, (1)),
    red_terracotta(minecraft:red_terracotta, minecraft:blue_terracotta, (8)),
    
    purple_wool(minecraft:purple_wool, minecraft:purple_wool, (4 + 1)),
    orange_wool(minecraft:orange_wool, minecraft:orange_wool,(2 + 8)),
    
    magenta_wool(minecraft:magenta_wool, minecraft:magenta_wool, (4 + 2)),
    light_blue_wool(minecraft:light_blue_wool, minecraft:light_blue_wool, (2 + 1)),
    yellow_wool(minecraft:yellow_wool, minecraft:yellow_wool, (8 + 1)),
    black_wool(minecraft:black_wool, minecraft:black_wool, (4 + 8)),
    
    pink_wool(minecraft:pink_wool, minecraft:pink_wool, (2 + 4 + 1)),
    gray_wool(minecraft:gray_wool, minecraft:gray_wool, (2 + 1 + 8)),
    light_gray_wool(minecraft:light_gray_wool, minecraft:light_gray_wool, (8 + 1 + 4)),
    cyan_wool(minecraft:cyan_wool, minecraft:cyan_wool, (4 + 2 + 8)),
    
    blue_wool(minecraft:blue_wool, minecraft:blue_wool, (4)),
    brown_wool(minecraft:brown_wool, minecraft:brown_wool, (2)),
    green_wool(minecraft:green_wool, minecraft:green_wool, (1)),
    red_wool(minecraft:red_wool, minecraft:red_wool, (8))
}

def randomizeCell(){
    if (!block(minecraft:black_concrete)){
        int rng = random.range(0,4)
        for(int i = 0;i < rng;i++){
            rotateFast()
        }
    }
}
def lazy traverseGridY(int size, void=>void fct){
    if (size > 0){
        fct()
        at(~ ~1 ~){
            traverseGridY(size - 1, fct)
        }
    }
}
def lazy traverseGridZ(int size, void=>void fct){
    if (size > 0){
        at(~ ~ ~1){
            traverseGridZ(size - 1, fct)
        }
        traverseGridY(gridSize, fct)
    }
}
def lazy foreachCell(void=>void fct){
    foreach(x in 0..(gridSize-1)){
        foreach(y in 0..(gridSize-1)){
            at({~,~y,~x})fct()
        }
    }
    //traverseGridZ(gridSize, fct)
}

def randomizeGrid(){
    foreachCell(randomizeCell)
    updateAll()
}

scoreboard Selector selector

def addSelector(){
    selector = new Selector(Color.cyan)
}
def removeSelector(){
    selector = null
}
def rotateFast(){
    bool done = false
    foreach(celltype in Blocks){
        if (block(~ ~ ~, celltype.source) && !done){
            done = true
            block.set(~ ~ ~, celltype.next)
        }
    }
}
def rotate(bool shouldUpdate = false){
    bool done = false
    foreach(celltype in Blocks){
        if (block(~ ~ ~, celltype.source) && !done){
            done = true
            block.set(~ ~ ~, celltype.next)
        }
    }
    if (shouldUpdate){
        at(~ ~1 ~){update()}
        at(~ ~-1 ~){update()}
        at(~ ~ ~){update()}
        at(~ ~ ~-1){update()}
        at(~ ~ ~1){update()}

        at(43 0 51)checkGrid()
    }
}
int getConstraint(){
    var ret = 0
    foreach(celltype in Blocks){
        if (block(~ ~ ~, celltype.source)){
            ret = celltype.constraints
        }
    }
    return ret
}
int invert(int c){
    switch(c){
        1 -> return 4
        2 -> return 8
        4 -> return 0
        8 -> return 2
    }
    return 0
}
bool checkConstr(int test, int needed){
    int l = 0
    int r = 0
    int u = 0
    int d = 0
    if (test >= 8){
        test -= 8
        d = 1
    }
    if (test >= 4){
        test -= 4
        l = 1
    }
    if (test >= 2){
        test -= 2
        u = 1
    }
    if (test >= 1){
        r = 1
    }
    var ret = false
    if (needed == 1 && r) ret = true
    if (needed == 2 && u) ret = true
    if (needed == 4 && l) ret = true
    if (needed == 8 && d) ret = true
    return ret
}

def update(){
    bool valid = true
    int left,right,up,down
    at(~ ~ ~-1){left = getConstraint()}
    at(~ ~ ~1){right = getConstraint()}
    at(~ ~1 ~){up = getConstraint()}
    at(~ ~-1 ~){down = getConstraint()}
    int self = getConstraint()
    
    if (self >= 8){
        self -= 8
        if (!checkConstr(down, 2)){
            valid = false
        }
    }
    if (self >= 4){
        self -= 4
        if (!checkConstr(left, 1)){
            valid = false
        }
    }
    if (self >= 2){
        self -= 2
        if (!checkConstr(up, 8)){
            valid = false
        }
    }
    if (self >= 1){
        if (!checkConstr(right, 4)){
            valid = false
        }
    }

    if (valid && block(~1 ~ ~, minecraft:red_concrete)){
        block.set(~1 ~ ~, minecraft:lime_concrete)
    }
    if (!valid && block(~1 ~ ~, minecraft:lime_concrete)){
        block.set(~1 ~ ~, minecraft:red_concrete)
    }
    if (block(minecraft:black_terracotta)){
        block.set(~1 ~ ~, minecraft:lime_concrete)
    }
}
bool checkGrid(){
    var valid = true
    foreachCell(){
        if (block(~1 ~ ~, minecraft:red_concrete)){
            valid = false
        }
    }
    if (valid){
        level.next()
    }
    return valid
}
def updateAll(){
    foreachCell(update)
}

blocktag ignored{
    minecraft:air,
    minecraft:barrier,
    minecraft:light
}
PositionLock lock{
    set(33 6 58)
}
Click click{
    def onClick(){
        if (!level.lock){
            raycast.shoot(20, 0.1, !block(#ignored)){
                rotate(true)
            }
        }
    }
}
PProcess main{
    def main(){
        /kill @e[type=item]
        raycast.shoot(20, 0.1, !block(#ignored)){
            selector.move()
        }
    }
}
def start(){
    if (@s[tag=!inited]){
        getColor()
        tag.add("inited")
    }
    il.addSelector()
    click.start()
    lock.start()
    main.start()
}
def stop(){
    il.removeSelector()
    lock.stop()
    click.stop()
    main.stop()
}