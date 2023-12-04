package maps.theblueman003.screen

import mc.java.resourcespack.models as models
import mc.java.display.DisplayItem
import mc.Click
from mc.bedrock.Entity import Entity as BedrockEntity
from mc.Entity import Entity as EntityObject
import mc.java.display.DisplayText

import cmd.sound as sound
import cmd.entity as entity
import cmd.tag as tag
import cmd.block as block

import math.raycast as raycast

import utils.CProcess

import standard

lazy var buttonCount = 1
lazy var screenCount = 1
def lazy addButtonModels(string $name){
    if (Compiler.isJava()){
        [java_rp=true] jsonfile models.item.screen_button_$name{
            "credit": "Made with Blockbench",
            "texture_size": [128, 128],
            "textures": {
                "0": "item/screen_button_$name",
                "particle": "item/screen_button_$name"
            },
            "elements": [
                {
                    "from": [-8, 0, 8],
                    "to": [24, 8, 8],
                    "faces": {
                        "north": {"uv": [0, 0, 16, 4], "texture": "#0"},
                        "east": {"uv": [0, 0, 16, 4], "texture": "#0"},
                        "south": {"uv": [0, 0, 16, 4], "texture": "#0"},
                        "west": {"uv": [0, 0, 16, 4], "texture": "#0"},
                        "up": {"uv": [0, 0, 16, 4], "texture": "#0"},
                        "down": {"uv": [0, 0, 16, 4], "texture": "#0"}
                    }
                }
            ]
        }
        [java_rp=true] jsonfile models.item.screen_button_$name_selected{
            "credit": "Made with Blockbench",
            "texture_size": [128, 128],
            "textures": {
                "0": "item/screen_button_$name",
                "particle": "item/screen_button_$name"
            },
            "elements": [
                {
                    "from": [-8, 0, 8],
                    "to": [24, 8, 8],
                    "faces": {
                        "north": {"uv": [0, 4, 16, 8], "texture": "#0"},
                        "east": {"uv": [0, 4, 16, 8], "texture": "#0"},
                        "south": {"uv": [0, 4, 16, 8], "texture": "#0"},
                        "west": {"uv": [0, 4, 16, 8], "texture": "#0"},
                        "up": {"uv": [0, 4, 16, 8], "texture": "#0"},
                        "down": {"uv": [0, 4, 16, 8], "texture": "#0"}
                    }
                }
            ]
        }
        [java_rp=true] jsonfile models.item.screen_button_$name_clicked{
            "credit": "Made with Blockbench",
            "texture_size": [128, 128],
            "textures": {
                "0": "item/screen_button_$name",
                "particle": "item/screen_button_$name"
            },
            "elements": [
                {
                    "from": [-8, 0, 8],
                    "to": [24, 8, 8],
                    "faces": {
                        "north": {"uv": [0, 8, 16, 12], "texture": "#0"},
                        "east": {"uv": [0, 8, 16, 12], "texture": "#0"},
                        "south": {"uv": [0, 8, 16, 12], "texture": "#0"},
                        "west": {"uv": [0, 8, 16, 12], "texture": "#0"},
                        "up": {"uv": [0, 8, 16, 12], "texture": "#0"},
                        "down": {"uv": [0, 8, 16, 12], "texture": "#0"}
                    }
                }
            ]
        }
        [java_rp=true] jsonfile models.item.screen_button_$name_disabled{
            "credit": "Made with Blockbench",
            "texture_size": [128, 128],
            "textures": {
                "0": "item/screen_button_$name",
                "particle": "item/screen_button_$name"
            },
            "elements": [
                {
                    "from": [-8, 0, 8],
                    "to": [24, 8, 8],
                    "faces": {
                        "north": {"uv": [0, 12, 16, 16], "texture": "#0"},
                        "east": {"uv": [0, 12, 16, 16], "texture": "#0"},
                        "south": {"uv": [0, 12, 16, 16], "texture": "#0"},
                        "west": {"uv": [0, 12, 16, 16], "texture": "#0"},
                        "up": {"uv": [0, 12, 16, 16], "texture": "#0"},
                        "down": {"uv": [0, 12, 16, 16], "texture": "#0"}
                    }
                }
            ]
        }
        models.add(minecraft:birch_boat, "item/screen_button_$name", buttonCount*10+1)
        models.add(minecraft:birch_boat, "item/screen_button_$name_selected", buttonCount*10+2)
        models.add(minecraft:birch_boat, "item/screen_button_$name_clicked", buttonCount*10+3)
        models.add(minecraft:birch_boat, "item/screen_button_$name_disabled", buttonCount*10+4)
    }
    if (Compiler.isBedrock()){
        ButtonEntity.addButton("screen_button_$name")
    }
    buttonCount++
}
def lazy addCharacterButtonModels(string $name){
    if (Compiler.isJava()){
        [java_rp=true] jsonfile models.item.screen_button_credit_$name{
            "credit": "Made with Blockbench",
            "texture_size": [32, 32],
            "textures": {
                "0": "item/credit_character_$name",
                "particle": "item/credit_character_$name"
            },
            "elements": [
                {
                    "from": [-8, -8, 8],
                    "to": [24, 24, 8],
                    "faces": {
                        "north": {"uv": [0, 0, 16, 16], "texture": "#0"},
                        "east": {"uv": [0, 0, 16, 16], "texture": "#0"},
                        "south": {"uv": [0, 0, 16, 16], "texture": "#0"},
                        "west": {"uv": [0, 0, 16, 16], "texture": "#0"},
                        "up": {"uv": [0, 0, 16, 16], "texture": "#0"},
                        "down": {"uv": [0, 0, 16, 16], "texture": "#0"}
                    }
                }
            ]
        }
        [java_rp=true] jsonfile models.item.screen_button_credit_$name_selected{
            "credit": "Made with Blockbench",
            "texture_size": [32, 32],
            "textures": {
                "0": "item/credit_character_$name_selected",
                "particle": "item/credit_character_$name_selected"
            },
            "elements": [
                {
                    "from": [-8, -8, 8],
                    "to": [24, 24, 8],
                    "faces": {
                        "north": {"uv": [0, 0, 16, 16], "texture": "#0"},
                        "east": {"uv": [0, 0, 16, 16], "texture": "#0"},
                        "south": {"uv": [0, 0, 16, 16], "texture": "#0"},
                        "west": {"uv": [0, 0, 16, 16], "texture": "#0"},
                        "up": {"uv": [0, 0, 16, 16], "texture": "#0"},
                        "down": {"uv": [0, 0, 16, 16], "texture": "#0"}
                    }
                }
            ]
        }
        [java_rp=true] jsonfile models.item.screen_button_credit_$name_clicked{
            "credit": "Made with Blockbench",
            "texture_size": [32, 32],
            "textures": {
                "0": "item/credit_character_$name_clicked",
                "particle": "item/credit_character_$name_clicked"
            },
            "elements": [
                {
                    "from": [-8, -8, 8],
                    "to": [24, 24, 8],
                    "faces": {
                        "north": {"uv": [0, 0, 16, 16], "texture": "#0"},
                        "east": {"uv": [0, 0, 16, 16], "texture": "#0"},
                        "south": {"uv": [0, 0, 16, 16], "texture": "#0"},
                        "west": {"uv": [0, 0, 16, 16], "texture": "#0"},
                        "up": {"uv": [0, 0, 16, 16], "texture": "#0"},
                        "down": {"uv": [0, 0, 16, 16], "texture": "#0"}
                    }
                }
            ]
        }
        [java_rp=true] jsonfile models.item.screen_button_credit_$name_disabled{
            "credit": "Made with Blockbench",
            "texture_size": [32, 32],
            "textures": {
                "0": "item/credit_character_$name_disabled",
                "particle": "item/credit_character_$name_disabled"
            },
            "elements": [
                {
                    "from": [-8, -8, 8],
                    "to": [24, 24, 8],
                    "faces": {
                        "north": {"uv": [0, 0, 16, 16], "texture": "#0"},
                        "east": {"uv": [0, 0, 16, 16], "texture": "#0"},
                        "south": {"uv": [0, 0, 16, 16], "texture": "#0"},
                        "west": {"uv": [0, 0, 16, 16], "texture": "#0"},
                        "up": {"uv": [0, 0, 16, 16], "texture": "#0"},
                        "down": {"uv": [0, 0, 16, 16], "texture": "#0"}
                    }
                }
            ]
        }
        models.add(minecraft:birch_boat, "item/screen_button_credit_$name", buttonCount*10+1)
        models.add(minecraft:birch_boat, "item/screen_button_credit_$name_selected", buttonCount*10+2)
        models.add(minecraft:birch_boat, "item/screen_button_credit_$name_clicked", buttonCount*10+3)
        models.add(minecraft:birch_boat, "item/screen_button_credit_$name_disabled", buttonCount*10+4)
    }
    if (Compiler.isBedrock()){
        ButtonEntity.addButton("credit_character_$name")
    }
    buttonCount++
}
def lazy addMapsButtonModels(string $name){
    if (Compiler.isJava()){
        [java_rp=true] jsonfile models.item.screen_button_map_$name{
            "credit": "Made with Blockbench",
            "texture_size": [32, 32],
            "textures": {
                "0": "item/$name",
                "particle": "item/$name"
            },
            "elements": [
                {
                    "from": [-16, -6, 8],
                    "to": [32, 21, 8],
                    "faces": {
                        "north": {"uv": [0, 0, 16, 9], "texture": "#0"},
                        "east": {"uv": [0, 0, 16, 9], "texture": "#0"},
                        "south": {"uv": [0, 0, 16, 9], "texture": "#0"},
                        "west": {"uv": [0, 0, 16, 9], "texture": "#0"},
                        "up": {"uv": [0, 0, 16, 9], "texture": "#0"},
                        "down": {"uv": [0, 0, 16, 9], "texture": "#0"}
                    }
                }
            ]
        }
        [java_rp=true] jsonfile models.item.screen_button_map_$name_selected{
            "credit": "Made with Blockbench",
            "texture_size": [32, 32],
            "textures": {
                "0": "item/$name_selected",
                "particle": "item/$name_selected"
            },
            "elements": [
                {
                    "from": [-16, -6, 8],
                    "to": [32, 21, 8],
                    "faces": {
                        "north": {"uv": [0, 0, 16, 9], "texture": "#0"},
                        "east": {"uv": [0, 0, 16, 9], "texture": "#0"},
                        "south": {"uv": [0, 0, 16, 9], "texture": "#0"},
                        "west": {"uv": [0, 0, 16, 9], "texture": "#0"},
                        "up": {"uv": [0, 0, 16, 9], "texture": "#0"},
                        "down": {"uv": [0, 0, 16, 9], "texture": "#0"}
                    }
                }
            ]
        }
        [java_rp=true] jsonfile models.item.screen_button_map_$name_clicked{
            "credit": "Made with Blockbench",
            "texture_size": [32, 32],
            "textures": {
                "0": "item/$name_clicked",
                "particle": "item/$name_clicked"
            },
            "elements": [
                {
                    "from": [-16, -6, 8],
                    "to": [32, 21, 8],
                    "faces": {
                        "north": {"uv": [0, 0, 16, 9], "texture": "#0"},
                        "east": {"uv": [0, 0, 16, 9], "texture": "#0"},
                        "south": {"uv": [0, 0, 16, 9], "texture": "#0"},
                        "west": {"uv": [0, 0, 16, 9], "texture": "#0"},
                        "up": {"uv": [0, 0, 16, 9], "texture": "#0"},
                        "down": {"uv": [0, 0, 16, 9], "texture": "#0"}
                    }
                }
            ]
        }
        [java_rp=true] jsonfile models.item.screen_button_map_$name_disabled{
            "credit": "Made with Blockbench",
            "texture_size": [32, 32],
            "textures": {
                "0": "item/$name_disabled",
                "particle": "item/$name_disabled"
            },
            "elements": [
                {
                    "from": [-16, -6, 8],
                    "to": [32, 21, 8],
                    "faces": {
                        "north": {"uv": [0, 0, 16, 9], "texture": "#0"},
                        "east": {"uv": [0, 0, 16, 9], "texture": "#0"},
                        "south": {"uv": [0, 0, 16, 9], "texture": "#0"},
                        "west": {"uv": [0, 0, 16, 9], "texture": "#0"},
                        "up": {"uv": [0, 0, 16, 9], "texture": "#0"},
                        "down": {"uv": [0, 0, 16, 9], "texture": "#0"}
                    }
                }
            ]
        }
        models.add(minecraft:birch_boat, "item/screen_button_map_$name", buttonCount*10+1)
        models.add(minecraft:birch_boat, "item/screen_button_map_$name_selected", buttonCount*10+2)
        models.add(minecraft:birch_boat, "item/screen_button_map_$name_clicked", buttonCount*10+3)
        models.add(minecraft:birch_boat, "item/screen_button_map_$name_disabled", buttonCount*10+4)
    }
    if (Compiler.isBedrock()){
        ButtonEntity.addButton("$name")
    }
    buttonCount++
}
def lazy addScreenModels(string $name){
    if (Compiler.isJava()){
        [java_rp=true]jsonfile models.item.screen_$name{
            "credit": "Made with Blockbench",
            "texture_size": [256, 256],
            "textures": {
                "0": "item/screen_$name",
                "particle": "item/screen_$name"
            },
            "elements": [
                {
                    "from": [-16, 0, 8],
                    "to": [32, 27, 8],
                    "faces": {
                        "north": {"uv": [0, 0, 16, 8.9375], "texture": "#0"},
                        "east": {"uv": [0, 0, 16, 8.9375], "texture": "#0"},
                        "south": {"uv": [0, 0, 16, 8.9375], "texture": "#0"},
                        "west": {"uv": [0, 0, 16, 8.9375], "texture": "#0"},
                        "up": {"uv": [0, 0, 16, 8.9375], "texture": "#0"},
                        "down": {"uv": [0, 0, 16, 8.9375], "texture": "#0"}
                    }
                }
            ]
        }
        models.add(minecraft:oak_boat, "item/screen_$name", screenCount)
        screenCount++
    }
    if (Compiler.isBedrock()){
        ScreenEntity.addScreen("screen_$name")
    }
}

BedrockEntity ButtonEntity{
    lazy var variantCount = 0
    setName("screen_button")
    setGeometry("screen_button")
    setIsSpawnable(true)
    isPushable(false, false)
    setInvinsible()
    setCollision(0, 0)

    def lazy addButton(string $name){
        addTexture("$name", "entities/$name")
        addTexture("$name_selected", "entities/$name_selected")
        addTexture("$name_clicked", "entities/$name_clicked")
        addTexture("$name_disabled", "entities/$name_disabled")

        event("set_button_type_"+buttonCount){
            setVariant(variantCount)
        }
        event("set_button_type_"+buttonCount+"_selected"){
            setVariant(variantCount+1)
        }
        event("set_button_type_"+buttonCount+"_clicked"){
            setVariant(variantCount+2)
        }
        event("set_button_type_"+buttonCount+"_disabled"){
            setVariant(variantCount+3)
        }
        variantCount+=4
    }
}
BedrockEntity ScreenEntity{
    lazy var variantCount = 0
    setName("screen_background")
    setGeometry("screen_background")
    setIsSpawnable(true)
    isPushable(false, false)
    setCollision(0, 0)
    setInvinsible()
    def lazy addScreen(string $tex){
        addTexture("$tex", "entities/$tex")
        lazy var a = variantCount + 1
        lazy var id = "set_screen_"+a
        event(id){
            setVariant(variantCount)
        }
        variantCount++
    }
}

typedef EntityObject ButtonParent for mcbedrock, DisplayItem ButtonParent for mcjava
typedef EntityObject ScreenParent for mcbedrock, DisplayItem ScreenParent for mcjava

class ButtonEntity extends ButtonParent with sl:screen_button for mcbedrock{
    def __init__(){
    }
    def lazy select(int index){
        if (Compiler.isBedrock()){
            entity.event("set_button_type_"+index+"_selected")
        }
        if (Compiler.isJava()){
            lazy val model = index * 10
            setItem("minecraft:birch_boat", {CustomModelData: model + 2})
        }
    }
    def lazy unselect(int index){
        if (Compiler.isBedrock()){
            entity.event("set_button_type_"+index)
        }
        if (Compiler.isJava()){
            lazy val model = index * 10
            setItem("minecraft:birch_boat", {CustomModelData: model + 1})
        }
    }
    def lazy click(int index){
        if (Compiler.isBedrock()){
            entity.event("set_button_type_"+index+"_clicked")
        }
        if (Compiler.isJava()){
            lazy val model = index * 10
            setItem("minecraft:birch_boat", {CustomModelData: model + 3})
        }
    }
    def lazy disable(int index){
        if (Compiler.isBedrock()){
            entity.event("set_button_type_"+index+"_disabled")
        }
        if (Compiler.isJava()){
            lazy val model = index * 10
            setItem("minecraft:birch_boat", {CustomModelData: model + 4})
        }
    }
    def __destroy__(){
        entity.despawn()
    }
}
class ScreenEntity extends ScreenParent with sl:screen_background for mcbedrock{
    def __init__(){
        if (Compiler.isJava()){
            setScale(3,3,3)
        }
    }
    
    def lazy setScreen(int count){
        if (Compiler.isJava()){
            setItem(minecraft:oak_boat, {CustomModelData: count})
        }
        if (Compiler.isBedrock()){
            entity.event("set_screen_" + count)
        }
    }
    def __destroy__(){
        entity.despawn()
    }
}

entity buttons
entity user
entity players
ScreenEntity background

scoreboard int click

scoreboard bool enabled
scoreboard int selected

scoreboard void=>void onSelect
scoreboard void=>void onUnselect
scoreboard void=>void onClick
scoreboard void=>void onClickRelease
scoreboard void=>void onDisable

lazy json credit_user = []

def lazy int makeCharacterDoll(string name){
    if (Compiler.isJava()){
        lazy var file = "lib/theblueman_screen/java_resourcepack/assets/minecraft/textures/item/credit_character_"+name+".png"
        lazy var exists = File.exists(file)
        if (exists){
        }
        else{
            lazy var cmd = "python lib/theblueman_screen/java_resourcepack/assets/minecraft/textures/item/credit_character_generator.py "+name
            Compiler.print("Downloading character: "+name)
            File.run(cmd)
        }
        lazy val button = buttonCount
        addCharacterButtonModels(name)
        return button
    }
    if (Compiler.isBedrock()){
        lazy var file = "lib/theblueman_screen/bedrock_resourcepack/textures/entities/credit_character_"+name+".png"
        lazy var exists = File.exists(file)
        if (exists){
        }
        else{
            lazy var cmd = "python lib/theblueman_screen/java_resourcepack/assets/minecraft/textures/item/credit_character_generator.py "+name
            Compiler.print("Downloading character: "+name)
            File.run(cmd)
        }
        lazy val button = buttonCount
        addCharacterButtonModels(name)
        return button
    }
}

def lazy int makeMapsButton(string name){
    if (Compiler.isJava()){
        lazy var file = "java_resourcepack/assets/minecraft/textures/item/"+name+"_selected.png"
        lazy var exists = File.exists(file)
        if (exists){
        }
        else{
            lazy var cmd = "python java_resourcepack/assets/minecraft/textures/item/maps_image_generator.py "+name
            Compiler.print("Making map button: "+name)
            File.run(cmd)
        }
        lazy val button = buttonCount
        addMapsButtonModels(name)
        return button
    }
    if (Compiler.isBedrock()){
        lazy var file = "bedrock_resourcepack/textures/entities/"+name+"_selected.png"
        lazy var exists = File.exists(file)
        if (exists){
        }
        else{
            lazy var cmd = "python bedrock_resourcepack/textures/entities/maps_image_generator.py "+name
            Compiler.print("Making map button: "+name)
            File.run(cmd)
        }
        lazy val button = buttonCount
        addMapsButtonModels(name)
        return button
    }
}
[compile.order=-1]
private void makeDefault(){
    addScreenModels("background")
    addScreenModels("title")
    addScreenModels("info")
    addScreenModels("times")

    addButtonModels("home")
    addButtonModels("credit")
    addButtonModels("settings")
    addButtonModels("times")
    addButtonModels("maps")
    addButtonModels("info")
    addButtonModels("start")
}

def @screen.home(){
    def lazy tag(){
        tag.add("screen.page.button")
    }
    background.run(){
        background.setScreen(2)
        at(@s){
            at(~ ~ ~0.01){
                summonButton(7, tag){
                    @screen.start()
                }
            }
        }
    }
}
def @screen.times(){
    background.run(){
        background.setScreen(4)
    }
}
def @screen.info(){
    background.run(){
        printVersion()
        background.setScreen(3)
        @screen.info.button()
    }
}
def @screen.clear(){
    background.run(){
        background.setScreen(1)
    }
    with(@e[tag=screen.page.button]){
        entity.despawn()
    }
}
class InfoDisplay extends DisplayText{
    def lazy __init__(rawjson text){
        setText(text)
        setBackgroundColor(0)
        setLeft()
        setScale(2,2,2)
        setLineWidth(150)
    }
}
def lazy setInfo(rawjson text){
    def @screen.clear(){
        with(InfoDisplay)./kill
    }
    def @screen.info.button(){
        at(@s)at(~ ~ ~)new InfoDisplay(text)
    }
}
"""
Add a character button to the screen
"""
public lazy void addCredit(int credit_count, string name, void=>void fct){
    lazy val indx = makeCharacterDoll(name)
    DisplayItem button
    def lazy tag(){
        tag.add("screen.page.button")
    }
    def @screen.credit(){
        background.run(){
            at(@s){
                foreach(x in -3.5..3.5 by 1.75){
                    lazy val dx = credit_count % 5
                    lazy val dxi = x.index % 5
                    if (dx == dxi){
                        foreach(y in 0.0..2.0 by 2.0){
                            lazy val dy = (credit_count / 5) % 2
                            lazy val dyi = y.index % 2
                            if (dy == dyi){
                                lazy val py = 2.5 - y
                                Compiler.insert(($x, $y), (x,py)){
                                    at(~$x ~$y ~0.01){
                                        summonButton(indx, tag, fct)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

"""
Add a map button to the screen
"""
public lazy void addMap(int index, string name, void=>void fct){
    lazy val indx = makeMapsButton(name)
    DisplayItem button
    def lazy tag(){
        tag.add("screen.page.button")
    }
    def @screen.maps(){
        background.run(){
            at(@s){
                if (index == 0){
                    at(~ ~2.5 ~0.01){
                        summonButton(indx, tag, fct)
                    }
                }
                if (index == 1){
                    at(~-2.5 ~0.5 ~0.01){
                        summonButton(indx, tag, fct)
                    }
                }
                if (index == 2){
                    at(~2.5 ~0.5 ~0.01){
                        summonButton(indx, tag, fct)
                    }
                }
            }
        }
    }
}
private lazy void summonButton(int index, void=>void onCreated, void=>void fct){
    ButtonEntity button = new ButtonEntity()
    button.unselect(index)
    button.run(){
        buttons += @s
        selected = 0
        enabled = true

        onCreated()

        onUnselect = ()=>{
            if (enabled){
                button.unselect(index)
                selected --
            }
        }
        onSelect = ()=>{
            if (enabled){
                button.select(index)
                if (selected <= 0){
                    with(user, true)sound.play(minecraft:entity.item.pickup)
                }
                selected = 2
            }
        }
        onClick = ()=>{
            if (enabled){
                button.click(index)
            }
        }
        onClickRelease = ()=>{
            if (enabled){
                button.unselect(index)
                with(user, true){
                    fct()
                    sound.play(minecraft:block.note_block.bell)
                }
            }
        }
        onDisable = ()=>{
            button.disable(index)
        }
    }
}
private lazy void summonButton(int index){
    summonButton(index, null){
        @screen.clear()
        if (index == 1){
            @screen.home()
        }
        if (index == 2){
            @screen.credit()
        }
        if (index == 3){
            @screen.settings()
        }
        if (index == 4){
            @screen.times()
        }
        if (index == 5){
            @screen.maps()
        }
        if (index == 6){
            @screen.info()
        }
    }
}
public lazy void summon(int button1, int button2, int button3, int button4){
    aligned(){
        rotated(0,0){
            block.fill(~-4~~,~4~4~,minecraft:barrier)
            at(~ ~1.5 ~){
                background = new ScreenEntity()
                background.setScreen(1)
            }
            at(~-3.5 ~0.65 ~0.01){
                summonButton(button1)
            }
            at(~-1.25 ~0.65 ~0.01){
                summonButton(button2)
            }
            at(~1.25 ~0.65 ~0.01){
                summonButton(button3)
            }
            at(~3.5 ~0.65 ~0.01){
                summonButton(button4)
            }

            @screen.home()
        }
    }
}
Click click_detector{
    def onClick(){
        click = 3
    }
    def onRelease(){
        click = 1
    }
    def onHold(){
        click = 2
    }
}
CProcess main{
    def main(){
        with(buttons){
            onUnselect()
        }
        with(@a in players,true){
            user += @s
            int c = click
            raycast.shoot(20, 0.5, block(minecraft:barrier)){
                with(@e[distance=..1,limit=1,sort=nearest] in buttons,true){
                    if (c == 0){
                        onSelect()
                    }
                    if (c == 2){
                        onClick()
                    }
                    if (c == 1){
                        onClickRelease()
                    }
                }
            }
            if (click == 1){
                click = 0
            }
            user -= @s
        }
    }
}
def start(){
    players += @s
    main.start()
    click_detector.start()
}
[tag.order=-1]
public @screen.start void stop(){
    players -= @s
    main.stop()
    click_detector.stop()
}

def lazy onStart(void=>void fct){
    def @screen.start(){
        with(user, true)fct()
    }
}
