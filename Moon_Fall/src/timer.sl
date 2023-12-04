package timer

import utils.Process
import maps.theblueman003.leaderboard as ldb
Process main{
    int time
    bool paused
    def onStop(){
        with(@a)ldb.submit("moon_fall", time, 97)
    }
    def main(){
        if (!paused){
            time++
        }
    }
    def onStart(){
        time = 0
        paused = true
    }
    def pause(){
        paused = true
    }
    def resume(){
        paused = false
    }
}