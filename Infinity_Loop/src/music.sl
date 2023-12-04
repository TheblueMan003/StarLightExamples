package music

if (Compiler.isJava()){
    import game.music as m

    m.add("music1", "puzzle_1_a", 0, 57)
    m.add("music2", "puzzle_1_b", 0, 48)
    m.add("music3", "puzzle_game_2", 3, 58)
    m.add("music4", "puzzle_game_3", 2, 31)

    def play(int level){
        switch(level / 10){
            0 -> m.play("music1")
            1 -> m.play("music2")
            2 -> m.play("music3")
            3 -> m.play("music4")
        }
    }
}
if (Compiler.isBedrock()){
    def play(int a){

    }
}