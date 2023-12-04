package save

string getBlock(){
    if (block(minecraft:white_concrete)){
        return "0"
    }
    else if (block(minecraft:orange_concrete)){
        return "1"
    }
    else if (block(minecraft:magenta_concrete)){
        return "2"
    }
    else if (block(minecraft:light_blue_concrete)){
        return "3"
    }
    else if (block(minecraft:yellow_concrete)){
        return "4"
    }
    else if (block(minecraft:lime_concrete)){
        return "5"
    }
    else if (block(minecraft:pink_concrete)){
        return "6"
    }
    else if (block(minecraft:gray_concrete)){
        return "7"
    }
    else if (block(minecraft:light_gray_concrete)){
        return "8"
    }
    else if (block(minecraft:cyan_concrete)){
        return "9"
    }
    else if (block(minecraft:purple_concrete)){
        return "a"
    }
    else if (block(minecraft:blue_concrete)){
        return "b"
    }
    else if (block(minecraft:brown_concrete)){
        return "c"
    }
    else if (block(minecraft:green_concrete)){
        return "d"
    }
    else if (block(minecraft:red_concrete)){
        return "e"
    }
    else if (block(minecraft:black_concrete)){
        return "f"
    }
    else{
        return "x"
    }
}


"""
if repeated < 3 then it is a normal character
if repeated >= 3 then x(repeated - 3) + character x
"""
string runTimeLengthEncoding(string source){
    string result = ""
    string current = ""
    int repeated = 0
    while(source != ""){
        string character = source[0]
        source = source[1..]
        if (character == current){
            repeated++
        }
        else{
            if (repeated >= 3){
                int count = (repeated - 3)
                result += "x" + count + current + "x"
            }
            else{
                result += current * repeated
            }
            current = character
            repeated = 1
        }
    }
    if (repeated >= 3){
        int count = (repeated - 3)
        result += "x" + count + current + "x"
    }
    else{
        result += current * repeated
    }
    return result
}
def save(string name){
    string image = ""
    def recH(int width){
        if (width > 0){
            image += getBlock()
            at(~1 ~0 ~0)recH(width - 1)
        }
    }
    def recV(int height){
        if (height > 0){
            recH(73)
            at(~0 ~-1 ~0)recV(height - 1)
        }
    }
    
    at(-36 50 -30)recV(51)

    def macro inner(string name, string text){
        /tellraw @a {"text":"Click here to download the image [$(name)].","color":"yellow","clickEvent":{"action":"open_url","value":"https://theblueman003.com/guess_my_drawing/download.php?data=$(text)"}}
    }
    
    inner(name, runTimeLengthEncoding(image))
}

def save(){
    if (game.singlePlayer.enabled){
        save("Free Drawing")
    }
    else{
        save(word.wordString)
    }
}