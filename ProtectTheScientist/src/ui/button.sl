package ui.button

from mc.sprite import _
import utils.PProcess
import math.raycast as rc

class Button extends Sprite{
    void=>void fctSelect
    void=>void fctUnselect
    void=>void fctClick
    void=>void onClick

    def lazy __init__(int normal, int selected, int clicked, void=>void action){
        setSize(2)
        fctSelect = ()=> {setTexture(selected)}
        fctUnselect = ()=> {setTexture(normal)}
        fctClick = ()=> {setTexture(clicked)}
        onClick = action
        at(@s)./tp @s ~0.5 ~0.51 ~0.5
    }
    def virtual click(){
        fctUnselect()
        onClick()
    }
    def virtual hold(){
        fctClick()
    }
    def virtual select(){
        fctSelect()
    }
    def virtual unselect(){
        fctUnselect()
    }
}
class ExtraLargeButton extends Button{
}