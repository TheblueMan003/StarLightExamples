package cmd.ride

"""
Make the current entity ride `other`.
"""
def lazy ride(entity other){
    lazy var selector = Compiler.getEntitySelector(other)
    lazy var unique = Compiler.makeUnique(selector)
    if (Compiler.isJava()){
        Compiler.insert($e, unique){
            /ride @s mount $e
        }
    }
    else{
        Compiler.insert($e, unique){
            /ride @s start_riding $e
        }
    }
}

"""
Make the current entity dismount.
"""
def lazy dismount(){
    if (Compiler.isJava()){
        /ride @s dismount
    }
    else{
        /ride @s stop_riding
    }
}
