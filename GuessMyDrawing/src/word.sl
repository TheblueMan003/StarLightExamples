package word

import mc.inventory as inv
import cmd.entity as entity
import cmd.title as title
import cmd.score as score
import cmd.actionbar as actionbar
import cmd.sound as sound
import game.score as gs
import utils.Process
import random
import math
import math.Time
import game.language as lang

int word
entity seeker
scoreboard int score
int guessed
string wordString
Time DrawingTime
int showWordHint

[nbt="SelectedItem.tag.pages[0]"] scoreboard json submitted_text

string getText(){
    string text = ""
    if (inv.isHoldingItem(minecraft:written_book, 1)){
        /data modify storage gmd.word.get-text.text json set string entity @s SelectedItem.tag.pages[0] 9 -2
    }
    else if (inv.isHoldingItem(minecraft:writable_book, 1)){
        text = submitted_text
    }
    else{
        text = ""
    }

    if (text != ""){
        inv.setMainHand(minecraft:book)
        inv.setMainHand(minecraft:writable_book{pages: [""]})
    }
    return text.trim().toLower()
}
bool check(){
    bool ret = false
    def lazy make(json info){
        switch(word){
            -1 -> {
                string text = getText()
                if (text.contains(wordString)){
                    ret = true
                }
            }
            foreach(w in info["words"]){
                w.index -> {
                    if (Compiler.isJava()){
                        string text = getText()
                        if (text.contains(w)){
                            ret = true
                        }
                        wordString = w
                    }
                    if (Compiler.isBedrock()){
                        with(@e[name=w,type=item,distance=..1,limit=1]){
                            ret = true
                            entity.kill()
                        }
                    }
                }
            }
        }
    }
    lang.forEach(text.text, make)
    return ret
}
Process main{
    int endTick
    int letterTick
    int letterCount
    Time time
    Time maxTime
    bool ended

    def end(){
        if (time > 5){
            ended = true
            showAll()
        }
    }
    def reset(){
        endTick = 0
        ended = false
        time = 0
        letterTick = 0
        letterCount = 0
    }
    def main(){
        bool remaining = false
        time ++
        string hint = ""
        if (showWordHint == 1){
            int length = wordString.length()
            hint = "_" * length
        }
        if (showWordHint == 2){
            letterTick++
            if (letterTick > 30 * 20){
                letterTick = 0
                letterCount++
            }
            int length = wordString.length()
            hint = wordString.substring(0, letterCount) + "_" * (length - letterCount)
        }
        with(@a in seeker,true){ 
            remaining = true
            if (showWordHint){
                actionbar.show(10,10,(hint, "gray"))
            }
            if (check()){
                score += math.max(5 - guessed, 1)
                guessed++
                seeker -= @s
                def lazy make(json info){
                    title.show(30,0, 80,0,(info["word_found_self"], "green"))

                    inv.clear()
                    sound.play(minecraft:entity.player.levelup)
                    standard.print((@s, "green"), (info["word_found_other"], "green"))
                }
                lang.forEach(text.text, make)
            }
            else if (Compiler.isJava()){
                inv.setMainHand(minecraft:writable_book{pages: [""]})
            }
        }
        if (!remaining && !ended){
            end()
        }
        if (time > maxTime && !ended){
            end()
        }
        Time delta = maxTime - time
        def lazy make(json info){
            switch(delta){
                new Time(0, 1, 0, 0) -> standard.print((info["time_warning_1min"], "green"))
                new Time(0, 0, 30, 0) -> standard.print((info["time_warning_30sec"], "green"))
                new Time(0, 0, 10, 0) -> standard.print((info["time_warning_10sec"], "green"))
            }
        }
        lang.forEach(text.text, make)
        if (ended){
            endTick++
            if (endTick > 90){
                standard.print("="*40)
                reset()
                game.nextRound()
            }
        }
    }
    def onStart(){
        maxTime = DrawingTime
        reset()
        def lazy make(json info){
            score.showSidebar(score, (info["scores"], "gold", "bold"))
        }
        lang.forEach(text.text, make)
    }
}
def selectDefault(){
    def lazy make(json info){
        word = random.range(0, Compiler.length(info["words"]))
    }
    lang.forEach(text.text, make)
}
def select(){
    if (customword.count() == 0){
        selectDefault()
    }
    else{
        if (hub.wordSelection == 0){
            if (random.range(0, 2) == 0){
                selectDefault()
            }
            else{
                word = -1
                wordString = customword.getWord()
            }
        }
        else if (hub.wordSelection == 1){
            selectDefault()
        }
        else if (hub.wordSelection == 2){
            word = -1
            wordString = customword.getWord()
        }
    }
}
def show(){
    def lazy make(json info){
        if (main.enabled){
            switch(word){
                -1 -> actionbar.show(10,10,(info["word"], "green"), " ", wordString)
                foreach(w in info["words"]){
                    w.index -> actionbar.show(10,10,(info["word"], "green")," ", w)
                }
            }
        }
    }
    lang.forEach(text.text, make)
}
def showAll(){
    def lazy make(json info){
        with(@a,true){
            title.show(90,10,80,10,(info["word_was"], "green"))
            switch(word){
                -1 -> title.showSubtitle((wordString, "green"))
                foreach(w in info["words"]){
                    w.index -> title.showSubtitle((w, "green"))
                }
            }
        }
    }
    lang.forEach(text.text, make)
    save.save()
}
def setSeeker(){
    seeker += @s
    inv.clear()
    /tp @s 3.87 33.49 25.70 -180.08 3.31
}
def [tag.order=-1] @game.nextRound(){
    seeker -= @a
    guessed = 0
    main.reset()
    select()
    main.start()
}
def stop(){
    main.stop()
    seeker -= @a
}
def @game.start(){
    with(@a){
        score = 0
    }
}
def showLeaderboard(){
    int rank = 1
    gs.forEachOrdered(@a, score, false){
        standard.print(("#","green"), (rank,"green"),(" - ", "green"), (@s,"green"), (" : ", "green"), (score,"green"))
        rank++
    }
}