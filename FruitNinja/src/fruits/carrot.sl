package fruit

lazy Texture carrot_tex = addTextureVertical("spr_carrot")
lazy Texture carrot_texL = addTextureVertical("spr_carrot_cut_left")
lazy Texture carrot_texR = addTextureVertical("spr_carrot_cut_right")
lazy Texture carrot_splat = addTextureVertical("spr_carrot_splat")

class Carrot extends FruitBase{
    def override onInit(){
        super.onInit()
        setTexture(carrot_tex)
    }
    def override onCut(int strength){
        int y = speed.y
        int x = strength + 10
        new FruitCut(new Vector2Int(-x, y), carrot_texL)
        new FruitCut(new Vector2Int(x, y), carrot_texR)
        new FruitSplat(new Vector2Int(x, y),carrot_splat)
        super.onCut(strength)
    }
}