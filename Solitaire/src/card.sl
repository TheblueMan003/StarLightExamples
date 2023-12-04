package solitaire

from mc.sprite import _
import math
import random
import mc.java.nbt as nbt
import cmd.sound as sound

int CLOVER = 0
int HEART = 1
int SPADE = 3
int DIAMOND = 4

lazy Texture back = addTextureVertical("card_back")
lazy Texture empty = addTextureVertical("card_empty")
lazy Texture reset = addTextureVertical("card_reset")

int[52] cards_list

bool resetting

def swap(){
    int a = random.range(0, 52)
    int b = random.range(0, 52)
    int t = cards_list[a]
    cards_list[a] = cards_list[b]
    cards_list[b] = t
}
def shuffle(){
    for(int i = 0; i < 52; i++){
        cards_list[i] = i
    }
    for(int i = 0; i < 200; i++){
        swap()
    }
}

class CardBase extends Sprite{
    int type
    int value

    def showTexture(){
        switch(type){
            foreach(t in ("heart", "spade", "diamond","clover")){
                t.index -> {
                    switch(value){
                        foreach(i in 1..13){
                            i.index -> {
                                setTexture(addTextureVertical("card_"+t+"_"+i))
                            }
                        }
                    }
                }
            }
        }
    }

    def showTextureSelected(){
        switch(type){
            foreach(t in ("heart", "spade", "diamond","clover")){
                t.index -> {
                    switch(value){
                        foreach(i in 1..13){
                            i.index -> {
                                setTexture(addTextureVertical("card_selected_"+t+"_"+i))
                            }
                        }
                    }
                }
            }
        }
    }
}

class Card extends CardBase{
    bool hasChild
    Card child
    bool hasParent
    Card parent
    Card oldParent

    int isInDeck
    bool inFoundation
    bool wasRevealed

    float x,y,z
    float sx, sy, sz
    bool animationStarted
    int animationBounce

    def __init__(int type, int value){
        this.type = type
        this.value = value

        setTexture(back)
        setScale(2, 3, 1)
        __refCount = 1000000
    }
    def __init__(int type, int value, int decked){
        __refCount = 1000000
        this.type = type
        this.value = value

        setTexture(back)
        setScale(2, 3, 1)

        isInDeck = decked

        if (isInDeck == -1){
            setTexture(empty)
            inFoundation = true
        }
        if (isInDeck == -2){
            setTexture(empty)
        }
        if (isInDeck == -3){
            setTexture(empty)
        }
        if (isInDeck == -4){
            setTexture(reset)
        }
    }
    def printAllVariable(){
        print("===============================")
        print("type: ",type)
        print("value: ",value)
        print("hasChild: ",hasChild)
        print("hasParent: ",hasParent)
        print("isInDeck: ",isInDeck)
        print("inFoundation: ",inFoundation)
        print("wasRevealed: ",wasRevealed)

        print()
        if (hasChild){
            child.run(){
                print("child:")
                print()
                moveStack()
            }
        }
        if (hasParent){
            parent.run(){
                print("parent:")
                print()
                moveStack()
            }
        }
        moveStack()
    }
    def hide(){
        setTexture(back)
        wasRevealed = false
    }
    def setChild(Card child){
        this.child = child
        hasChild = true
        if (inFoundation){
            child.run(){
                inFoundation = true
            }
        }
        else{
            child.run(){
                inFoundation = false
            }
        }
        moveStack()
    }
    def removeChild(){
        hasChild = false
    }
    def setParent(Card parent){
        this.parent = parent
        hasParent = true
        parent.run(){
            moveStack()
        }
        with(@a,true,!resetting)sound.play(minecraft:item.book.page_turn)
    }
    def removeParent(){
        hasParent = false
    }
    def onClick(){
        if (isInDeck != 1 && isInDeck >= 0){
            x = nbt.x
            y = nbt.y
            z = nbt.z
        }
    }
    def onHold(){
        if (isInDeck != 1 && isInDeck >= 0){
            teleport(~ ~ 19)
            moveStack()
            showTextureSelected()
        }
    }
    def moveStack(){
        if (hasChild){
            at(@s){
                bool noShift = false
                if (isInDeck == -2){
                    noShift = true
                }
                child.run(){
                    if (inFoundation){
                        /tp @s ~ ~ ~0.01
                    }
                    else if (noShift){
                        /tp @s ~ ~ ~0.01
                    }
                    else{
                        /tp @s ~ ~-0.5 ~0.01
                    }
                    moveStack()
                }
            }
        }
    }
    bool lookupParent(){
        bool found = false
        at(@s){
            int t = type
            int v = value
            Card s
            Card ss = this
            float mz = 0
            bool otherHasChild = hasChild
            with(@e[sort=nearest,distance=..3] in Card, true){
                int delta = (t - type) % 2
                int v2 = value
                float z = nbt.z
                if (z > mz){
                    if (isInDeck == -1 && v == 0 && !hasChild && !otherHasChild){
                        s = this
                        found = true
                    }
                    else if (isInDeck == -2 && !hasChild){
                        s = this
                        found = true
                    }
                    else if (inFoundation && v - 1 == v2 && t == type && !otherHasChild){
                        s = this
                        found = true
                    }
                    else if (!inFoundation && delta == 1 && v + 1 == v2 && wasRevealed && isInDeck == 0){
                        s = this
                        found = true
                    }
                }
            }
            if (found){
                parent.run(){
                    removeChild()
                }
                isInDeck = 0
                s.run(){
                    setChild(ss)
                }
                setParent(s)
            }
        }
        return found
    }
    bool lookupParentRelease(){
        bool found = false
        at(@s){
            int t = type
            int v = value
            Card s
            Card ss = this
            float mz = 0
            bool otherHasChild = hasChild
            with(@e[sort=nearest] in Card, true){
                int v2 = value
                float z = nbt.z
                if (z > mz){
                    if (isInDeck == -1 && v == 0 && !hasChild && !otherHasChild && !found){
                        
                        s = this
                        found = true
                    }
                    else if (isInDeck == 0 && inFoundation && v - 1 == v2 && t == type && !otherHasChild && !found){

                        s = this
                        found = true
                    }
                }
            }
            if (found){
                parent.run(){
                    removeChild()
                }
                s.run(){
                    setChild(ss)
                }
                isInDeck = 0
                setParent(s)
            }
        }
        return found
    }
    def onRelease(){
        if (!hasChild && isInDeck == 0){
            reveal()
        }
        if (isInDeck != 1 && isInDeck >= 0){
            showTexture()
        }
        if (isInDeck != 1 && isInDeck >= 0){
            oldParent = parent
            if (!inFoundation){
                if (lookupParentRelease()){
                    oldParent.reveal()
                }
                else{
                    if (!lookupParent()){
                        bool movedBackToDeck = false
                        if (isInDeck == 2){
                            at({-15, -32, 18}){
                                if (@s[distance=..2]){
                                    x -= 4.0
                                    isInDeck = 1
                                    hide()
                                    movedBackToDeck = true
                                }
                            }
                        }
                        nbt.x = x
                        nbt.y = y
                        nbt.z = z
                        if (movedBackToDeck){
                            moveToTop()
                        }
                        if (hasParent){
                            parent.run(){
                                moveStack()
                            }
                        }
                        if (!movedBackToDeck){
                            if (lookupParentRelease()){
                                oldParent.reveal()
                            }
                        }
                    }
                    else{
                        oldParent.reveal()
                    }
                }
            } 
            else{
                if (!lookupParent()){
                    nbt.x = x
                    nbt.y = y
                    nbt.z = z
                    if (hasParent){
                        parent.run(){
                            moveStack()
                        }
                    }
                    if (lookupParentRelease()){
                        oldParent.reveal()
                    }
                }
                else{
                    oldParent.reveal()
                }
            }
            moveStack()
        }
        else if (isInDeck == 1){
            isInDeck = 2
            reveal()
            at(@s)./tp @s ~4 ~ ~
            moveToTop()
        }
        else if (isInDeck == -3){
            at(@s)
            with(Card){
                if (isInDeck == 2){
                    /tp @s ~ ~ ~0.1
                    hide()
                    isInDeck = 1
                }
            }
        }
        else if (isInDeck == -4){
            summon()
        }
    }

    def reveal(){
        if (isInDeck >= 0){
            wasRevealed = true
            showTexture()
            with(@a,true,!resetting)sound.play(minecraft:item.book.page_turn)
        }
    }
    def print(){
        if (isInDeck >= 0){
            wasRevealed = true
            switch(type){
                foreach(t in ("heart", "spade", "diamond","clover")){
                    t.index -> {
                        switch(value){
                            foreach(i in 1..13){
                                i.index -> {
                                    print("card "+t+" "+i)
                                }
                            }
                        }
                    }
                }
            }
        }
        else{
            print("empty")
        }
    }
    Card getChild(){
        return child
    }
    def makeFree(){
        
    }
    def moveToTop(){
        float mz = 0
        at(@s){
        with(@e[sort=nearest,distance=..1] in Card, true){
            float z = nbt.z
            if (z > mz){
                mz = z
            }
        }
        }
        mz += 0.01
        nbt.z = mz
    }
    def endingAnimation(){
        int card = type + value * 4
        if (card >= endingAnimation.anim_card && y > -64.0 && inFoundation){
            if (!animationStarted){
                animationStarted = true
                x,y = nbt.x, nbt.y

                sx = getRandomSpeedX()
                sy = getRandomSpeedY()
                at(@s)./tp @s ~ ~ 19
            }
            sy -= 0.1

            x += sx
            y += sy
            animationBounce:=0
            if (y < -50.0 && animationBounce < 3){
                animationBounce++
                float bounce = getBounce()
                sy *= bounce
                sy *= -1
            }

            nbt.x = x
            nbt.y = y

            int t = type
            int v = value
            at(@s)./tp @s ~ ~ ~0.01

            at(@s){
                new FakeCard(t, v)
            }
        }
    }
}
float getRandomSpeedX(){
    float a = random.range(-0.5, 0.5)
    return a
}
float getRandomSpeedY(){
    float a = random.range(0, 0.5)
    return a
}
float getBounce(){
    float a = random.range(0.5, 1.0)
    return a
}
class FakeCard extends CardBase{
    int tick
    def __init__(int type, int value){
        this.type = type
        this.value = value

        setScale(2, 3, 1)
        showTexture()
    }
    def @tick(){
        ./tp @s ~ ~ ~-0.001
    }
}

def summon(){
    resetting = true
    with(Card){
        /kill
    }
    shuffle()
    summonFoundation()
    at({-15, -36, 18})summonStack(0, 7)
    at({-11, -36, 18})summonStack(7, 6)
    at({-7, -36, 18})summonStack(13, 5)
    at({-3, -36, 18})summonStack(18, 4)
    at({1, -36, 18})summonStack(22, 3)
    at({5, -36, 18})summonStack(25, 2)
    at({9, -36, 18})summonStack(27, 1)

    at({-15, -32, 18})summonDeck(28)

    at({-3, -26, 18}) new Card(0, 0, -4)
    resetting = false
}

def summonFoundation(){
    at({-3, -32, 18}){
        var card = new Card(1, 0, -1)
    }
    at({1, -32, 18}){
        var card = new Card(1, 0, -1)
    }
    at({5, -32, 18}){
        var card = new Card(1, 0, -1)
    }
    at({9, -32, 18}){
        var card = new Card(1, 0, -1)
    }
}

def summonDeck(int start) {
    Card current
    at(~~~-0.1){
        current = new Card(0, 0, -3)
        current.makeFree()
    }
    for(int i = start; i < 52; i++){
        int card = cards_list[i]
        int a = card % 4
        int b = card / 4
        current = new Card(a, b, 1)
        current.makeFree()
    }
}
def summonStack(int start, int count) {
    Card first
    Card previous
    Card current

    current = new Card(0, 0, -2)
    current.makeFree()
    previous = current
    first = current

    for(int i = 0; i < count; i++){
        int card = cards_list[start + i]
        int a = card % 4
        int b = card / 4
        current = new Card(a, b)
        current.makeFree()

        previous.setChild(current)
        current.setParent(previous)
        
        previous = current
    }
    first.moveStack()
    current.reveal()
}