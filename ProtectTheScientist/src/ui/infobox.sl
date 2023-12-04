package ui.infobox

from mc.sprite import _

class InfoBox extends Sprite{
    def lazy __init__(string texture){
        setTexture(addTextureVertical(texture))
        setScale(8, 8, 1)
        setCenterBillboard()
        setTranslation(0, 0, 8)
    }
}