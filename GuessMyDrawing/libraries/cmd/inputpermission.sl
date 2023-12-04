package cmd.inputpermission

def lazy camera(bool cam, entity selector = @s)with(selector){
    if(cam){
        /inputpermission set @s camera enabled
    }
    else{
        /inputpermission set @s camera disabled
    }
}
def lazy movement(bool cam, entity selector = @s)with(selector){
    if(cam){
        /inputpermission set @s movement enabled
    }
    else{
        /inputpermission set @s movement disabled
    }
}
