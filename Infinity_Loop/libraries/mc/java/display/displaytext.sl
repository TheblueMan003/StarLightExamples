package mc.java.display.DisplayText

import mc.java.display.DisplayEntity
import cmd.java.data as data

"""
Class representing an text display entity.
"""
public class DisplayText extends DisplayEntity with minecraft:text_display for mcjava {
    def lazy __init__(){
    }

    """
    Set the text to be displayed
    """
    def lazy setText(rawjson $text){
        /data merge entity @s {"text":'$text'}
    }

    """
    Set Line Width
    """
    def lazy setLineWidth(int width){
        data.set({"line_width":width})
    }

    """
    Set the text opcacity
    """
    def lazy setOpacity(int opacity){
        data.set({"text_opacity":opacity})
    }

    """
    Set the background color
    """
    def lazy setBackgroundColor(int color){
        data.set({"background":color})
    }

    """
    Set the background color
    """
    def lazy setBackgroundColor(int r, int g, int b, int a = 127){
        setBackgroundColor((a << 24) + (r << 16) + (g << 8) + b)
    }

    """
    Set default background
    """
    def lazy setDefaultBackground(bool value){
        data.set({"default_background":value})
    }

    """
    Set shadow
    """
    def lazy setShadow(bool value){
        data.set({"shadow":value})
    }

    """
    Set See Through
    """
    def lazy setSeeThrough(){
        data.set({"see_through":true})
    }

    """
    Set alignment to center
    """
    def lazy setCenter(){
        data.set({"alignment":"center"})
    }

    """
    Set alignment to left
    """
    def lazy setLeft(){
        data.set({"alignment":"left"})
    }

    """
    Set alignment to right
    """
    def lazy setRight(){
        data.set({"alignment":"right"})
    }
}
