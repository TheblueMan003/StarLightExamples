package mc.wasd

import mc.pointer as pt
import utils.PProcess

[nbt="Motion[0]"] scoreboard json MotionX
[nbt="Motion[2]"] scoreboard json MotionY
[nbt="Rotation[0]"] scoreboard json RotationY

def macro rotate(float x, float y){
    /execute facing $(x) 0 $(y) run tp @s ~ ~ ~ ~ 0
}

"""
Returns the angle of the vector (x, y) in degrees.
"""
float atan2(float x, float y){
    float ret
    x *= 100000
    y *= 100000
    
    pt.run(){
        at(0 0 0)rotate(x, y)
        ret = RotationY
    }
    return ret
}

"""
Get the direction of the player's movement.
(-1, 0) means left (a)
(1, 0) means right (d)
(0, 1) means forward (w)
(0, -1) means backward (s)
"""
(int,int) wasd(){
    float mx = MotionX
    float my = MotionY
    float ry = RotationY

    int x = 0
    int y = 0


    if (mx == 0 && my == 0){
        return (0,0)
    }
    else{
        float dir2 = atan2(mx,my)
        float dir = dir2 - ry
        if (dir in -360.0..-215.0){
            dir += 360
        }
        if (dir in 215.0..360.0){
            dir -= 360
        }
        int w,a,s,d = 0
        if (dir in -67.0..67.0){
            w = 1
        }
        if (dir in 23.0..157.0){
            a = 1
        }
        if (dir in -157.0..-23.0){
            d = 1
        }
        if (dir in 113.0..248.0){
            s = 1
        }
        if (dir in -248.0..-113.0){
            s = 1
        }
        if (dir in -315.0..-225.0){
            a = 1
        }
        if (dir in 225.0..315.0){
            d = 1
        }
        x = d - a
        y = w - s
        return (x,y)
    }
}
enum KeyState{
    RELEASED,
    PRESSED
}

"""
Provides a simple way to handle WASD input.

onPressA() is called when the player presses A.
onA() is called when the player is pressing A.
onReleaseA() is called when the player releases A.

onPressW() is called when the player presses W.
onW() is called when the player is pressing W.
onReleaseW() is called when the player releases W.

onPressS() is called when the player presses S.
onS() is called when the player is pressing S.
onReleaseS() is called when the player releases S.

onPressD() is called when the player presses D.
onD() is called when the player is pressing D.
onReleaseD() is called when the player releases D.
"""
template WASD extends PProcess{
    scoreboard KeyState state_a
    scoreboard KeyState state_w
    scoreboard KeyState state_s
    scoreboard KeyState state_d

    def onJoin(){
        state_a := KeyState.RELEASED
        state_w := KeyState.RELEASED
        state_s := KeyState.RELEASED
        state_d := KeyState.RELEASED
    }

    def main(){
        (int,int) dir = wasd()
        int x = dir[0]
        int y = dir[1]

        bool a = x > 0
        bool d = x < 0
        bool w = y > 0
        bool s = y < 0

        if (a){
            if (state_a == KeyState.RELEASED){
                state_a = KeyState.PRESSED
                onPressA()
                onA()
            }
            else{
                onA()
            }
        }
        else{
            if (state_a == KeyState.PRESSED){
                state_a = KeyState.RELEASED
                onReleaseA()
            }
        }

        if (w){
            if (state_w == KeyState.RELEASED){
                state_w = KeyState.PRESSED
                onPressW()
                onW()
            }
            else{
                onW()
            }
        }
        else{
            if (state_w == KeyState.PRESSED){
                state_w = KeyState.RELEASED
                onReleaseW()
            }
        }

        if (s){
            if (state_s == KeyState.RELEASED){
                state_s = KeyState.PRESSED
                onPressS()
                onS()
            }
            else{
                onS()
            }
        }
        else{
            if (state_s == KeyState.PRESSED){
                state_s = KeyState.RELEASED
                onReleaseS()
            }
        }

        if (d){
            if (state_d == KeyState.RELEASED){
                state_d = KeyState.PRESSED
                onPressD()
                onD()
            }
            else{
                onD()
            }
        }
        else{
            if (state_d == KeyState.PRESSED){
                state_d = KeyState.RELEASED
                onReleaseD()
            }
        }
    }

    def virtual onPressA(){}
    def virtual onA(){}
    def virtual onReleaseA(){}

    def virtual onPressW(){}
    def virtual onW(){}
    def virtual onReleaseW(){}

    def virtual onPressS(){}
    def virtual onS(){}
    def virtual onReleaseS(){}

    def virtual onPressD(){}
    def virtual onD(){}
    def virtual onReleaseD(){}
}
