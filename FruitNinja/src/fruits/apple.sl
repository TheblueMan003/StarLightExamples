package fruit

lazy Texture apple_tex = addTextureVertical("spr_apple")
lazy Texture apple_texL = addTextureVertical("spr_apple_cut_left")
lazy Texture apple_texR = addTextureVertical("spr_apple_cut_right")
lazy Texture apple_splat = addTextureVertical("spr_apple_splat")

class Apple extends FruitBase{
    def override onInit(){
        super.onInit()
        setTexture(apple_tex)
    }
    def override onCut(int strength){
        int y = speed.y
        int x = strength + 10
        new FruitCut(new Vector2Int(-x, y), apple_texL)
        new FruitCut(new Vector2Int(x, y), apple_texR)
        new FruitSplat(new Vector2Int(x, y), apple_splat)
        super.onCut(strength)
    }
}