package game

"""
Initialze the player, by running the function only once.
"""
def lazy initPlayer(void=>void function){
    if (Compiler.isBedrock()){
        entity inited
    }
    def ticking init(){
        if (Compiler.isJava()){
            scoreboard bool inited
            with(@a,true,inited==null){
                /recipe take @s *
                function()
                inited = true
            }
        }
        if (Compiler.isBedrock()){
            with(@a not in inited,true){
                function()
                inited += @s
            }
        }
    }
}
