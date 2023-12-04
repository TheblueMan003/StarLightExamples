package random

if (Compiler.isBedrock){
    """
    Return a random number between `x` (included) and `y` (excluded)
    """
    int range(int x, int y){
        int ret
        Compiler.random(ret, -2147483648, 2147483647)
        ret %= (y - x)
        ret += x
        return ret
    }
    """
    Return a random number between `x` (included) and `y` (excluded)
    """
    lazy float range(float x, float y){
        float ret
        Compiler.random(ret, -2147483648, 2147483647)
        ret %= (y - x)
        ret += x
        return ret
    }
}
if (Compiler.isJava){
    import mc.java.nbt as nbt
    
    """
    Return a random number between `x` (included) and `y` (excluded)
    """
    lazy int range(int x, int y){
        int ret
        Compiler.cmdstore(ret){
            /random value 0..2147483646
        }
        ret %= (y - x)
        ret += x
        return ret
    }
    """
    Return a random number between `x` (included) and `y` (excluded)
    """
    lazy float range(float x, float y){
        float ret
        Compiler.cmdstore(ret){
            /random value 0..2147483646
        }
        ret %= (y - x)
        ret += x
        return ret
    }
}

"""
Return a random number between 0 and `x` (excluded)
"""
lazy int range(int x){
    return range(0, x)
}

"""
Return a random number between 0 and `x` (excluded)
"""
lazy float range(float x){
    return range(0.0, x)
}

"""
Return a random number between `x` (included) and `y` (excluded)
"""
lazy int next(){
    import standard.int as int
    return range(int.minValue, int.maxValue)
}

"""
Return a random number between `x` (included) and `y` (excluded)
"""
lazy float nextFloat(){
    import standard.float as float
    return range(float.minValue, float.maxValue)
}

"""
Return a random number between `x` (included) and `y` (excluded)
"""
lazy bool chance(float percent){
    float a = range(0.0, 100.0)
    float b = percent*100
    if (a < b){
        return true
    }
    else{
        return false
    }
}
