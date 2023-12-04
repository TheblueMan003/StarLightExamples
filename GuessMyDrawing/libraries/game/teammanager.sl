package game.TeamManager

import cmd.tag as tag
import standard.int as int
import random

template TeamManager{
    lazy json failled_message = ["Not enough players", "Too much players"]
    scoreboard void=>void action
    int failled
    entity players
    
    """
    Try to make team
    """
    def lazy start(entity plys){
        tag.remove(@a, "game.TeamManager.selected")
        tag.remove(@a, "game.TeamManager.possible")
        players = plys
        start()
    }

    def [compile.order=9999] start(){
        failled = 0
        @templates.onTeamMake()
        with(@a[tag=!game.TeamManager.selected] in players, true){
            failled = 2
        }
        if (failled > 0){
            onFail(failled)
        }
        else{
            @templates.onTeamMade()
            with(players, true){
                action()
            }
            onStart()
        }
    }

    def reset(){
        with(@a, true){
            tag.remove("game.TeamManager.selected")
            tag.remove("game.TeamManager.possible")
            action = null
        }
        @templates.reset()
    }

    """
    Add a team that require a exact number of player to be made. Players are selected randomly with a bias for the one that have been in the team the least.
    """
    def lazy requireProbabilityTeam(int count, void=>void fct){
        scoreboard float game
        scoreboard float inThis

        def @templates.onTeamMade(){
            with(@a,false, action == fct){
                game ++
                if (action == fct){
                    inThis ++
                }
            }
        }
        def @templates.reset(){
            with(@a){
                game = 0
                inThis = 0
            }
        }
        def [tag.order=0] @templates.onTeamMake(){
            int c = 0
            bool empty = false
            while(c < count && !empty){
                empty = true
                float maxRandom = 0
                with(@a[tag=!game.TeamManager.selected] in players, true){
                    maxRandom += inThis / game 
                }
                int rng = random.range(0,1000)
                float rng2 = rng / 1000.0
                float rng3 = rng2 * maxRandom
                bool found = false
                with(@a[tag=!game.TeamManager.selected] in players, true){
                    if (rng3 < inThis / game && !found){
                        tag.add("game.TeamManager.selected")
                        empty = false
                        c++
                        action = fct
                        found = true
                    }
                }
            }
            if (c < count){
                failled = 1
            }
        }
    }

    """
    Add a rotating team: A team that will try to take player that have the least been in it.
    """
    def lazy requireRotatingTeam(int count, void=>void fct){
        scoreboard int game
        def @templates.onTeamMade(){
            with(@a, false, action == fct){
                game ++
            }
        }
        def @templates.reset(){
            with(@a){
                game = 0
            }
        }
        def [tag.order=0] @templates.onTeamMake(){
            int c = 0
            bool empty = false
            while(c < count && !empty){
                empty = true
                int minGame = int.maxValue
                with(@a[tag=!game.TeamManager.selected] in players, true){
                    game := 0
                    if (game < minGame){
                        minGame = game
                    }
                    tag.remove("game.TeamManager.possible")
                }
                with(@a[tag=!game.TeamManager.selected] in players, true, game == minGame){
                    tag.add("game.TeamManager.possible")
                }
                while(c < count && @a[tag=game.TeamManager.possible] in players){
                    with(@r[tag=game.TeamManager.possible] in players, true){
                        tag.add("game.TeamManager.selected")
                        tag.remove("game.TeamManager.possible")
                        empty = false
                        c++
                        action = fct
                    }
                }
            }
            if (c < count){
                failled = 1
            }
        }
    }

    """
    Add a team that require a exact number of player to be made.
    """
    def lazy requireTeam(int count, void=>void fct){
        def [tag.order=0] @templates.onTeamMake(){
            int c = 0
            bool empty = false
            while(c < count && !empty){
                empty = true
                with(@r[tag=!game.TeamManager.selected] in players, true){
                    tag.add("game.TeamManager.selected")
                    empty = false
                    c++
                    action = fct
                }
            }
            if (c < count){
                failled = 1
            }
        }
    }

    """
    Add a team that require a minimum and maximum of player to be made.
    """
    def lazy requireTeam(int min, int max, void=>void fct){
        def [tag.order=1] @templates.onTeamMake(){
            int c = 0
            bool empty = false
            while(c < max && !empty){
                empty = true
                with(@r[tag=!game.TeamManager.selected] in players, true){
                    tag.add("game.TeamManager.selected")
                    empty = false
                    c++
                    action = fct
                }
            }
            if (c < min){
                failled = 1
            }
        }
    }

    """
    Add a buffer team that only have a maximum of player to be made.
    """
    def lazy possibleTeam(int max, void=>void fct){
        def [tag.order=2] @templates.onTeamMake(){
            int c = 0
            bool empty = false
            while(c < max && !empty){
                empty = true
                with(@r[tag=!game.TeamManager.selected] in players, true){
                    tag.add("game.TeamManager.selected")
                    empty = false
                    c++
                    action = fct
                }
            }
        }
    }
}
