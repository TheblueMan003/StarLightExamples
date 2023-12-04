package mc.java.resourcespack.models

lazy var overrides = {}

"""
Add custom `model` to `item` with CustomModelData = `index`
"""
public lazy void add(mcobject item, string model, int index){
    lazy val name = Compiler.getNamespaceName(item)
    overrides[name] += [{"predicate": {"custom_model_data": index},"model": model}]
}

"""
Add custom `model` to `item` with incremental CustomModelData
"""
public lazy int add(mcobject item, string model){
    lazy int index = 1
    lazy val name = Compiler.getNamespaceName(item)
    if (name in overrides){
        index = Compiler.length(overrides[name]) 
        index += 1
    }
    overrides[name] += [{"predicate": {"custom_model_data": index},"model": model}]
    return index
}

private lazy void generate(string name){
    lazy val data = overrides[name]
    Compiler.insert($item, name){
        [java_rp=true] jsonfile models.item.$item{
            "parent": "item/generated",
            "textures": {
                "layer0": "item/$item"
            },
            "overrides": data
        }
    }
}

[compile.order=99999999]
private void generate(){
    foreach(item in overrides){
        generate(item)
    }
}

"""
Generate `item` model with custom models
Take a list of pairs (model, index)
"""
public lazy void make(mcobject item, params models){
    foreach(values in models){
        lazy int model, index = values
        add(item, model, index)
    }
    generate(item)
}

"""
Generate a flat item model with `sprite` as texture
"""
public lazy string flat(string name, string sprite){
    Compiler.insert($name, name){
        [java_rp=true] jsonfile models.item.$name{
            "parent": "item/generated",
            "textures": {
                "layer0": sprite
            }
        }
    }
    return "item/" + name
}
