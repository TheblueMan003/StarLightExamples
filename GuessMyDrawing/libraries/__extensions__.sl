package _

extension entity{
    def cmd.effect.absorption(entity sel) from cmd.effect as effect.absorption
    def cmd.effect.unluck(entity sel) from cmd.effect as effect.unluck
    def cmd.effect.bad_omen(entity sel) from cmd.effect as effect.bad_omen
    def cmd.effect.blindness(entity sel) from cmd.effect as effect.blindness
    def cmd.effect.conduit_power(entity sel) from cmd.effect as effect.conduit_power
    def cmd.effect.dolphins_grace(entity sel) from cmd.effect as effect.dolphins_grace
    def cmd.effect.fire_resistance(entity sel) from cmd.effect as effect.fire_resistance
    def cmd.effect.glowing(entity sel) from cmd.effect as effect.glowing
    def cmd.effect.haste(entity sel) from cmd.effect as effect.haste
    def cmd.effect.health_boost(entity sel) from cmd.effect as effect.health_boost
    def cmd.effect.hero_of_the_village(entity sel) from cmd.effect as effect.hero_of_the_village
    def cmd.effect.hunger(entity sel) from cmd.effect as effect.hunger
    def cmd.effect.instant_damage(entity sel) from cmd.effect as effect.instant_damage
    def cmd.effect.instant_health(entity sel) from cmd.effect as effect.instant_health
    def cmd.effect.invisibility(entity sel) from cmd.effect as effect.invisibility
    def cmd.effect.jump_boost(entity sel) from cmd.effect as effect.jump_boost
    def cmd.effect.levitation(entity sel) from cmd.effect as effect.levitation
    def cmd.effect.luck(entity sel) from cmd.effect as effect.luck
    def cmd.effect.mining_fatigue(entity sel) from cmd.effect as effect.mining_fatigue
    def cmd.effect.nausea(entity sel) from cmd.effect as effect.nausea
    def cmd.effect.night_vision(entity sel) from cmd.effect as effect.night_vision
    def cmd.effect.poison(entity sel) from cmd.effect as effect.poison
    def cmd.effect.regeneration(entity sel) from cmd.effect as effect.regeneration
    def cmd.effect.resistance(entity sel) from cmd.effect as effect.resistance
    def cmd.effect.saturation(entity sel) from cmd.effect as effect.saturation
    def cmd.effect.slow_falling(entity sel) from cmd.effect as effect.slow_falling
    def cmd.effect.slowness(entity sel) from cmd.effect as effect.slowness
    def cmd.effect.speed(entity sel) from cmd.effect as effect.speed
    def cmd.effect.strength(entity sel) from cmd.effect as effect.strength
    def cmd.effect.water_breathing(entity sel) from cmd.effect as effect.water_breathing
    def cmd.effect.weakness(entity sel) from cmd.effect as effect.weakness
    def cmd.effect.wither(entity sel) from cmd.effect as effect.wither
    def cmd.effect.darkness(entity sel) from cmd.effect as effect.darkness

    def cmd.effect.clearabsorption(entity sel) from cmd.effect as effect.clearabsorption
    def cmd.effect.clearunluck(entity sel) from cmd.effect as effect.clearunluck
    def cmd.effect.clearbad_omen(entity sel) from cmd.effect as effect.clearbad_omen
    def cmd.effect.clearblindness(entity sel) from cmd.effect as effect.clearblindness
    def cmd.effect.clearconduit_power(entity sel) from cmd.effect as effect.clearconduit_power
    def cmd.effect.cleardolphins_grace(entity sel) from cmd.effect as effect.cleardolphins_grace
    def cmd.effect.clearfire_resistance(entity sel) from cmd.effect as effect.clearfire_resistance
    def cmd.effect.clearglowing(entity sel) from cmd.effect as effect.clearglowing
    def cmd.effect.clearhaste(entity sel) from cmd.effect as effect.clearhaste
    def cmd.effect.clearhealth_boost(entity sel) from cmd.effect as effect.clearhealth_boost
    def cmd.effect.clearhero_of_the_village(entity sel) from cmd.effect as effect.clearhero_of_the_village
    def cmd.effect.clearhunger(entity sel) from cmd.effect as effect.clearhunger
    def cmd.effect.clearinstant_damage(entity sel) from cmd.effect as effect.clearinstant_damage
    def cmd.effect.clearinstant_health(entity sel) from cmd.effect as effect.clearinstant_health
    def cmd.effect.clearinvisibility(entity sel) from cmd.effect as effect.clearinvisibility
    def cmd.effect.clearjump_boost(entity sel) from cmd.effect as effect.clearjump_boost
    def cmd.effect.clearlevitation(entity sel) from cmd.effect as effect.clearlevitation
    def cmd.effect.clearluck(entity sel) from cmd.effect as effect.clearluck
    def cmd.effect.clearmining_fatigue(entity sel) from cmd.effect as effect.clearmining_fatigue
    def cmd.effect.clearnausea(entity sel) from cmd.effect as effect.clearnausea
    def cmd.effect.clearnight_vision(entity sel) from cmd.effect as effect.clearnight_vision
    def cmd.effect.clearpoison(entity sel) from cmd.effect as effect.clearpoison
    def cmd.effect.clearregeneration(entity sel) from cmd.effect as effect.clearregeneration
    def cmd.effect.clearresistance(entity sel) from cmd.effect as effect.clearresistance
    def cmd.effect.clearsaturation(entity sel) from cmd.effect as effect.clearsaturation
    def cmd.effect.clearslow_falling(entity sel) from cmd.effect as effect.clearslow_falling
    def cmd.effect.clearslowness(entity sel) from cmd.effect as effect.clearslowness
    def cmd.effect.clearspeed(entity sel) from cmd.effect as effect.clearspeed
    def cmd.effect.clearstrength(entity sel) from cmd.effect as effect.clearstrength
    def cmd.effect.clearwater_breathing(entity sel) from cmd.effect as effect.clearwater_breathing
    def cmd.effect.clearweakness(entity sel) from cmd.effect as effect.clearweakness
    def cmd.effect.clearwither(entity sel) from cmd.effect as effect.clearwither
    def cmd.effect.cleardarkness(entity sel) from cmd.effect as effect.cleardarkness
    def cmd.effect.clear(entity sel) from cmd.effect as effect.clear

    def cmd.entity.kill(entity sel) from cmd.entity as kill
    def cmd.entity.despawn(entity sel) from cmd.entity as despawn
    def cmd.entity.swap(entity sel, entity other) from cmd.entity as swap
    def cmd.entity.count(entity sel) from cmd.entity as count
    def game.score.sum(entity sel, int field) from game.score as sum
    def game.score.max(entity sel, int field) from game.score as max
    def game.score.min(entity sel, int field) from game.score as min
    def game.score.avg(entity sel, int field) from game.score as avg
    def entity game.score.winner(entity sel, int field) from game.score as winner
    def entity game.score.loser(entity sel, int field) from game.score as loser
    def game.score.withWinner(entity sel, int field, void=>void action) from game.score as withWinner
    def game.score.withLoser(entity sel, int field, void=>void action) from game.score as withLoser
    def game.score.forEachOrderedAscending(entity sel, int field, void=>void action) from game.score as forEachOrderedAscending
    def game.score.forEachOrderedDescending(entity sel, int field, void=>void action) from game.score as forEachOrderedDescending
    def game.score.forEachOrdered(entity sel, int field, bool ascending, void=>void action) from game.score as forEachOrdered
    def game.score.onNewHighScore(entity sel, int field, int previous, void=>void action) from game.score as onNewHighScore
    def game.score.onNewLowScore(entity sel, int field, int previous, void=>void action) from game.score as onNewLowScore
    def cmd.entity.teleport(entity sel, entity loc) from cmd.entity as teleport

    def cmd.tag.add(entity sel, string tag) from cmd.tag as tag.add
    def cmd.tag.remove(entity sel, string tag) from cmd.tag as tag.remove
    def cmd.tag.unique(entity sel, string tag) from cmd.tag as tag.unique

    def cmd.entity.ride(entity sel, entity other) from cmd.entity as ride
    def cmd.entity.exists(entity sel, bool test) from cmd.entity as exists
    def cmd.entity.forall(entity sel, bool test) from cmd.entity as forall
}

extension string{
    def int standard.string.length(string s) from standard.string as length
    def string standard.string.substring(string s, int start, int end) from standard.string as substring
    def bool standard.string.contains(string s, string other) from standard.string as contains
    def bool standard.string.startsWith(string s, string other) from standard.string as startsWith
    def bool standard.string.endsWith(string s, string other) from standard.string as endsWith
    def int standard.string.indexOf(string s, string other) from standard.string as indexOf
    def int standard.string.lastIndexOf(string s, string other) from standard.string as lastIndexOf
    def string standard.string.replace(string s, string old, string newV) from standard.string as replace
    def string standard.string.toLower(string s) from standard.string as toLower
    def string standard.string.toUpper(string s) from standard.string as toUpper
    def string standard.string.trimLeft(string s) from standard.string as trimLeft
    def string standard.string.trimRight(string s) from standard.string as trimRight
    def string standard.string.trim(string s) from standard.string as trim
    def string standard.string.reverse(string s) from standard.string as reverse
}
