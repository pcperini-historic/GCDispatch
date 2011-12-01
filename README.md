#GCD#



Inherits From:    NSObject

Declared In:      GCD.h


##Overview##

The `GCD` class provides a simple interface for utilizing several of the Grand Central Dispatch functions.

To use this class, simply run the method most applicable to your concurrency needs. 

##Tasks##

###Running Tasks by Queue###
    + doInBackground:
    + doInForeground:
    
###Running Tasks by Condition####
    + doInForeground:after:
    + doInForeground:when:

###Flow Control###
    sync


##Class Methods##

**doInBackground:**

>Submits the given block for asynchronous execution and returns immediately.

        + (void)doInBackground:(void (^)(void))block

>*Parameters:*

>`block`

>>The block to execute asynchronously. This function performs `Block_copy` and `Block_release` on behalf of callers.

**doInForeground:**

>Submits the given block for synchronous execution on the main thread.

        + (void)doInForeground:(void (^)(void))block

>*Parameters:*

>`block`

>>The block to execute synchronously. This function performs `Block_copy` and `Block_release` on behalf of callers.

**doInForeground:after:**

>Executes a block on the main thread after the specified time.

        + (void)doInForeground:(void (^)(void))block after:(NSTimeInterval)interval

>*Parameters:*

>`block`

>>The block to execute synchronously. This function performs `Block_copy` and `Block_release` on behalf of callers.

>`interval`

>>The amount of time in seconds to wait before executing the given block.

**doInForeground:when:**

>Executes a block on the main thread when the specified condition becomes true.

        + (void)doInForeground:(void (^)(void))block when:(_Bool)condition

>*Parameters:*

>`block`

>>The block to execute synchronously. This function performs `Block_copy` and `Block_release` on behalf of callers.

>`condition`

>>The condition to wait for prior to executing the given block.

##Macros##

**sync**

>Terminates the current function based on the value of the given semaphore.

        sync(semaphore)

>*Parameters:*

>`semaphore`

>>The value used to determine whether the currently-executing function should terminate.