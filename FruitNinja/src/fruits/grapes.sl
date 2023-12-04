package fruit

lazy Texture grapes_tex = addTextureVertical("spr_grapes")
lazy Texture grapes_texL = addTextureVertical("spr_grapes_cut_left")
lazy Texture grapes_texR = addTextureVertical("spr_grapes_cut_right")
lazy Texture grapes_splat = addTextureVertical("spr_grapes_splat")

class Grapes extends FruitBase{
    def override onInit(){
        super.onInit()
        setTexture(grapes_tex)
    }
    def override onCut(int strength){
        int y = speed.y
        int x = strength + 10
        new FruitCut(new Vector2Int(-x, y), grapes_texL)
        new FruitCut(new Vector2Int(x, y), grapes_texR)
        new FruitSplat(new Vector2Int(x, y),grapes_splat)
        super.onCut(strength)
    }
}