package fruit

lazy Texture pepper_tex = addTextureVertical("spr_pepper")
lazy Texture pepper_texL = addTextureVertical("spr_pepper_cut_left")
lazy Texture pepper_texR = addTextureVertical("spr_pepper_cut_right")
lazy Texture pepper_splat = addTextureVertical("spr_pepper_splat")

class Pepper extends FruitBase{
    def override onInit(){
        super.onInit()
        setTexture(pepper_tex)
    }
    def override onCut(int strength){
        int y = speed.y
        int x = strength + 10
        new FruitCut(new Vector2Int(-x, y), pepper_texL)
        new FruitCut(new Vector2Int(x, y), pepper_texR)
        new FruitSplat(new Vector2Int(x, y),pepper_splat)
        super.onCut(strength)
    }
}