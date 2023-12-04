package button

import cmd.block as block

def unselect(){
    block.fill(~ ~ ~, ~ ~ ~, minecraft:black_concrete)
}