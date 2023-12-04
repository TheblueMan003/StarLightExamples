package cmd.spawnpoint


"""
Set the spawnpoint of the player to the current position.
"""
def lazy set(){
    if (Compiler.isJava()){
        /spawnpoint @s ~ ~ ~ ~
    }
    if (Compiler.isBedrock()){
        /spawnpoint @s
    }
}

"""
Set the spawnpoint of the player to the given position.
"""
def lazy set(mcposition $pos){
    if (Compiler.isJava()){
        /spawnpoint @s $pos ~
    }
    if (Compiler.isBedrock()){
        /spawnpoint @s $pos
    }
}

"""
Set the spawnpoint of the player to the given position and angle. (JAVA ONLY)
"""
def lazy set(mcposition $pos, float $angle){
    if (Compiler.isJava()){
        /spawnpoint @s $pos $angle
    }
    if (Compiler.isBedrock()){
        /spawnpoint @s $pos
    }
}


"""
Set the spawnpoint of the player to the current position.
"""
def lazy set(entity player){
    with(@a in player)set()
}

"""
Set the spawnpoint of the player to the given position.
"""
def lazy set(entity player, mcposition pos){
    with(@a in player)set(pos)
}


"""
Set the spawnpoint of the player to the given position and angle. (JAVA ONLY)
"""
def lazy set(entity player, mcposition pos, float angle){
    with(@a in player)set(pos, angle)
}


"""
Set the world spawnpoint to the current position.
"""
def lazy setWorld(){
    /setworldspawn
}

"""
Set the world spawnpoint to the given position.
"""
def lazy setWorld(mcposition $pos){
    /setworldspawn $pos
}

"""
Set the world spawnpoint to the given position and angle. (JAVA ONLY)
"""
def lazy setWorld(mcposition $pos, float $angle){
    if (Compiler.isJava()){
        /setworldspawn $pos $angle
    }
    if (Compiler.isBedrock()){
        /setworldspawn $pos
    }
}
