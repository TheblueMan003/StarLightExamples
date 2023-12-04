package mc.Entity

import cmd.tag as tag
import cmd.java.data as data

class Entity{
    """
    Execute a function with the entity
    """
    def lazy run(void=>void fct){
        fct()
    }
    """
    Execute a function with the entity
    """
    def lazy run(bool _at, void=>void fct){
        with(@s,_at){
            fct()
        }
    }

    """
    Teleport entity to position
    """
    def lazy teleport(mcposition position){
        at(position){
            /tp @s ~ ~ ~
        }
    }

    """
    Make the entity look at position
    """
    def lazy lookAt(mcposition position){
        at(@s){
            facing(position){
                /tp @s ~ ~ ~ ~ ~
            }
        }
    }

    """
    Make the entity look the nearest player
    """
    def lazy lookAtPlayer(){
        lookAt(@p)
    }

    
    """
    add tag to entity
    """
    def lazy tag(string tag){
        tag.add(tag)
    }

    """
    remove tag from entity
    """
    def lazy untag(string tag){
        tag.remove(tag)
    }
    
    """
    kill entity
    """
    def lazy kill(){
        /kill @s
    }

    if (Compiler.isJava()){
        def lazy setdata(json data){
            data.set(data)
        }
        def lazy copyDataFrom(entity e2, string path){
            data.copyFrom(e2,path)
        }
        def lazy copyDataFromTo(string path1, entity e2, string path2){
            data.copyFromToPath(path1, e2, path2)
        }
        def lazy setName(string name){
            data.set({CustomName: name,CustomNameVisible:1b})
        }
        def lazy noGravity(int value){
            data.set({NoGravity:value b})
        }
        def lazy noGravity(){
            data.set({NoGravity:1b})
        }
        def lazy invulnerable(int value){
            data.set({Invulnerable:value b})
        }
        def lazy invulnerable(){
            data.set({Invulnerable:1b})
        }
        def lazy invincible(int value){
            data.set({Invulnerable:value b})
        }
        def lazy Invincible(){
            data.set({Invulnerable:1b})
        }
        def lazy Silent(int value){
            data.set({Silent: value b})
        }
        def lazy Silent(){
            data.set({Silent:1})
        }
        def lazy Glowing(int value){
            data.set({Glowing:value b})
        }
        def lazy Glowing(){
            data.set({Glowing:1})
        }
        def lazy setModel(mcobject $block, int $id){
            /data merge entity @s {ArmorItems: [{}, {}, {}, {id: "$block", Count: 1b, tag: {CustomModelData: $id}}],DisabledSlots:4144959}
        }
    }
}
