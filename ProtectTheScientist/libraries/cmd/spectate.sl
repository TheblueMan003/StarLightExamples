package cmd.spectate

def lazy spectate(entity other){
    lazy var selector = Compiler.getEntitySelector(other)
    lazy var unique = Compiler.makeUnique(selector)
    Compiler.insert($e, unique){
        /spectate $e
    }
}