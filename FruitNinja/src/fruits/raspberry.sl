package fruit

lazy Texture raspberry_tex = addTextureVertical("spr_raspberry")
lazy Texture raspberry_texL = addTextureVertical("spr_raspberry_cut_left")
lazy Texture raspberry_texR = addTextureVertical("spr_raspberry_cut_right")
lazy Texture rasberry_splat = addTextureVertical("spr_raspberry_splat")

class Raspberry extends FruitBase{
    def override onInit(){
        super.onInit()
        setTexture(raspberry_tex)
    }
    def override onCut(int strength){
        int y = speed.y
        int x = strength + 10
        new FruitCut(new Vector2Int(-x, y), raspberry_texL)
        new FruitCut(new Vector2Int(x, y), raspberry_texR)
        new FruitSplat(new Vector2Int(x, y),rasberry_splat)
        super.onCut(strength)
    }
}