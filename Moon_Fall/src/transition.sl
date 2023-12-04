package player

"""
Legacy transition. Kept for cutscene compatibility.
"""
class Transition extends Sprite{
    int tick
    def __init__(){
        setScale(30,30,1)
        setTexture(addTextureVertical("spr_transition"))
    }
    def @tick(){
        tick++
        if (tick == 2){
            interpolateTranslation(20, -20, 0, 0)
        }
    }
}

class TransitionIn extends Sprite{
    int tick
    def __init__(){
        setScale(30,30,1)
        setTexture(addTextureVertical("spr_transition"))
        setTranslation(30, 0, -4)
    }
    def @tick(){
        tick++
        if (tick == 2){
            interpolateTranslation(20, 0, 0, -4)
        }
    }
}

class TransitionOut extends Sprite{
    int tick
    def __init__(){
        setScale(30,30,1)
        setTexture(addTextureVertical("spr_transition_out"))
        setTranslation(0, 0, -4)
    }
    def @tick(){
        tick++
        if (tick == 2){
            interpolateTranslation(20, -30, 0, -4)
        }
    }
}