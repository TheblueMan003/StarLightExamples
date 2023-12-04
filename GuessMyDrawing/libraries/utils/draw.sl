package utils.draw

import mc.pointer as p
import cmd.block as b

"""
Place a blocks from start to end in a line
"""
public lazy int line(mcposition start, mcposition end, mcobject block){
    line(start, end){
        b.place(block)
    }
}

"""
Run the action from start to end in a line
"""
public lazy int line(mcposition start, mcposition end, void=>void action){
    void rec(){
        bool isEnd = false
        at(end){
            if (@s[distance=..0.25]){
                isEnd = true
            }
        }
        action()
        if (!isEnd){
            facing(end){
                /tp @s ^ ^ ^0.25
            }
            at(@s){
                rec()
            }
        }
    }
    at(start){
        p.run(){
            facing(end){
                rec()
            }
        }
    }
}
