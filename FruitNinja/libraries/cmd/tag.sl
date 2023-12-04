package cmd.tag

def lazy add(string $tag){
    /tag @s add $tag
}

def lazy add(entity selector, string $tag){
    with(selector){
        /tag @s add $tag
    }
}


def lazy remove(string $tag){
    /tag @s remove $tag
}
def lazy remove(entity selector, string $tag){
    with(selector){
        /tag @s remove $tag
    }
}


def lazy unique(string $tag){
    /tag @e[tag=$tag] remove $tag
    /tag @s add $tag
}
def lazy unique(entity selector, string $tag){
    /tag @e[tag=$tag] remove $tag
    with(selector){
        /tag @s add $tag
    }
}

def lazy bool has(string tag){
    return @s[tag=tag]
}

def lazy bool has(entity selector, string $tag){
    lazy val sel = Compiler.mergeSelector(selector, @e[tag=$tag])
    return sel
}
