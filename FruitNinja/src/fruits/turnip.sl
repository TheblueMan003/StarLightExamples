package fruit

lazy Texture turnip_tex = addTextureVertical("spr_turnip")
lazy Texture turnip_texL = addTextureVertical("spr_turnip_cut_left")
lazy Texture turnip_texR = addTextureVertical("spr_turnip_cut_right")
lazy Texture turnip_splat = addTextureVertical("spr_turnip_splat")

class Turnip extends FruitBase{
    def override onInit(){
        super.onInit()
        setTexture(turnip_tex)
    }
    def override onCut(int strength){
        int y = speed.y
        int x = strength + 10
        new FruitCut(new Vector2Int(-x, y), turnip_texL)
        new FruitCut(new Vector2Int(x, y), turnip_texR)
        new FruitSplat(new Vector2Int(x, y),turnip_splat)
        super.onCut(strength)
    }
}