package fruit

lazy Texture blueberry_tex = addTextureVertical("spr_blueberry")
lazy Texture blueberry_texL = addTextureVertical("spr_blueberry_cut_left")
lazy Texture blueberry_texR = addTextureVertical("spr_blueberry_cut_right")
lazy Texture blueberry_splat = addTextureVertical("spr_blueberry_splat")

class Blueberry extends FruitBase{
    def override onInit(){
        super.onInit()
        setTexture(blueberry_tex)
    }
    def override onCut(int strength){
        int y = speed.y
        int x = strength + 10
        new FruitCut(new Vector2Int(-x, y), blueberry_texL)
        new FruitCut(new Vector2Int(x, y), blueberry_texR)
        new FruitSplat(new Vector2Int(x, y),blueberry_splat)
        super.onCut(strength)
    }
}