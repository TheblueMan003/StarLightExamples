package fruit

lazy Texture potato_tex = addTextureVertical("spr_potato")
lazy Texture potato_texL = addTextureVertical("spr_potato_cut_left")
lazy Texture potato_texR = addTextureVertical("spr_potato_cut_right")
lazy Texture potato_splat = addTextureVertical("spr_potato_splat")

class Potato extends FruitBase{
    def override onInit(){
        super.onInit()
        setTexture(potato_tex)
    }
    def override onCut(int strength){
        int y = speed.y
        int x = strength + 10
        new FruitCut(new Vector2Int(-x, y), potato_texL)
        new FruitCut(new Vector2Int(x, y), potato_texR)
        new FruitSplat(new Vector2Int(x, y),potato_splat)
        super.onCut(strength)
    }
}