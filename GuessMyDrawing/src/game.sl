package game

import game.TeamManager
import cmd.entity as entity
import cmd.score as score

import utils.Process
import game.language as lang

Process singlePlayer{
    def main(){
        if (entity.count(@a) >= 2){
            stop()
            game.stop()
        }
    }
}

TeamManager team{
    requireRotatingTeam(1){
        painter.setDrawer()
    }
    requireTeam(1, int.maxValue){
        word.setSeeker()
    }
    def onFail(int msg){
        lang.print(text.text, "free_mod")
        softStop()
        with(@a,true){
            painter.setDrawer()
        }
        singlePlayer.start()
        score.hideSidebar()
    }
    def onStart(){

    }
}

int roundCount
int roundLimit

def nextRound(){
    roundCount++
    if(roundCount > roundLimit){
        stop()
        word.showLeaderboard()
    }
    else{
        @game.nextRound()
        team.start(@a)
    }
}
def start(){
    roundCount = 0
    roundLimit = entity.count(@a)
    if (roundLimit < 5){
        roundLimit *= 3
    }
    team.reset()
    @game.start()
    nextRound()
}
def softStop(){
    @game.stop()
    team.reset()
    word.stop()
    painter.stop()
}
def stop(){
    softStop()
    with(@a,true){
        hub.join()
    }
}