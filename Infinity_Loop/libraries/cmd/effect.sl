package cmd.effect

forgenerate($name, (absorption, unluck, bad_omen, blindness, conduit_power, dolphins_grace, 
                fire_resistance, glowing, haste, health_boost, hero_of_the_village,
                hunger, instant_damage, instant_health, invisibility, jump_boost, levitation,
                luck, mining_fatigue, nausea, night_vision, poison, regeneration, resistance,
                saturation, slow_falling, slowness, speed, strength, water_breathing, weakness,
                wither, darkness)){
    """
    Give effect `$name` to `ent` for `duration` and `power`.
    Show particles if `particle`
    """
    def lazy $name(entity ent, int duration = -1, int power = 0, bool particle = true){
        if (Compiler.isJava()){
            if (duration <= -1){
                Compiler.insert(($ent, $duration, $power, $particle), (ent, duration, power, particle)){
                    /effect give $ent $name infinite $power $particle
                }
            }
            else{
                Compiler.insert(($ent, $duration, $power, $particle), (ent, duration, power, particle)){
                    /effect give $ent $name $duration $power $particle
                }
            }
        }
        if (Compiler.isBedrock()){
            if (duration <= -1){
                Compiler.insert(($ent, $duration, $power, $particle), (ent, duration, power, particle)){
                    /effect $ent $name 999999 $power $particle
                }
            }
            else{
                Compiler.insert(($ent, $duration, $power, $particle), (ent, duration, power, particle)){
                    /effect $ent $name $duration $power $particle
                }
            }
        }
    }

    """
    Give effect `$name` to self for `duration` and `power`.
    Show particles if `particle`
    """
    def lazy $name(int duration = -1, int power = 0, bool particle = true){
        if (Compiler.isJava()){
            if (duration <= -1){
                Compiler.insert(($ent, $duration, $power, $particle), (@s, duration, power, particle)){
                    /effect give $ent $name infinite $power $particle
                }
            }
            else{
                Compiler.insert(($ent, $duration, $power, $particle), (@s, duration, power, particle)){
                    /effect give $ent $name $duration $power $particle
                }
            }
        }
        if (Compiler.isBedrock()){
            if (duration <= -1){
                Compiler.insert(($ent, $duration, $power, $particle), (@s, duration, power, particle)){
                    /effect $ent $name 999999 $power $particle
                }
            }
            else{
                Compiler.insert(($ent, $duration, $power, $particle), (@s, duration, power, particle)){
                    /effect $ent $name $duration $power $particle
                }
            }
        }
    }
}
forgenerate($name, (absorption, unluck, bad_omen, blindness, conduit_power, dolphins_grace, 
                fire_resistance, glowing, haste, health_boost, hero_of_the_village,
                hunger, instant_damage, instant_health, invisibility, jump_boost, levitation,
                luck, mining_fatigue, nausea, night_vision, poison, regeneration, resistance,
                saturation, slow_falling, slowness, speed, strength, water_breathing, weakness,
                wither, darkness)){
    """
    Clear effect `$name` for `ent`
    """
    def lazy clear$name(entity $ent = @s){
        if (Compiler.isJava()){
            /effect clear $ent $name
        }
        if (Compiler.isBedrock()){
            /effect $ent $name 0 0
        }
    }

    """
    Clear all effects for `ent`
    """
    def lazy clear(entity $ent = @s){
        if (Compiler.isJava()){
            /effect clear $ent
        }
        if (Compiler.isBedrock()){
            /effect $ent clear
        }
    }
}
