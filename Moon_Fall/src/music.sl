package music

import game.music as m

m.add("autumn", "autumn", 1, 07)
m.add("cat", "cat", 0, 47)
m.add("city", "city", 2, 50)
m.add("dog", "dog", 2, 03)
m.add("owl", "owl", 1, 38)

def play(int level){
    switch(level){
        1..3 -> with(@a,true)m.play("city")
        4..6 -> with(@a,true)m.play("cat")
        7..9 -> with(@a,true)m.play("owl")
        10..12 -> with(@a,true)m.play("dog")
        13..15 -> with(@a,true)m.play("autumn")
    }
}
def stop(){
    with(@a,true)m.stop()
}