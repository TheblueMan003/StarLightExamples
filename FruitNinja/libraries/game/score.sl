package game.score

import standard.int as int

"""
Sum up the value of the scoreboard of the entity in e
"""
lazy int sum(entity selector, string score){
    int c = 0
    with(selector){
        c += score
    }
    return c
}

"""
Get the min value of the scoreboard of the entity in e
"""
lazy int min(entity selector, string score){
    int c = int.maxValue
    with(selector){
        if(score < c){
            c = score
        }
    }
    return c
}

"""
Get the max value of the scoreboard of the entity in e
"""
lazy int max(entity selector, string score){
    int c = int.minValue
    with(selector){
        if(score > c){
            c = score
        }
    }
    return c
}

"""
Get the average value of the scoreboard of the entity in e
"""
lazy int avg(entity selector, string score){
    int c = 0
    int c2 = 0
    with(selector){
        c += score
        c2 ++
    }
    return c / c2
}

"""
Return the entities within `selector` that has the biggest `score`
"""
def lazy entity winner(entity selector, int score){
	entity winner
	int previous = int.minValue
	as(selector){
		if (score > previous){
			previous = score
			winner = @s
		}
		else if (score == previous){
			winner += @s
		}
	}
    return winner
}

"""
Execute `action` on the entity within `selector` that has the biggest `score`
"""
def lazy withWinner(entity selector, int score, void=>void action){
	with(selector in game.score.winner(selector, score), true){
		action()
	}
}

"""
Return the entities within `selector` that has the smallest `score`
"""
def lazy loser(entity selector, int score){
	entity winner
	int previous = int.maxValue
	as(selector){
		if (score < previous){
			previous = score
			winner = @s
		}
		else if (score == previous){
			winner += @s
		}
	}
}

"""
Execute `action` on the entity within `selector` that has the smallest `score`
"""
def lazy withLoser(entity selector, int score, void=>void action){
	with(selector in game.score.loser(selector, score), true){
		action()
	}
}

"""
Execute `action` on all entities within `selector` ordered by ascending `score`
"""
def lazy forEachOrderedAscending(entity selector, int score, void=>void action){
	entity rest = selector
	with(selector, true){
		game.score.withLoser(selector in rest, score){
			rest -= @s
			action()
		}
	}
}

"""
Execute `action` on all entities within `selector` ordered by descending `score`
"""
def lazy forEachOrderedDescending(entity selector, int score, void=>void action){
	entity rest = selector
	with(selector, true){
		game.score.withWinner(selector in rest, score){
			rest -= @s
			action()
		}
	}
}

"""
Execute `action` on all entities within `selector` ordered `score`
"""
def lazy forEachOrdered(entity selector, int score, bool ascending, void=>void action){
	if (ascending){
		game.score.forEachOrderedAscending(selector, score, action)
	}
	else{
		game.score.forEachOrderedDescending(selector, score, action)
	}
}

"""
Execute `action` on the entity that has the new highest `score` within `selector`
"""
def lazy onNewHighScore(entity selector, int score, int previous, void=>void action){
	withWinner(selector, score){
		if (score > previous){
			action()
		}
	}
}

"""
Execute `action` on the entity that has the new lowest `score` within `selector`
"""
def lazy onNewLowScore(entity selector, int score, int previous, void=>void action){
	withLoser(selector, score){
		if (score < previous){
			action()
		}
	}
}