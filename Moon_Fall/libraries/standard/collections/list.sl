package standard.collections.List

struct List<V>{
    json data
    int length

    def this(){
        this.data = []
        this.length = 0
    }

    def macro V get(int key){
        return this.data["[$(key)]"]
    }

    def lazy V __get__(int key){
        return get(key)
    }

    def set(int key, V value){
        def macro inner(int a){
            this.data["[$(a)]"] = value
        }
        inner(key)
    }

    def lazy __set__(int key, V value){
        set(key, value)
    }

    def add(V value){
        this.data >:= value
        this.length += 1
    }
    
    if (Compiler.isEqualitySupported<V>()){
        def remove(V value){
            json tmp = []
            int l2 = 0
            for(int i = 0; i < this.length; i++){
                V v = get(i) 
                if(v != value){
                    tmp >:= v
                    l2 += 1
                }
            }

            this.data = tmp
            this.length = l2
        }
    }

    def removeAt(int index){
        json tmp = []
        int l2 = 0
        for(int i = 0; i < this.length; i++){
            V v = get(i) 
            if(i != index){
                tmp >:= v
                l2 += 1
            }
        }

        this.data = tmp
        this.length = l2
    }

    if (Compiler.isEqualitySupported<V>()){
        def removeAll(V=>bool pred){
            json tmp = []
            int l2 = 0
            for(int i = 0; i < this.length; i++){
                V v = get(i) 
                if(!pred(v)){
                    tmp >:= v
                    l2 += 1
                }
            }

            this.data = tmp
            this.length = l2
        }
    }

    if (Compiler.isEqualitySupported<V>()){
        bool contains(V value){
            bool ret = false
            for(int i = 0; i < this.length && !ret; i++){
                if(get(i) == value){
                    ret = true
                }
            }
            return ret
        }
    }

    int size(){
        return this.length
    }

    if (Compiler.isEqualitySupported<V>()){
        int indexOf(V value){
            int ret = -1
            for(int i = 0; i < this.length && ret == -1; i++){
                if(get(i) == value){
                    ret = i
                }
            }
            return ret
        }
    }

    def clear(){
        this.data = []
        this.length = 0
    }
}
