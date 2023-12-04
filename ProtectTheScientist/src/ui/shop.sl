package ui.shop

from mc.sprite import _
import cmd.actionbar as ab
import cmd.sound as sound
import game.language as lang

class ShopButton extends button.Button{
    int tick
    infobox.InfoBox infobox
    void=>void onHover
    void=>infobox.InfoBox onHoverStart
    
    def lazy __init__(int normal, int selected, int clicked, void=>void actionHover, void=>infobox.InfoBox actionHoverStart, void=>void action){
        __init__(normal, selected, clicked, action)
        onHover = actionHover
        onHoverStart = actionHoverStart
    }
    def override unselect(){
        super.unselect()
        tick --
        if (tick == 0){
            infobox.run(){
                ./kill
            }
        }
    }
    def override select(){
        super.select()
        at(@s)at(~~6~){
            if (tick <= 0){
                infobox = onHoverStart()
            }
        }
        tick = 5
        onHover()
    }
}
class StartButton extends button.Button{
    def override select(){
        super.select()
        def lazy make(json info){
            with(@a in selector.user, true)ab.show(20, 10, (info["start_wave"], "green", "bold"))
        }
        lang.forEach(wave.spawner.infos, make)
    }
}
class SpeedButton extends button.Button{
    def override select(){
        super.select()
        def lazy make(json info){
            with(@a in selector.user, true)ab.show(20, 10, (info["change_speed"], "green", "bold"))
        }
        lang.forEach(wave.spawner.infos, make)
    }
}

ShopButton catArcher
ShopButton spike
ShopButton fox
ShopButton pixie
ShopButton owlArcher
ShopButton thunderMage
ShopButton iceMage
button.Button speedButton
button.Button playbutton

def @reset summon(){
    def lazy make(json info){
        at(-15 2 -12)catArcher = new ShopButton(addTexture("spr_button_archer_cat"), addTexture("spr_button_archer_cat_selected"), addTexture("spr_button_archer_cat_clicked"),
            ()=>showPrice(info["cat_archer"], 10),
            ()=> {return new infobox.InfoBox("spr_info_cat_archer")},
            ()=>buy(10){new entity.defender.cat_archer.CatArcher()}
        )
        at(-13 2 -12)spike = new ShopButton(addTexture("spr_button_spike"), addTexture("spr_button_spike_selected"), addTexture("spr_button_spike_clicked"),
            ()=>showPrice(info["spike"], 5),
            ()=> {return new infobox.InfoBox("spr_info_spike")},
            ()=>buy(5){new entity.defender.spike.Spike()}
        )
        at(-11 2 -12)fox = new ShopButton(addTexture("spr_button_fox"), addTexture("spr_button_fox_selected"), addTexture("spr_button_fox_clicked"),
            ()=>showPrice(info["fox"], 50),
            ()=> {return new infobox.InfoBox("spr_info_fox")},
            ()=>buy(50){new entity.defender.fox.Fox()}
        )
        at(-9 2 -12)pixie = new ShopButton(addTexture("spr_button_pixie"), addTexture("spr_button_pixie_selected"), addTexture("spr_button_pixie_clicked"),
            ()=>showPrice(info["pixie"], 100),
            ()=> {return new infobox.InfoBox("spr_info_pixie")},
            ()=>buy(100){new entity.defender.pixie.Pixie()}
        )
        at(-7 2 -12)owlArcher = new ShopButton(addTexture("spr_button_archer_owl"), addTexture("spr_button_archer_owl_selected"), addTexture("spr_button_archer_owl_clicked"),
            ()=>showPrice(info["owl_archer"], 150),
            ()=> {return new infobox.InfoBox("spr_info_owl_archer")},
            ()=>buy(150){new entity.defender.owl_archer.OwlArcher()}
        )
        at(-5 2 -12)thunderMage = new ShopButton(addTexture("spr_button_thunder_mage"), addTexture("spr_button_thunder_mage_selected"), addTexture("spr_button_thunder_mage_clicked"),
            ()=>showPrice(info["thunder_mage"], 500),
            ()=> {return new infobox.InfoBox("spr_info_thunder_mage")},
            ()=>buy(500){new entity.defender.thunder_mage.ThunderMage()}
        )
        at(-3 2 -12)iceMage = new ShopButton(addTexture("spr_button_ice_mage"), addTexture("spr_button_ice_mage_selected"), addTexture("spr_button_ice_mage_clicked"),
            ()=>showPrice(info["ice_arcmage"], 1000),
            ()=> {return new infobox.InfoBox("spr_info_ice_mage")},
            ()=>buy(1000){new entity.defender.ice_mage.IceMage()}
        )

        at(12 2 -12)speedButton = new SpeedButton(addTexture("spr_button_speed"), addTexture("spr_button_speed_selected"), addTexture("spr_button_speed_clicked"),
            ()=>{
                tmenu.close()
                if (game.speed == 1){
                    game.speed = 2
                    print((info["speed_2"], "green"))
                }
                else if (game.speed == 2){
                    game.speed = 4
                    print((info["speed_4"], "green"))
                }
                else{
                    game.speed = 1
                    print((info["speed_1"], "green"))
                }
            }
        )
        at(14 2 -12)playbutton = new StartButton(addTexture("spr_button_play"), addTexture("spr_button_play_selected"), addTexture("spr_button_play_click"),
            ()=>{
                if(!wave.spawner.inWave && !wave.spawner.startLocked){
                    wave.spawner.nextWave()
                }
            }
        )
    }
    lang.forEach(wave.spawner.infos, make)
}
def lazy showPrice(string name, int count){
    def lazy make(json info){
        with(@a in selector.user, true)ab.show(20, 10, (name, "dark_aqua", "bold"), (" - ","dark_aqua"), (info["price"],"dark_aqua","bold"),(count,"aqua"), (" "+info["money"], "gold", "bold"), (game.money, "yellow"))
    }
    lang.forEach(wave.spawner.infos, make)
}
def lazy buy(int price, void=>void onBuy){
    tmenu.close()
    if (game.money >= price && !wave.spawner.inWave && !wave.spawner.startLocked){
        game.money -= price
        onBuy()
        entity.defender.Defender s
        with(@e[sort=nearest,limit=1] in entity.defender.Defender, true){
            s = __ref :> entity.defender.Defender
        }
        with(@a in selector.user, true){
            selector.selector.select(s)
        }
    }
    else if (!wave.spawner.inWave){
        with(@a in selector.user, true){
            sound.play(minecraft:entity.villager.no)
            def lazy make(json info){
                print((info["no_buy_money"], "red"))
            }
            lang.forEach(wave.spawner.infos, make)
        }
    }
    else{
        with(@a in selector.user, true){
            sound.play(minecraft:entity.villager.no)
            def lazy make(json info){
                print((info["no_buy_wave"], "red"))
            }
            lang.forEach(wave.spawner.infos, make)
        }
    }
}