package mc.java.item

"""
Summon an item entity at the current location with the specified item, count, and tag.
"""
def lazy summon(mcobject $item, int $count, json tag){
    lazy val nbt = Compiler.toNBT(tag)
    Compiler.insert($nbt, nbt){
        /summon item ~ ~ ~ {Item:{id:"$item",Count:$countb,tag:$nbt}}
    }
}

"""
Summon an item entity at the current location with the specified item and count.
"""
def lazy summon(mcobject $item, int $count){
    /summon item ~ ~ ~ {Item:{id:"$item",Count:$countb}}
}

"""
Summon an item entity at the current location with the specified item.
"""
def lazy summon(mcobject $item){
    /summon item ~ ~ ~ {Item:{id:"$item"}}
}

"""
Summon an item entity at the current location with the specified item, count, tag, and pickup delay.
"""
def lazy summonDelay(mcobject $item, int $count, json tag, int $delay){
    lazy val nbt = Compiler.toNBT(tag)
    Compiler.insert($nbt, nbt){
        /summon item ~ ~ ~ {Item:{id:"$item",Count:$countb,tag:$nbt}, PickupDelay:$delays}
    }
}

"""
Summon an item entity at the current location with the specified item, count, and pickup delay.
"""
def lazy summonDelay(mcobject $item, int $count, int $delay){
    /summon item ~ ~ ~ {Item:{id:"$item",Count:$countb}, PickupDelay:$delays}
}

"""
Summon an item entity at the current location with the specified item and pickup delay.
"""
def lazy summonDelay(mcobject $item, int $delay){
    /summon item ~ ~ ~ {Item:{id:"$item"}, PickupDelay:$delays}
}

"""
Kill all item entities with the specified item, count, and tag.
"""
def lazy kill(mcobject $item, int $count, json tag){
    lazy val nbt = Compiler.toNBT(tag)
    Compiler.insert($nbt, nbt){
        /kill @e[type=item,nbt={Item:{id:"$item",Count:$countb,tag:$nbt}}]
    }
}
    
"""
Kill all item entities with the specified item and count.
"""
def lazy kill(mcobject $item, int $count){
    /kill @e[type=item,nbt={Item:{id:"$item",Count:$countb}}]
}

"""
Kill all item entities with the specified item.
"""
def lazy kill(mcobject $item){
    /kill @e[type=item,nbt={Item:{id:"$item"}}]
}
