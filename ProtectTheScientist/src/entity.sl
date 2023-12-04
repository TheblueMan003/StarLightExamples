package entity

from mc.sprite import _
import cmd.tp as tp
import utils.direction as direction
import cmd.Team
import cmd.effect as effect
import cmd.tag as tag
import mc.java.nbt as nbt

Team entTeam = new Team("entity")
entTeam.setColor("red")

lazy Animation iced = addAnimation([addTexture("spr_iced_0"), addTexture("spr_iced_1"), addTexture("spr_iced_2"), addTexture("spr_iced_3"),addTexture("spr_iced_4"), addTexture("spr_iced_5"), addTexture("spr_iced_6"), addTexture("spr_iced_7")], 2)

enum DamageType{
    Physical,
    Fire,
    Ice,
    Poison
}

class FreezeEffect extends Sprite{
    def override __init__(){
        setAnimation(iced)
        setSize(2)
    }
}

class Entity extends Sprite{
    int X,Z, Health, MaxHealth
    ui.healthbar.HealthBar healthBar
    bool hasHealthBar
    int healthBarTick
    int motionDir
    int motionTick
    bool isMoving
    int freezeTick
    FreezeEffect freezeEffect
    int speed
    int invincibleTick
    int poisonTime
    int poisonTick
    
    def override __init__(){
        align("xz")at(~0.5~~0.5){
            entTeam += @s
            X = tp.getX()
            Z = tp.getZ()
            motionTick = 0
            motionDir = 0
            speed = 1
            isMoving = false
            Health = 1
            freezeTick = 0
            freezeEffect = null
            invincibleTick = 0
            at(@s){
                if (!block(~~-0.1~,minecraft:air)){
                    ./tp @s ~ ~0.51 ~
                }
                if (block(minecraft:black_concrete)){
                    ./tp @s ~ ~0.51 ~
                }
            }
            onInit()
        }
    }
    def moveDown(){
        motionDir = 3
        motionTick = 0
        Z += 1
        isMoving = true
    }
    def moveUp(){
        motionDir = 1
        motionTick = 0
        Z -= 1
        isMoving = true
    }
    def moveLeft(){
        motionDir = 2
        motionTick = 0
        X -= 1
        isMoving = true
    }
    def moveRight(){
        motionDir = 0
        motionTick = 0
        X += 1
        isMoving = true
    }
    int getDirection(){
        return direction.getFloor(-X, -Z)
    }
    def setDirectionalAnimation(Animation right, Animation up, Animation left, Animation down){
        if(motionDir == 0){
            setAnimation(right)
        }else if(motionDir == 1){
            setAnimation(up)
        }else if(motionDir == 2){
            setAnimation(left)
        }else if(motionDir == 3){
            setAnimation(down)
        }
    }
    def lazy moveTowardCenter(Animation right, Animation up, Animation left, Animation down){
        moveToward(0, 0, right, up, left, down)
    }
    def moveToward(int x, int z, Animation right, Animation up, Animation left, Animation down){
        if (!isMoving){
            if (X == x && Z == z){
                
            }
            else{
                int dir = direction.getFloor(x-X, z-Z)
                if(dir == 0){
                    moveRight()
                }else if(dir == 1){
                    moveUp()
                }else if(dir == 2){
                    moveLeft()
                }else if(dir == 3){
                    moveDown()
                }
                setDirectionalAnimation(right, up, left, down)
            }
        }
    }
    def freeze(int time){
        if(freezeTick == 0){
            freezeEffect = new FreezeEffect()
            freezeTick = time
            tag.add("freezed")
        }
    }
    def setPosition(){
        X = tp.getX()
        Z = tp.getZ()
    }
    def @entity.tick(){
        if (block(~ 0 ~, minecraft:lime_concrete)){
            switch(Z){
                foreach(i in -10..10){
                    i -> at({~, 1.51 + (i+10)/1000.0, ~})./tp @s ~ ~ ~
                }
            }
        }
        if (hasHealthBar){
            healthBarTick--
            int h = Health
            switch(MaxHealth){
                foreach(i in 0..20){
                    i*4 -> at({~-i/2.0 + 0.5, ~, ~}){
                        healthBar.update(h)
                    }
                }
            }
            if (healthBarTick < 0){
                hideHealthBar()
            }
        }
        if (poisonTick > 0){
            poisonTick--
            if (poisonTick <= 0){
                poisonTime--
                Health -= 1
                if (poisonTime > 0)poisonTick = 20
            }
        }
        if (invincibleTick > 0){
            invincibleTick--
        }
        if(freezeTick > 0){
            freezeTick--
            if(freezeTick == 0){
                tag.remove("freezed")
                freezeEffect = null
            }
        }
        else{
            onTick()
            for(int i = 0;i < speed && isMoving;i++){
                at(@s){
                    switch(motionDir){
                        0 -> ./tp @s ~0.025 ~ ~
                        1 -> ./tp @s ~ ~ ~-0.025
                        2 -> ./tp @s ~-0.025 ~ ~
                        3 -> ./tp @s ~ ~ ~0.025
                    }
                }
                motionTick++
                if(motionTick == 40){
                    motionTick = 0
                    isMoving = false
                }
            }

            if (Health <= 0){
                die()
            }
        }
    }
    def die(){
        onDeath()
        hideHealthBar()
        freezeEffect = null
        kill()
    }
    def lazy setHealth(int value){
        MaxHealth = value
        Health = value
    }
    def heal(int value){
        Health += value
        if (Health > MaxHealth){
            Health = MaxHealth
        }
        onHeal()
    }
    def virtual onDeath(){
        
    }
    def virtual bool canTakeDamage(int type){
        return true
    }
    def virtual onDamage(){

    }
    def virtual onInit(){

    }
    def virtual onTick(){

    }
    def virtual onHeal(){

    }
    def showHealthBar(){
        healthBarTick = 4 + game.speed
        if (!hasHealthBar){
            int h, m = Health, MaxHealth
            switch(MaxHealth){
                foreach(i in 0..20){
                    i*4 -> at({~-i/2.0+ 0.5, ~, ~}){
                        healthBar = new ui.healthbar.HealthBar(h, m)
                    }
                }
            }
            hasHealthBar = true
        }
    }
    def hideHealthBar(){
        if (hasHealthBar){
            healthBar = null
            hasHealthBar = false
        }
    }
    bool damage(int dmg, int type){
        if (canTakeDamage(type) && invincibleTick <= 0){
            invincibleTick = 5
            onDamage()
            Health -= dmg
            if (type == DamageType.Ice){
                freeze(20)
            }
            if (type == DamageType.Poison){
                poisonTick = 20
                poisonTime = 5
            }
            effect.glowing(1,1)
            return true
        }
        else{
            return false
        }
    }
    (int,int) getPos(){
        return (X,Z)
    }
}