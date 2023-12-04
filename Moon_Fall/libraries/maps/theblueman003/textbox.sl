package maps.theblueman003.Textbox

import mc.java.display.DisplayText
import mc.resourcespack.sound as sound
import cmd.java.data as data
import game.language as lang
import cmd.sound as csound

lazy json alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
lazy string alphabet2 = "abcdefghijklmnopqrstuvwxyz"
Template sounds{
    foreach(letter in alphabet){
        sound.add("voice/0/"+letter)
    }
}
void=>void onTick
lazy json indexes = {}

class Textbox extends DisplayText{
    int index
    int tick
    int char
    int length

    def lazy __init__(float scale){
        setScale(scale, scale, scale)
        setLeft()
        setFixedBillboard()
        setBackgroundColor(0)
        index = -1
    }

    bool isFinished(){
        if (char >= length){
            return true
        }
        else{
            return false
        }
    }

    def reset(){
        tick = 0
        char = 0
        length = 0
    }

    def static lazy withLanguages(json text, float width){
        def lazy withLanguage(json text){
            lazy int count = Compiler.length(text) - 1
            switch(index){
                foreach(key in text){
                    key.index -> {
                        animate(text[key]["text"], width, text[key]["pitch"], text[key]["speed"])
                        indexes[key] = key.index
                    }
                }
            }
        }
        def [compile.order=-1] lambda(){
            Compiler.print("Compiling Language")
            lang.forEach(text, withLanguage)
        }
        onTick = lambda
    }
    def lazy display(string key){
        reset()
        index = indexes[key]
    }

    def setFloor(){
        data.set({Rotation:[0f,-90f]})
    }

    def lazy animate(string text, float width, float pitch, int speed){
        setLineWidth(width)
        lazy int l = Compiler.length(text)
        lazy int l2 = l - 1
        switch(char){
            foreach(sub in 0..l2){
                sub -> setText(Compiler.replace(text[0..sub], "'", "`") + "\n" + (" " * 100))
            }
        }
        tick += speed
        if (tick >= 20)
        {
            tick -= 20
            char++
            if (char < l2) {
                lazy string upper
                lazy string lower
                lazy bool upi
                lazy bool loi
                lazy int lcg = 0
                
                switch(char - 1){
                    foreach(sub in 0..l2){
                        sub -> {
                            upper = text[sub]
                            lower = !upper
                            upi = upper in alphabet2
                            loi = lower in alphabet2
                            if (upi){
                                with(@a,true)csound.play("minecraft:voice.0."+upper, 1, pitch)
                            }
                            if (loi){
                                with(@a,true)csound.play("minecraft:voice.0."+lower, 1, pitch)
                            }
                            if (upper != " " && upper != "\n" && !loi && !upi){
                                lower = alphabet2[lcg]
                                with(@a,true)csound.play("minecraft:voice.0."+lower, 1, pitch)
                                lcg = (lcg + 97) % 26
                            }
                        }
                    }
                }
            }
        }
        length = l
    }

    def @tick(){
        onTick()
    }
}
