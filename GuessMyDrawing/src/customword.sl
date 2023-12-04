package customword

import standard.collections.List
import utils.PProcess
import random
import mc.inventory as inv
import mc.java.display.DisplayText

List<string> words
bool wasInitialized = false

DisplayText text

string escape(){
    string char
    at(0 -64 0){
        /data modify storage gmd.customword.escape.char json set string block ~ ~ ~ Items[0].tag.pages[0]
    }
    return char
}

def init(){
    at(23.0 19 33)text = new DisplayText()
    text.setBackgroundColor(0)
}
def update(){
    string text = ""
    int length = words.size()
    for (int i = 0; i < length; i++){
        text += words.get(i)
        if (i != length - 1){
            text += ", "
        }
    }
    text.setText(("========[Custom World]========\n", "bold", "yellow"), (text, "white"))
}


def @load(){
    if (wasInitialized){
        words = new List<string>()
    }
}

void add(string text){
    if (text != ""){
        if (words.contains(text)){
            words.remove(text)
            standard.print(("- ", "red"), (text, "red"))
            update()
        } else {
            words.add(text)
            standard.print(("+ ", "green"), (text, "green"))
            update()
        }
        /clear @s
    }
}
void add(){
    string char = escape()
    string text = word.getText().toLower().replace(";", ",").replace(char, ",")
    while(text != ""){
        if (text.contains(",")){
            int index = text.indexOf(",")
            string left = text.substring(0, index).trim()
            string right = text.substring(index + 1).trim()
            add(left)
            text = right
        }
        else{
            add(text)
            text = ""
        }
    }
}

int count(){
    return words.size()
}

string getWord(){
    int length = words.size()

    int index = random.range(0, length)
    string word = words.get(index)
    
    return word
}

PProcess word{
    def main(){
        add()
        inv.setMainHand(minecraft:writable_book{pages: [""]})
    }
}