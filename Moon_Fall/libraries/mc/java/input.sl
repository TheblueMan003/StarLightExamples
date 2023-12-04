package mc.java.input

import cmd.schedule as schedule
import mc.inventory as inventory

private enum eventList(string criterion){
    Click("minecraft.used:minecraft.carrot_on_a_stick"),
    ClickWarpedFungus("minecraft.used:minecraft.warped_fungus_on_a_stick"),
    Jump("minecraft.custom:minecraft.jump"),
    Drop("minecraft.custom:minecraft.drop"),
    Die("minecraft.custom:minecraft.deaths"),
    Hit("minecraft.custom:minecraft.damage_dealt"),
    Relog("minecraft.custom:minecraft.leave_game"),
    Damage("minecraft.custom:minecraft.damage_taken"),
    BowShoot("minecraft.used:minecraft.bow"),
    CrossbowShoot("minecraft.used:minecraft.crossbow"),
    KillPlayer("minecraft.custom:minecraft.player_kills"),
    Kill("minecraft.custom:minecraft.totalKillCount"),
    Bred("minecraft.custom:minecraft.animals_bred"),
    CleanArmor("minecraft.custom:minecraft.clean_armor"),
    CleanBanner("minecraft.custom:minecraft.clean_banner"),
    OpenBarrel("minecraft.custom:minecraft.open_barrel"),
    BellRing("minecraft.custom:minecraft.bell_ring"),
    EatCakeSlice("minecraft.custom:minecraft.eat_cake_slice"),
    FillCauldron("minecraft.custom:minecraft.fill_cauldron"),
    OpenChest("minecraft.custom:minecraft.open_chest"),
    DamageAbsorbed("minecraft.custom:minecraft.damage_absorbed"),
    DamageBlockByShield("minecraft.custom:minecraft.damage_blocked_by_shield"),
    OpenEnderChest("minecraft.custom:minecraft.open_enderchest"),
    InteractFurnace("minecraft.custom:minecraft.interact_with_furnace")
}

private enum eventParamBlockList(string criterion){
    Mined("minecraft.mined:minecraft."),
    Break("minecraft.broken:minecraft.")
}
private enum eventParamItemList(string criterion){
    Craft("minecraft.crafted:minecraft."),
    Use("minecraft.used:minecraft."),
    PickUp("minecraft.picked_up:minecraft."),
    Drop("minecraft.dropped:minecraft.")
}
private enum eventParamEntityList(string criterion){
    Kill("minecraft.killed:minecraft."),
    Killed("minecraft.killed_by:minecraft.")
}

private enum continuousEventList(string criterion){
    Sneak("minecraft.custom:minecraft.sneak_time"),
    Walk("minecraft.custom:minecraft.walk_one_cm"),
    WalkOnWater("minecraft.custom:minecraft.walk_on_water_one_cm"),
    WalkUnderWater("minecraft.custom:minecraft:walk_under_water_one_cm"),
    Boat("minecraft.custom:minecraft.boat_one_cm"),
    Horse("minecraft.custom:minecraft.horse_one_cm"),
    Minecart("minecraft.custom:minecraft:minecart_one_cm"),
    Pig("minecraft.custom:minecraft:pig_one_cm"),
    Strider("minecraft.custom:minecraft:strider_one_cm"),
    Swim("minecraft.custom:minecraft.swim_one_cm"),
    Sprint("minecraft.custom:minecraft.sprint_one_cm"),
    Fly("minecraft.custom:minecraft.fly_one_cm"),
    Fall("minecraft.custom:minecraft.fall_one_cm"),
    Climb("minecraft.custom:minecraft.climb_one_cm"),
    Elytra("minecraft.custom:minecraft.aviate_one_cm")
}
forgenerate($e,eventList){
    def lazy on$e(int=>void fct){
        lazy val criterion = "$e.criterion"
        [criterion=criterion] scoreboard int count
        def @input.init @input.reset init$e(){
            count = 0
        }
        
        if (count > 0){
            fct(count)
            entity tag 
            tag += @s;
            schedule.add(1){
                with(tag, true){
                    tag -= @s
                    @input.reset()
                }
            }
        }
    }
}
forgenerate($e,eventParamBlockList){
    def lazy on$e(mcobject block, int=>void fct){
        lazy val name = Compiler.getNamespaceName(block)
        lazy val criterion = "$e.criterion" + name
        [criterion=criterion] scoreboard int count
        def @input.init @input.reset init$e(){
            count = 0
        }
        
        if (count > 0){
            fct(count)
            entity tag 
            tag += @s;
            schedule.add(1){
                with(tag, true){
                    tag -= @s
                    @input.reset()
                }
            }
        }
    }
}


forgenerate($e,eventParamItemList){
    def lazy on$e(mcobject block, int=>void fct){
        lazy val name = Compiler.getNamespaceName(block)
        lazy val criterion = "$e.criterion" + name
        [criterion=criterion] scoreboard int count
        def @input.init @input.reset init$e(){
            count = 0
        }
        
        if (count > 0){
            fct(count)
            entity tag 
            tag += @s;
            schedule.add(1){
                with(tag, true){
                    tag -= @s
                    @input.reset()
                }
            }
        }
    }
}

forgenerate($e,eventParamEntityList){
    def lazy on$e(mcobject block, int=>void fct){
        lazy val name = Compiler.getNamespaceName(block)
        lazy val criterion = "$e.criterion" + name
        [criterion=criterion] scoreboard int count
        def @input.init @input.reset init$e(){
            count = 0
        }
        
        if (count > 0){
            fct(count)
            entity tag 
            tag += @s;
            schedule.add(1){
                with(tag, true){
                    tag -= @s;
                    @input.reset()
                }
            }
        }
    }
}

forgenerate($e,continuousEventList){
    def lazy on$e(int=>void fct){
        lazy val criterion = "$e.criterion"
        [criterion=criterion] scoreboard int count
        scoreboard bool active
        def @input.init @input.reset init$e(){
            count = 0
        }
        
        if (count > 0 && !active){
            fct(count)
            active = true
            entity tag 
            tag += @s;
            schedule.add(1){
                with(tag, true){
                    tag -= @s
                    @input.reset()
                }
            }
        }
        else if(count > 0 && active){
        }
        else{
            active = false
        }
    }
    def lazy during$e(int=>void fct){
        lazy val criterion = "$e.criterion"
        [criterion=criterion] scoreboard int count
        def @input.init @input.reset init$e(){
            count = 0
        }
        
        if (count > 0){
            fct(count)
            entity tag
            tag += @s;
            schedule.add(1){
                with(tag, true){
                    tag -= @s
                    @input.reset()
                }
            }
        }
    }
}

private enum Buttons(string button, string name){
    StoneButton("minecraft:stone_button", "StoneButton"),
    OakButton("minecraft:oak_button", "OakButton"),
    BirchButton("minecraft:birch_button", "BirchButton"),
    SpruceButton("minecraft:spruce_button", "SpruceButton"),
    DarkOakButton("minecraft:dark_oak_button", "DarkOakButton"),
    AcaciaButton("minecraft:acacia_button", "AcaciaButton"),
    JungleButton("minecraft:jungle_button", "JungleButton"),
    MangroveButton("minecraft:mangrove_button", "MangroveButton"),
    CherryButton("minecraft:cherry_button", "CherryButton"),
    PolishedBlackstoneButton("minecraft:polished_blackstone_button", "PolishedBlackstoneButton"),
    WarpedButton("minecraft:warped_button", "WarpedButton"),
    CrimsonButton("minecraft:crimson_button", "CrimsonButton")
}

private enum button_facing{north, east, west, south}
private enum button_face{floor,wall,ceiling}

forgenerate($button,Buttons){
    def lazy on$button(mcposition pos, void=>void func){
        at(pos){
            if (block(~ ~ ~, "$button.button[powered=true]")){
                func()
                forgenerate($facin,button_facing){
                    forgenerate($face,button_face){
                        if (block(~ ~ ~, "$button.button[face=$face,facing=$facin,powered=true]")){
                            /setblock ~ ~ ~ $button.button[face=$face,facing=$facin,powered=false]
                        }
                    }
                }
            }
        }
    }
}private enum PressurePlates(string plate, string name){
    StonePressurePlate("minecraft:stone_pressure_plate", "StonePressurePlate"),
    OakPressurePlate("minecraft:oak_pressure_plate", "OakPressurePlate"),
    BirchPressurePlate("minecraft:birch_pressure_plate", "BirchPressurePlate"),
    SprucePressurePlate("minecraft:spruce_pressure_plate", "SprucePressurePlate"),
    DarkOakPressurePlate("minecraft:dark_oak_pressure_plate", "DarkOakPressurePlate"),
    AcaciaPressurePlate("minecraft:acacia_pressure_plate", "AcaciaPressurePlate"),
    JunglePressurePlate("minecraft:jungle_pressure_plate", "JunglePressurePlate"),
    MangrovePressurePlate("minecraft:mangrove_pressure_plate", "MangrovePressurePlate"),
    CherryPressurePlate("minecraft:cherry_pressure_plate", "CherryPressurePlate"),
    PolishedBlackstonePressurePlate("minecraft:polished_blackstone_pressure_plate", "PolishedBlackstonePressurePlate"),
    WarpedPressurePlate("minecraft:warped_pressure_plate", "WarpedPressurePlate"),
    CrimsonPressurePlate("minecraft:crimson_pressure_plate", "CrimsonPressurePlate")
}

forgenerate($plate,PressurePlates){
    def lazy on$plate(mcposition pos, void=>void func){
        at(pos){
            if (block(~ ~ ~, "$plate.pressure_plate[powered=true]")){
                func()                
                /setblock ~ ~ ~ $plate.pressure_plate[powered=false]
            }
        }
    }
}

def lazy onScroll(int=>void f){
    import mc.java.nbt
    scoreboard int slot
    int x
    int scrollDelta = 0
    nbt.getNBT(x, "SelectedItem")
    
    if (x == slot){
        scrollDelta = 0
        slot = x
    }
    if (x < slot){
        if(x < 3 && slot >= 7){
            scrollDelta = 1
        }
        else{
            scrollDelta = -1
        }
        
        slot = x
    }
    if (x > slot){
        if(x >= 7 && slot < 3){
            scrollDelta = -1
        }
        else{
            scrollDelta = 1
        }
        
        slot = x
    }
    if (scrollDelta != 0)f(scrollDelta)
}
