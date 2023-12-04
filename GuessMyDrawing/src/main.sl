package main

import cmd.effect as effect

def @playertick main(){
    effect.saturation()
}
def @tick(){
    with(@e[type=item])./kill
}
