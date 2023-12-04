package fruit

lazy Texture banana_tex = addTextureVertical("spr_banana")
lazy Texture banana_texL = addTextureVertical("spr_banana_cut_left")
lazy Texture banana_texR = addTextureVertical("spr_banana_cut_right")
lazy Texture banana_splat = addTextureVertical("spr_banana_splat")

class Banana extends FruitBase{
    def override onInit(){
        super.onInit()
        setTexture(banana_tex)
    }
    def override onCut(int strength){
        int y = speed.y
        int x = strength + 10
        new FruitCut(new Vector2Int(-x, y), banana_texL)
        new FruitCut(new Vector2Int(x, y), banana_texR)
        new FruitSplat(new Vector2Int(x, y), banana_splat)
        super.onCut(strength)
    }
}