package game

import utils.Process

int money
int speed := 1

def reset(){
    @reset()
    money = 20
}
def start(){
    reset()
    with(@a,true)ui.selector.main.start()
    manager.start()
}
def setSpeed1X(){
    speed = 1
}
def setSpeed2X(){
    speed = 2
}
def setSpeed4X(){
    speed = 4
}
def setSpeed8X(){
    speed = 8
}
def setSpeed16X(){
    speed = 16
}
Process manager{
    def main(){
        for(int i = 0;i < speed;i++){
           @entity.tick() 
        }
    }
}