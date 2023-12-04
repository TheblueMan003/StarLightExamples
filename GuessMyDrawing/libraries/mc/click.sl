package mc.Click

import mc.java.event as event
import mc.java.resourcespack.models as models
import utils.Process as Process
import mc.inventory.Setup
import mc.bedrock.Item

template Click {
    def virtual onClick(){

    }
    def virtual onHold(){

    }
    def virtual onRelease(){

    }
    private void _onClick(){
        onClick()
    }
    private void _onHold(){
        onHold()
    }
    private void _onRelease(){
        onRelease()
    }

    Item item{
        setName("click_detector")
        setNamespace("sl")
        setIcon("empty")
        item.onClick(_onClick)
        item.onHold(_onHold)
        item.onRelease(_onRelease)
    }

    Setup setup{
        if (Compiler.isJava()){
            [java_rp=true] jsonfile models.item.shield_empty{
                "credit": "Made with Blockbench",
                "texture_size": [32, 32],
                "textures": {
                    "0": "item/iron_pickaxe",
                    "particle": "item/iron_pickaxe"
                },
                "elements": []
            }
            models.add(minecraft:shield, "item/shield_empty", 1)
            forceHotbar(minecraft:shield{CustomModelData:1,display:{Name:"[{\"text\":\"\",\"italic\":false}]"}})
        }
        if (Compiler.isBedrock()){

        }
    }

    def start(){
        setup.add()
        main.start()
    }

    def stop(){
        setup.remove()
        main.stop()
    }

    if (Compiler.isJava()){
        scoreboard int wasClicked
        event.onUsingItem(minecraft:shield){
            if (wasClicked <= 0){
                _onClick()
            }
            wasClicked = 2
            _onHold()
        }
        Process main{
            void main(){
                with(@a, true){
                    wasClicked--
                    if (wasClicked == 0){
                        _onRelease()
                    }
                }
            }
        }
    }
}
