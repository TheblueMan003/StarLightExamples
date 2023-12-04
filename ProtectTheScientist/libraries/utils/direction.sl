package utils.direction

import math

typedef int Direction

Direction FloorRight = 0
Direction FloorUp = 1
Direction FloorLeft = 2
Direction FloorDown = 3


def Direction getFloor(int dx, int dy){
    if (math.abs(dx) > math.abs(dy)){
        if (dx > 0){
            return 0
        } else {
            return 2
        }
    } else {
        if (dy > 0){
            return 3
        } else {
            return 1
        }
    }
}