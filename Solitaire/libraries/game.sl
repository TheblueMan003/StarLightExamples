package game


def lazy initPlayer(void=>void function){
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
            entity inited
            with(@a not in inited,true){
                function()
                inited += @s
            }
        }
    }
}
