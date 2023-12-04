package cmd.score

"""
Show the scoreboard on the list
"""
lazy void showList(int score, rawjson display){
    lazy val name = Compiler.getObjective(score)
    Compiler.insert(($name, $display), (name, display)){
        if (Compiler.isJava()){
            /scoreboard objectives setdisplay list $name
            /scoreboard objectives modify $name displayname $display
        }
        if (Compiler.isBedrock()){
            /scoreboard objectives setdisplay list $name $display
        }
    }
}

"""
Show the scoreboard on the sidebar
"""
lazy void showSidebar(int score, rawjson display){
    lazy val name = Compiler.getObjective(score)
    Compiler.insert(($name, $display), (name, display)){
        if (Compiler.isJava()){
            /scoreboard objectives setdisplay sidebar $name
            /scoreboard objectives modify $name displayname $display
        }
        if (Compiler.isBedrock()){
            /scoreboard objectives setdisplay sidebar $name $display
        }
    }
}

"""
Show the scoreboard on the belowname
"""
lazy void showBelowname(int score, rawjson display){
    lazy val name = Compiler.getObjective(score)
    Compiler.insert(($name, $display), (name, display)){
        if (Compiler.isJava()){
            /scoreboard objectives setdisplay belowname $name
            /scoreboard objectives modify $name displayname $display
        }
        if (Compiler.isBedrock()){
            /scoreboard objectives setdisplay belowname $name $display
        }
    }
}

"""
Show the scoreboard on the sidebar of team of color `color`
"""
lazy void showTeamSidebar(int score, string color, rawjson display){
    lazy val name = Compiler.getObjective(score)
    Compiler.insert(($name, $color, $display), (name, color, display)){
        if (Compiler.isJava()){
            /scoreboard objectives setdisplay sidebar.team.$color $name
            /scoreboard objectives modify $name displayname $display
        }
    }
}

"""
Hide the scoreboard on the list
"""
lazy void hideList(){
    /scoreboard objectives setdisplay list
}

"""
Hide the scoreboard on the sidebar
"""
lazy void hideSidebar(){
    /scoreboard objectives setdisplay sidebar
}

"""
Hide the scoreboard on the belowname
"""
lazy void hideBelowname(){
    /scoreboard objectives setdisplay belowname
}

"""
Hide the scoreboard on the sidebar of team of color `color`
"""
lazy void hideTeamSidebar(string $color){
    /scoreboard objectives setdisplay sidebar.team.$color
}
