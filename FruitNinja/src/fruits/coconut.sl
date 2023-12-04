package fruit

lazy Texture coconut_tex = addTextureVertical("spr_coconut")
lazy Texture coconut_texL = addTextureVertical("spr_coconut_cut_left")
lazy Texture coconut_texR = addTextureVertical("spr_coconut_cut_right")
lazy Texture coconut_splat = addTextureVertical("spr_coconut_splat")

class Coconut extends FruitBase{
    def override onInit(){
        super.onInit()
        setTexture(coconut_tex)
    }
    def override onCut(int strength){
        int y = speed.y
        int x = strength + 10
        new FruitCut(new Vector2Int(-x, y), coconut_texL)
        new FruitCut(new Vector2Int(x, y), coconut_texR)
        new FruitSplat(new Vector2Int(x, y),coconut_splat)
        super.onCut(strength)
    }
}