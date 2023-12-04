package mc.PositionLock

import utils.CProcess
import cmd.inputpermission as ip

template PositionLock{
    lazy mcposition position
    entity selected
    def lazy set(mcposition pos){
        position = pos
    }
    CProcess inner{
        def [compile.order=999] main(){
            with(@a in selected){
                at(position)as(@s[distance=0.1..,gamemode=!creative]){
                    /tp @s ~ ~ ~
                    if (Compiler.isBedrock()){
                        ip.movement(false)
                    }
                }
            }
        }
    }
    def start(){
        inner.start()
        selected += @s
        if (Compiler.isBedrock()){
            ip.movement(false)
        }
    }
    def stop(){
        inner.stop()
        selected -= @s
        if (Compiler.isBedrock()){
            ip.movement(true)
        }
    }
}
