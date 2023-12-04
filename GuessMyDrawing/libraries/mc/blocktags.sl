package mc.blocktags

import cmd.block as b

"""
Get the index of the current block in the tag
"""
public lazy int index(mcobject tag) {
    int ret = -1
    foreach(block in tag){
        if (block(block)){
            ret = block.index
        }
    }
    return ret
}


"""
Set the current block to the index in the tag
"""
public lazy void set(mcobject tag, int index) {
    foreach(block in tag){
        if (block.index == index){
            b.set(block)
        }
    }
}

"""
Map the blocks in tag1 to the blocks in tag2
"""
public lazy void convert(mcobject tag1, mcobject tag2) {
    foreach(block1 in tag1){
        if (block(block1)){
            b.set(tag2[block1.index])
        }
    }
}
