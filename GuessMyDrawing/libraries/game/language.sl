package game.language

int language
lazy json languagesIndex = {}
lazy json languagesName = []

def setLanguage(int lang) {
    language = lang
}
def lazy setLanguage(string name) {
    language = languagesIndex[name]
}
def lazy addLanguage(string name) {
    languagesIndex[name] = Compiler.length(languagesIndex)
    languagesName += name
}
def lazy int getLanguageIndex(string name) {
    return languages[name]
}
def lazy string getLanguageName(int index) {
    return languagesName[index]
}
def lazy json selectByLanguage(json data) {
    return data[language]
}
def lazy json selectByLanguage(json data, string key) {
    lazy var obj = data[language]
    return obj[key]
}
def lazy forEach(json data, json=>void func) {
    lazy int count = Compiler.length(languagesName)-1
    foreach(lang in 0..count) {
        if (language == lang) {
            func(data[languagesName[lang]])
        }
    }
}

def lazy print(json data, string key){
    import standard::print
    lazy int count = Compiler.length(languagesName)-1
    switch(language){
        foreach(lang in 0..count){
            lang -> {
                print(data[languagesName[lang]][key])
            }
        }
    }
}
def lazy showTitle(json data, int priority, int timein, int time, int timeout, string key){
    import cmd.title as title
    lazy int count = Compiler.length(languagesName)-1
    switch(language){
        foreach(lang in 0..count){
            lang -> title.show(priority, timein, time, timeout, data[languagesName[lang]][key])
        }
    }
}
def lazy showTitle(json data, string key){
    import cmd.title as title
    lazy int count = Compiler.length(languagesName)-1
    switch(language){
        foreach(lang in 0..count){
            lang -> title.force(data[languagesName[lang]][key])
        }
    }
}
def lazy showSubtitle(json data, int priority, int timein, int time, int timeout, string key){
    import cmd.title as title
    lazy int count = Compiler.length(languagesName)-1
    switch(language){
        foreach(lang in 0..count){
            lang -> title.showSubtitle(data[languagesName[lang]][key])
        }
    }
}
def lazy showActionbar(json data, int priority, int time, string key){
    import cmd.actionbar as actionbar
    lazy int count = Compiler.length(languagesName)-1
    switch(language){
        foreach(lang in 0..count){
            lang -> actionbar.show(priority, time, data[languagesName[lang]][key])
        }
    }
}