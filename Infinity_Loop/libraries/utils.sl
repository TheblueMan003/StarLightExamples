package utils

"""
Execute a function for each block in a cube of size sizeX*sizeY*sizeZ and provide the coordinates of the block (relative to start) to the function
"""
def lazy forCube(int sizeX, int sizeY, int sizeZ, (int,int,int)=>void fct){
    def traverseZ(int z){
        def traverseY(int y){
            def traverseX(int x){
                fct(sizeX - x, sizeY - y, sizeZ - z)
                if (x > 0)at(~1 ~ ~)traverseX(x-1)
            }
            traverseX(sizeX)
            if (y > 0)at(~ ~1 ~)traverseY(y-1)
        }
        traverseY(sizeY)
        if (z > 0)at(~ ~ ~1)traverseZ(z-1)
    }
    traverseZ(sizeZ)
}

"""
Execute a function for each block in a cube of size sizeX*sizeY*sizeZ
"""
def lazy forArea(int sizeX, int sizeY, int sizeZ, void=>void fct){
    def traverseZ(int z){
        def traverseY(int y){
            def traverseX(int x){
                fct()
                if (x > 0)at(~1 ~ ~)traverseX(x-1)
            }
            traverseX(sizeX)
            if (y > 0)at(~ ~1 ~)traverseY(y-1)
        }
        traverseY(sizeY)
        if (z > 0)at(~ ~ ~1)traverseZ(z-1)
    }
    traverseZ(sizeZ)
}

"""
Lock Player in place
"""
def lazy lockPosition(mcposition pos=~~~){
    at(pos)as(@s[distance=0.1..,gamemode=!creative])./tp @s ~ ~ ~
}

"""
Call fct if the value of value has changed since the last call
"""
def lazy observe(int value, void=>void fct){
    int tmp
    if (value != tmp){
        tmp = value
        fct()
    }
}

"""
Call fct once until reset is called
"""
def lazy runOnce(void=>void fct){
    bool ran
    if (!ran){
        ran = true
        fct()
    }
    def @reset(){
        ran = false
    }
}

"""
Call fct once per player and then call repeated until reset is called
"""
def lazy runOnce(void=>void fct, void=>void repeated){
    bool ran
    if (!ran){
        ran = true
        fct()
    }
    else{
        repeated()
    }
    def @reset(){
        ran = false
    }
}

"""
Call fct once per player until reset is called
"""
def lazy runOncePerPlayer(void=>void fct){
    int version := 1
    scoreboard int ran

    if (version != ran){
        ran = version
        fct()
    }

    def @reset(){
        version ++
    }
}

"""
Call fct once per player and then call repeated until reset is called
"""
def lazy runOncePerPlayer(void=>void fct, void=>void repeated){
    int version := 1
    scoreboard int ran

    if (version != ran){
        ran = version
        fct()
    }
    else{
        repeated()
    }

    def @reset(){
        version ++
    }
}
