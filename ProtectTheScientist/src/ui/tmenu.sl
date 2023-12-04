package ui.tmenu

from mc.sprite import _
import cmd.sound as sound
import game.language as lang
import mc.java.display.DisplayText

lazy Texture normal = addTexture("spr_turret_menu_button")
lazy Texture selected = addTexture("spr_turret_menu_button_selected")
lazy Texture clicked = addTexture("spr_turret_menu_button_clicked")
lazy Texture disabled = addTexture("spr_turret_menu_button_disabled")
lazy Texture header = addTexture("spr_turret_menu_header")

typedef entity.defender.Defender Defender

int pow(int a, int b){
    int res = 1
    for (int i = 0; i < b; i++){
        res *= a
    }
    return res
}

class TurretMenuText extends DisplayText{
    def lazy __init__(rawjson text){
        setText(text)
        setBackgroundColor(0)
        setScale(1.5,1.5,1.5)
        at(@s)./tp @s ~ ~-0.39 ~0.5 0 -90
    }
    def delete(){
        /kill
    }
}

class AttackButton extends button.ExtraLargeButton{
    Defender defender
    TurretMenuText text
    def __init__(Defender dff, int dummy){
        defender = dff
        setScale(5.25,1,1)
        if (dff.canUpdateAttack()){
            fctSelect = ()=> {setTexture(selected)}
            fctUnselect = ()=> {setTexture(normal)}
            fctClick = ()=> {setTexture(clicked)}
            setTexture(normal)
        }
        else{
            fctSelect = ()=> {setTexture(disabled)}
            fctUnselect = ()=> {setTexture(disabled)}
            fctClick = ()=> {setTexture(disabled)}
        }
        int tier = defender.getAttackUpgrade()
        int price = 4 + pow(2, tier)
        def lazy make(json info){
            if (defender.canUpdateAttack()){
                text = new TurretMenuText((info["upgrade_attack"], "black"), (tier, "black"), ("/10\n", "black"), (price, "gold"),("$", "gold"))
            }
            else{
                text = new TurretMenuText((info["upgrade_attack"], "black"), ("", "gold"))
            }
        }
        lang.forEach(wave.spawner.infos, make)

        onClick = action
    }

    def action(){
        int tier = defender.getAttackUpgrade()
        int price = 4 + pow(2, tier)
        if (game.money < price && defender.canUpdateAttack()){
            with(@a in selector.user, true){
                sound.play(minecraft:entity.villager.no)
                def lazy make(json info){
                    print((info["no_buy_money"], "red"))
                }
                lang.forEach(wave.spawner.infos, make)
            }
            close()
        }
        else if (defender.canUpdateAttack()){
            defender.updateAttack()
            game.money -= price
            close()
        }
    }
    def delete(){
        text.delete()
        /kill
    }
}
class SpeedButton extends button.ExtraLargeButton{
    Defender defender
    TurretMenuText text
    def __init__(Defender dff, int dummy){
        defender = dff
        setScale(5.25,1,1)
        if (dff.canUpdateSpeed()){
            fctSelect = ()=> {setTexture(selected)}
            fctUnselect = ()=> {setTexture(normal)}
            fctClick = ()=> {setTexture(clicked)}
            setTexture(normal)
        }
        else{
            fctSelect = ()=> {setTexture(disabled)}
            fctUnselect = ()=> {setTexture(disabled)}
            fctClick = ()=> {setTexture(disabled)}
        }
        int tier = defender.getSpeedUpgrade()
        int price = 4 + pow(2, tier)
        def lazy make(json info){
            if (defender.canUpdateSpeed()){
                text = new TurretMenuText((info["upgrade_speed"], "black"), (tier, "black"), ("/10\n", "black"), (price, "gold"),("$", "gold"))
            }
            else{
                text = new TurretMenuText((info["upgrade_speed"], "black"), ("", "gold"))
            }
        }
        lang.forEach(wave.spawner.infos, make)

        onClick = action
    }

    def action(){
        int tier = defender.getSpeedUpgrade()
        int price = 4 + pow(2, tier)
        if (game.money < price && defender.canUpdateSpeed()){
            with(@a in selector.user, true){
                sound.play(minecraft:entity.villager.no)
                def lazy make(json info){
                    print((info["no_buy_money"], "red"))
                }
                lang.forEach(wave.spawner.infos, make)
            }
            close()
        }
        else if (defender.canUpdateSpeed()){
            defender.updateSpeed()
            game.money -= price
            close()
        }
    }
    def delete(){
        text.delete()
        /kill
    }
}

class HealthButton extends button.ExtraLargeButton{
    Defender defender
    TurretMenuText text
    def __init__(Defender dff, int dummy){
        defender = dff
        setScale(5.25,1,1)
        if (dff.canUpdateHealth()){
            fctSelect = ()=> {setTexture(selected)}
            fctUnselect = ()=> {setTexture(normal)}
            fctClick = ()=> {setTexture(clicked)}
            setTexture(normal)
        }
        else{
            fctSelect = ()=> {setTexture(disabled)}
            fctUnselect = ()=> {setTexture(disabled)}
            fctClick = ()=> {setTexture(disabled)}
        }
        int tier = defender.getHealthUpgrade()
        int price = 4 + pow(2, tier)
        def lazy make(json info){
            if (defender.canUpdateHealth()){
                text = new TurretMenuText((info["upgrade_health"], "black"), (tier, "black"), ("/10\n", "black"), (price, "gold"),("$", "gold"))
            }
            else{
                text = new TurretMenuText((info["upgrade_health"], "black"), ("", "gold"))
            }
        }
        lang.forEach(wave.spawner.infos, make)

        onClick = action
    }

    def action(){
        int tier = defender.getHealthUpgrade()
        int price = 4 + pow(2, tier)
        if (game.money < price && defender.canUpdateHealth()){
            with(@a in selector.user, true){
                sound.play(minecraft:entity.villager.no)
                def lazy make(json info){
                    print((info["no_buy_money"], "red"))
                }
                lang.forEach(wave.spawner.infos, make)
            }
            close()
        }
        else if (defender.canUpdateHealth()){
            defender.updateHealth()
            game.money -= price
            close()
        }
    }
    def delete(){
        text.delete()
        /kill
    }
}
class MoveButton extends button.ExtraLargeButton{
    Defender defender
    selector.Selector sel
    TurretMenuText text
    def __init__(Defender dff, selector.Selector dummy){
        defender = dff
        setScale(5.25,1,1)
        sel = dummy
        fctSelect = ()=> {setTexture(selected)}
        fctUnselect = ()=> {setTexture(normal)}
        fctClick = ()=> {setTexture(clicked)}
        setTexture(normal)
    
        
        int tier = defender.getAttackUpgrade()
        int price = 4 + pow(2, tier)
        def lazy make(json info){
            text = new TurretMenuText((info["upgrade_move"], "black"), "\n")
        }
        lang.forEach(wave.spawner.infos, make)

        onClick = action
    }

    def action(){
        sel.select(defender)
        close()
    }
    def delete(){
        text.delete()
        /kill
    }
}
class SellButton extends button.ExtraLargeButton{
    Defender defender
    TurretMenuText text
    def __init__(Defender dff, int dummy){
        defender = dff
        setScale(5.25,1,1)
    
        fctSelect = ()=> {setTexture(selected)}
        fctUnselect = ()=> {setTexture(normal)}
        fctClick = ()=> {setTexture(clicked)}
        setTexture(normal)
    
        int tier1 = defender.getAttackUpgrade()
        int tier2 = defender.getSpeedUpgrade()
        int tier3 = defender.getHealthUpgrade()
        int total = pow(2, tier1) + pow(2, tier2) + pow(2, tier3) + 1

        def lazy make(json info){
            text = new TurretMenuText((info["upgrade_sell"], "black"), "\n", (total, "gold"),("$", "gold"))
        }
        lang.forEach(wave.spawner.infos, make)

        onClick = action
    }

    def action(){
        int tier1 = defender.getAttackUpgrade()
        int tier2 = defender.getSpeedUpgrade()
        int tier3 = defender.getHealthUpgrade()
        int total = pow(2, tier1) + pow(2, tier2) + pow(2, tier3) + 1
        game.money += total
        defender.die()
        close()
    }
    def delete(){
        text.delete()
        /kill
    }
}

class NameButton extends button.ExtraLargeButton{
    Defender defender
    TurretMenuText text
    def __init__(Defender dff, int dummy){
        defender = dff
        setScale(5.2,1,1.2)
    
        fctSelect = ()=> {setTexture(header)}
        fctUnselect = ()=> {setTexture(header)}
        fctClick = ()=> {setTexture(header)}
        setTexture(header)
    
        int index = defender.getNameIndex()

        def lazy make(json info){
            if (index == 0){
                text = new TurretMenuText((info["cat_archer"], "gold", "bold"))
            }
            else if (index == 1){
                text = new TurretMenuText((info["spike"], "gold", "bold"))
            }
            else if (index == 2){
                text = new TurretMenuText((info["fox"], "gold", "bold"))
            }
            else if (index == 3){
                text = new TurretMenuText((info["pixie"], "gold", "bold"))
            }
            else if (index == 4){
                text = new TurretMenuText((info["owl_archer"], "gold", "bold"))
            }
            else if (index == 5){
                text = new TurretMenuText((info["thunder_mage"], "gold", "bold"))
            }
            else if (index == 6){
                text = new TurretMenuText((info["ice_arcmage"], "gold", "bold"))
            }
            text.setScale(2,2,2)
        }
        lang.forEach(wave.spawner.infos, make)

        onClick = action
    }

    def action(){
    }
    def delete(){
        text.delete()
        /kill
    }
}
class CloseButton extends button.ExtraLargeButton{
    Defender defender
    TurretMenuText text
    def __init__(Defender dff, int dummy){
        defender = dff
        setScale(5.25,1,1)
        fctSelect = ()=> {setTexture(selected)}
        fctUnselect = ()=> {setTexture(normal)}
        fctClick = ()=> {setTexture(clicked)}
        setTexture(normal)
    
        
        def lazy make(json info){
            text = new TurretMenuText((info["upgrade_close"], "black"), "\n")
        }
        lang.forEach(wave.spawner.infos, make)

        onClick = action
    }

    def action(){
        close()
    }
    def delete(){
        text.delete()
        /kill
    }
}

def close(){
    with(NameButton){
        delete()
    }
    with(AttackButton){
        delete()
    }
    with(SpeedButton){
        delete()
    }
    with(HealthButton){
        delete()
    }
    with(MoveButton){
        delete()
    }
    with(SellButton){
        delete()
    }
    with(CloseButton){
        delete()
    }
}
import cmd.tp as tp
def summon(Defender defender, selector.Selector selector){
    close()
    int x = tp.getX()
    int y = tp.getZ()
    def make(){
        at(~~0.1~-1)new NameButton(defender, 0)
        at(~~~)new AttackButton(defender, 0)
        at(~~~1)new SpeedButton(defender, 0)
        at(~~~2)new HealthButton(defender, 0)
        at(~~~3)new MoveButton(defender, selector)
        at(~~~4)new SellButton(defender, 0)
        at(~~~5)new CloseButton(defender, 0)
    }
    if (x < 0){
        if (y < 0){
            at(~4~0.1~1)make()
        }
        else{
            at(~4~0.1~-5)make()
        }
    }
    else{
        if (y < 0){
            at(~-4~0.1~1)make()
        }
        else{
            at(~-4~0.1~-5)make()
        }
    }
}