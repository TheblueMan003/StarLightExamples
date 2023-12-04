package maps.theblueman003.leaderboard

def submit(string name, int time, int key){
    def macro inner(string name, int score){
        /tellraw @s ["",{"text":"-> Click here to submit your score! <-","bold":true,"color":"yellow","clickEvent":{"action":"open_url","value":"http://theblueman003.com/lb/submit.php?map=$(name)&score=$(score)"}}]
    }
    int score = ((key + 1) - (time * 100)%key) + time*100
    inner(name, score)
}
