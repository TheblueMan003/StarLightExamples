package cmd.gamemode

"""
return true if the gamemode of the current entity is `adventure`
"""
def lazy bool isAdventure(){
    return @s[gamemode=adventure]
}
"""
return true if the gamemode of the current entity is `survival`
"""
def lazy bool isSurvival(){
    return @s[gamemode=survival]
}
"""
return true if the gamemode of the current entity is `creative`
"""
def lazy bool isCreative(){
    return @s[gamemode=creative]
}
"""
return true if the gamemode of the current entity is `spectator`
"""
def lazy bool isSpectator(){
    return @s[gamemode=spectator]
}


enum Gamemode{
    Survival,
    Creative,
    Adventure,
    Spectator
}
def [noReturnCheck=true] Gamemode get(){
    if (isSurvival()){
        return Gamemode.Survival
    }
    if (isCreative()){
        return Gamemode.Creative
    }
    if (isAdventure()){
        return Gamemode.Adventure
    }
    if (isSpectator()){
        return Gamemode.Spectator
    }
}

"""
Set the gamemode to `adventure` for entity `e`
"""
def lazy adventure(entity e = @s){
    with(e)./gamemode adventure
}
"""
Set the gamemode to `survival` for entity `e`
"""
def lazy survival(entity e = @s){
    with(e)./gamemode survival
}
"""
Set the gamemode to `creative` for entity `e`
"""
def lazy creative(entity e = @s){
    with(e)./gamemode creative
}
"""
Set the gamemode to `spectator` for entity `e`
"""
def lazy spectator(entity e = @s){
    with(e)./gamemode spectator
}

"""
Set the gamemode to `gamemode` for entity `e`
"""
def macro set(mcobject gamemode, entity e = @s){
	with(e)./gamemode $(gamemode)
}

"""
Set the gamemode to `gamemode` for entity `e`
"""
def lazy set(int gamemode, entity e = @s){
	if (gamemode == 0){
		with(e)./gamemode survival
	}
	else if (gamemode == 1){
		with(e)./gamemode creative
	}
	else if (gamemode == 2){
		with(e)./gamemode adventure
	}
	else if (gamemode == 3){
		with(e)./gamemode spectator
	}
}
