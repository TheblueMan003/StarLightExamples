package fruit

lazy Texture beetroot_tex = addTextureVertical("spr_beetroot")
lazy Texture beetroot_texL = addTextureVertical("spr_beetroot_cut_left")
lazy Texture beetroot_texR = addTextureVertical("spr_beetroot_cut_right")
lazy Texture beetroot_splat = addTextureVertical("spr_beetroot_splat")

class Beetroot extends FruitBase{
    def override onInit(){
        super.onInit()
        setTexture(beetroot_tex)
    }
    def override onCut(int strength){
        int y = speed.y
        int x = strength + 10
        new FruitCut(new Vector2Int(-x, y), beetroot_texL)
        new FruitCut(new Vector2Int(x, y), beetroot_texR)
        new FruitSplat(new Vector2Int(x, y),beetroot_splat)
        super.onCut(strength)
    }
}