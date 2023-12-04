package utils.PProcess

if (Compiler.isJava){
    import cmd.schedule as schedule
}
import standard
import utils.process_manager as pr


"""
Represent a task that run along side the main tick function.

This process will only stop if `stop` is called as many time as `start` was called.

Function to Override:
- main: Main function that is repeated as long as the process is running
- onStart: callback when the process is star. Cannot be called if the process was is running
- onStop: callback when the process is stop. Cannot be called if the process was not running
"""
template PProcess{
    int count
    int crashCount
    void=>void callback
    entity players
    
    """
    Restart the process on load. (JAVA Only)
    """
    def @load reload(){
        if (Compiler.isJava){
            run()
        }
    }

    """
    Detect maxCommandChainLength extended, and stop process if more than 10 in a row
    """
    def crash(){
        //exception.exception("Stack Overlow detect in Process. Try to increase the maxCommandChainLength")
        crashCount++
        if (crashCount > 10){
            //exception.exception("Max Number of Stack Overflow reach. Process Killed.")
            count = 0
        }
        else if (Compiler.isJava){
            run()
        }
    }

    """
    Start the process
    """
    public void start(){
        if (!(@s in players)){
            count++
            players += @s
            onJoin()
            if (count == 1){
                onStart()
                if (Compiler.isJava){
                    run()
                }
            }
        }
    }
    if (Compiler.isJava){
        """
        Main loop for the process (JAVA Only)
        """
        def @process.main run(){
            schedule.asyncwhile(count > 0){
                schedule.add(crash)
                if (count > 0){
                    beforAll()
                    with(@a in players, true){
                        main()
                    }
                    afterAll()
                }
                schedule.remove(crash)
                crashCount = 0
            }
        }
    }

    if (Compiler.isBedrock){
        bool crashDetect
        """
        Main loop for the process (Bedrock Only)
        """
        def @tick mainLoop(){
            if (count > 0){
                if (crashDetect){
                    crash()
                }
                crashDetect = true
                beforAll()
                with(@a in players, true){
                    main()
                }
                afterAll()
                crashDetect = false
            }
        }
    }

    """
    Stop the process
    """
    public void stop(){
        if (@s in players){
            players -= @s
            onLeave()
            if (count > 0){
                count--
            }
            if (count == 0){
                onStop()
                callback()
                callback = null
            }
        }
    }

    """
    Add a callback for when the process stop
    """
    def waitFor(void=>void fct){
        callback = fct
    }

    """
    Count the number of active process
    """
    def @process.count __count__(){
        pr.t_total += 1
        if (count > 0){
            pr.t_running += 1
        }
    }

    """
    Stop the process
    """
    def @process.stop stopall(){
        count = 0
        players -= @s
    }

    def virtual onStop(){
    }
    def virtual onStart(){
    }
    def virtual onJoin(){
    }
    def virtual onLeave(){
    }
    def virtual beforAll(){
    }
    def virtual afterAll(){
    }
}
