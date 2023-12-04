package mc.java.display

import cmd.java.data as data
import mc.Entity

"""
Class representing an generic display entity.
"""
class DisplayEntity extends Entity{
    """
    Set the entity's scale.
    """
    def lazy setScale(float scale){
        data.set({"transformation":{"scale":[scale f, scale f, scale f]}})
    }
    
    """
    Set the entity's scale.
    """
    def lazy setScale(float x, float y, float z){
        data.set({"transformation":{"scale":[x f, y f, z f]}})
    }

    """
    Set the entity's rotation.
    """
    def lazy setLeftRotation(float x, float y, float z, float w){
        lazy val a = Compiler.toRadians(w)
        data.set({"transformation":{"left_rotation":{"axis":[x f, y f, z f], "angle":a f}}})
    }

    """
    Set the entity's rotation.
    """
    def lazy setRightRotation(float x, float y, float z, float w){
        lazy val a = Compiler.toRadians(w)
        data.set({"transformation":{"right_rotation":{"axis":[x f, y f, z f], "angle":a f}}})
    }

    """
    Set the entity's translation.
    """
    def lazy setTranslation(float x, float y, float z){
        data.set({"transformation":{"translation":[x f, y f, z f]}})
    }


    """
    Set the entity's Billboard to none.
    """
    def lazy setFixedBillboard(bool fixed){
        data.set({"billboard":"fixed"})
    }

    """
    Set the entity's Billboard to Vertical.
    """
    def lazy setVerticalBillboard(bool vertical){
        data.set({"billboard":"vertical"})
    }

    """
    Set the entity's Billboard to Horizontal.
    """
    def lazy setHorizontalBillboard(bool horizontal){
        data.set({"billboard":"horizontal"})
    }

    """
    Set the entity's Billboard to Center.
    """
    def lazy setCenterBillboard(bool center){
        data.set({"billboard":"center"})
    }

    """
    Set entity Sky Light.
    """
    def lazy setSkyLight(int value){
        data.set({"brightness":{"sky":value, "block":value}})
    }

    """
    Set entity Block Light.
    """
    def lazy setBlockLight(int value){
        data.set({"brightness":{"block":value, "sky":value}})
    }

    """
    Set View Range
    """
    def lazy setViewRange(float value){
        data.set({"view_range":value})
    }

    """
    Set Shadow Radius
    """
    def lazy setShadowRadius(float value){
        data.set({"shadow_radius":value f})
    }

    """
    Set Shadow Strength
    """
    def lazy setShadowStrength(float value){
        data.set({"shadow_strength":value f})
    }

    """
    Set Bounding Box
    """
    def lazy setBoundingBox(float width, float height){
        data.set({"width":width f, "height":height f})
    }

    """
    Set glow color override
    """
    def lazy setGlowColor(int c){
        data.set({"glow_color_override":r})
    }

    """
    Interpolate Interpolation
    """
    def lazy interpolate(int duration){
        data.set({"start_interpolation":0, "interpolation_duration":duration})
    }

    """
    Interpolate the entity's scale.
    """
    def lazy interpolateScale(int duration, float scale){
        data.set({"start_interpolation":0, "interpolation_duration":duration,"transformation":{"scale":[scale f, scale f, scale f]}})
    }
    
    """
    Interpolate the entity's scale.
    """
    def lazy interpolateScale(int duration, float x, float y, float z){
        data.set({"start_interpolation":0, "interpolation_duration":duration,"transformation":{"scale":[x f, y f, z f]}})
    }

    """
    Interpolate the entity's rotation.
    """
    def lazy interpolateLeftRotation(int duration, float x, float y, float z, float w){
        lazy val a = Compiler.toRadians(w)
        data.set({"start_interpolation":0, "interpolation_duration":duration,"transformation":{"left_rotation":{"axis":[x f, y f, z f], "angle":a f}}})
    }

    """
    Interpolate the entity's rotation.
    """
    def lazy interpolateRightRotation(int duration, float x, float y, float z, float w){
        lazy val a = Compiler.toRadians(w)
        data.set({"start_interpolation":0, "interpolation_duration":duration,"transformation":{"right_rotation":{"axis":[x f, y f, z f], "angle":a f}}})
    }

    """
    Interpolate the entity's translation.
    """
    def lazy interpolateTranslation(int duration, float x, float y, float z){
        data.set({"start_interpolation":0, "interpolation_duration":duration,"transformation":{"translation":[x f, y f, z f]}})
    }
}
