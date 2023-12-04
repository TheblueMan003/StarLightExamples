package music

import game.music as m

if (Compiler.isJava()){
    m.add("track0", "track_0", 1, 10)
    m.add("track1", "track_1", 1, 49)
    m.add("track2", "track_2", 2, 12)

    def play(){
        switch(random.range(3)){
            0 -> m.play("track0")
            1 -> m.play("track1")
            2 -> m.play("track2")
        }
    }
    def stop(){
        m.stop()
    }
}
if (Compiler.isBedrock()){
    def play(){

    }
}