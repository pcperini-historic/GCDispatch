#GCDispatch#

Inherits From:    NSObject

Declared In:      GCDispatch.h

##Overview##

The `GCDispatch` class provides a simple interface for performing blocks using Grand Central Dispatch queues.

To use this class, simply run the method most applicable to your concurrency needs.

##Tasks##

###Performing Tasks on the Main Queue###
    + performBlockInMainQueue:
    + performBlockInMainQueue:completion:
    + performBlocksInMainQueue:
    + performBlocksInMainQueue:completion:

###Performing Tasks on the Background Queue###
    + performBlockInBackgroundQueue:
    + performBlockInBackgroundQueue:completion:
    + performBlocksInBackgroundQueue:
    + performBlocksInBackgroundQueue:completion:
    
###Running Tasks after Delay###
    + performBlock:inMainQueueAfterDelay:
    + performBlock:inQueue:afterDelay:
    
###Running Tasks Repeatedly###
    + performBlock:inMainQueueNumberOfTimes:
    + performBlock:inQueue:numberOfTimes:

###Running Tasks Once ###
    + performBlockOnce:inMainQueueWithToken:
    
###Running Tasks by Condition###
    + performBlock:inMainQueueWhen:
    + performBlock:inQueue:when:

##`typedefs`##

    typedef size_t GCDispatchIteration;

> Used to indicate the current iteration in `GCDispatchIterativeBlock`s.

    typedef dispatch_once_t GCDispatchOnceToken;
    
> Used to determine if work has been performed before.

    typedef void(^GCDispatchBlock)();
    
> A `void`-returning block that takes no parameters.

    typedef void(^GCDispatchIterativeBlock)(GCDispatchIteration currentIteration);
    
> A `void`-returning block that takes a `GCDispatchIteration` representing the current iteration.

    typedef _Bool(^GCDispatchConditionalBlock)();
    
> A block that takes no parameters are returns either a truthy or falsey value.

##Class Methods##

**performBlockInMainQueue:**

> Submits the given block for executing on the main queue and returns immediately.

    + (void)performBlockInMainQueue:(GCDispatchBlock)block;

>*Parameters:*

>`block`

>>The block to execute on the main queue.

**performBlockInMainQueue:completion:**

> Submits the given block for executing on the main queue and returns immediately.

    + (void)performBlockInMainQueue:(GCDispatchBlock)block completion:(GCDispatchBlock)completion;
    
>*Parameters:*

>`block`

>>The block to execute on the main queue.

>`completion`

>>The block to execute on the main queue when `block` has completed.

**performBlocksInMainQueue:**

> Submits the given blocks for executing, in sequence, on the main queue and returns immediately.

    + (void)performBlocksInMainQueue:(NSArray *)blocks;
    
>*Parameters:*

>`blocks`

>>The blocks to execute on the main queue.

**performBlocksInMainQueue:completion:**

> Submits the given blocks for executing, in sequence, on the main queue and returns immediately.

    + (void)performBlocksInMainQueue:(NSArray *)blocks completion:(GCDispatchBlock)completion;
    
>*Parameters:*

>`blocks`

>>The blocks to execute on the main queue.

>`completion`

>>The block to execute on the main queue when `block` has completed.

**performBlockInBackgroundQueue:**

> Submits the given block for executing on a background queue and returns immediately.

    + (void)performBlockInBackgroundQueue:(GCDispatchBlock)block;

>*Parameters:*

>`block`

>>The block to execute on a background queue.

**performBlockInBackgroundQueue:completion:**

> Submits the given block for executing on the background queue and returns immediately.

    + (void)performBlockInBackgroundQueue:(GCDispatchBlock)block completion:(GCDispatchBlock)completion;
    
>*Parameters:*

>`block`

>>The block to execute on the background queue.

>`completion`

>>The block to execute on the main queue when `block` has completed.

**performBlocksInBackgroundQueue:**

> Submits the given blocks for executing, in sequence, on the background queue and returns immediately.

    + (void)performBlocksInBackgroundQueue:(NSArray *)blocks;
    
>*Parameters:*

>`blocks`

>>The blocks to execute on the main queue.

**performBlocksInBackgroundQueue:completion:**

> Submits the given blocks for executing, in sequence, on the background queue and returns immediately.

    + (void)performBlocksInBackgroundQueue:(NSArray *)blocks completion:(GCDispatchBlock)completion;
    
>*Parameters:*

>`blocks`

>>The blocks to execute on the background queue.

>`completion`

>>The block to execute on the main queue when `block` has completed.

**performBlock:inMainQueueAfterDelay:**

    + (void)performBlock:(GCDispatchBlock)block inMainQueueAfterDelay:(NSTimeInterval)delay;

> Executes a block on the main queue after the specified time.

>*Parameters:*

>`block`

>>The block to execute on the main queue.

>`delay`

>>The amount of time in seconds to wait before executing the given block.

**performBlock:inQueue:afterDelay:**

    + (void)performBlock:(GCDispatchBlock)block inQueue:(GCDispatchQueue *)queue afterDelay:(NSTimeInterval)delay;

> Executes a block on the given queue after the specified time.

>*Parameters:*

>`block`

>>The block to execute on the given queue.

>`delay`

>>The amount of time in seconds to wait before executing the given block.

>`queue`

>>A `GCDispatchQueue` object representing the desired `dispatch_queue` on which to run the given block.

**performBlock:inMainQueueNumberOfTimes:**

    + (void)performBlock:(GCDispatchIterativeBlock)block inMainQueueNumberOfTimes:(NSInteger)times;
    
> Executes a block on the main queue the specified number of times.

>*Parameters:*

>`block`

>>The block to execute on the main queue.

>`times`

>>The number of times to execute the block.

>*Discussion:*

>>The `GCDispatchIteration` block parameter, `currentIteration`, represents the number of times this block has been run so far.

**performBlock:inQueue:numberOfTimes:**

    + (void)performBlock:(GCDispatchIterativeBlock)block inQueue:(GCDispatchQueue *)queue numberOfTimes:(NSInteger)times;
    
> Executes a block on the main queue the specified number of times.

>*Parameters:*

>`block`

>>The block to execute on the main queue.

>`times`

>>The number of times to execute the block.

>`queue`

>>A `GCDispatchQueue` object representing the desired `dispatch_queue` on which to run the given block.

>*Discussion:*

>>The `GCDispatchIteration` block parameter, `currentIteration`, represents the number of times this block has been run so far.

**performBlockOnce:inMainQueueWithToken:**

    + (void)performBlockOnce:(GCDispatchBlock)block inMainQueueWithToken:(GCDispatchOnceToken)token;
    
> Executes a block on the main queue exactly once.

>*Parameters:*

>`block`

>>The block to execute on the main queue.

>`token`

>>The `static GCDispatchOnceToken` token used to determine whether or not this block has run before.

**performBlock:inMainQueueWhen:**

    + (void)performBlock:(GCDispatchBlock)block inMainQueueWhen:(GCDispatchConditionalBlock)conditionalBlock;
    
> Executes a block when the given conditional block returns truthfully.

>*Parameters:*

>`block`

>>The block to execute on the main queue.

>`conditionalBlock`

>>The block that, when it returns a truthy value, causes the execution of the given block.

**performBlock:inQueue:when:**

    + (void)performBlock:(GCDispatchBlock)block when:(GCDispatchConditionalBlcok)conditionalBlock inQueue:(GCDispatchQueue *)queue;
    
> Executes a block when the given conditional block returns truthfully.

>*Parameters:*

>`block`

>>The block to execute on the main queue.

>`conditionalBlock`

>>The block that, when it returns a truthy value, causes the execution of the given block.

>`queue`

>>A `GCDispatchQueue` object representing the desired `dispatch_queue` on which to run the given block.


#GCDispatchQueue#

Inherits From:    NSObject

Declared In:      GCDispatchQueue.h

##Overview##

The `GCDispatchQueue` class provides a wrapper around Grand Central Dispatch queues, as well as a means of performing blocks on said queues.

##Tasks##

###Creating Queues###
    - initWithLabel:
    - initWithLabel:andConcurrency:
    
###Accessing Singletons###
    + mainQueue
    + backgroundQueue

###Managing Properties###
    label (property)
    
###Determining the Current State###
    + currentQueueIsMainQueue
    
###Performing Actions###
    - performBlock:
    - performBlock:completion:
    - performBlocks:
    - performBlocks:completion:

##Class Methods##

**mainQueue**

> A `GCDispatchQueue` object representing the global `main_queue`.

    + (GCDispatchQueue *)mainQueue;

>*Returns:*

>>A `GCDispatchQueue` object representing the global `main_queue`.

**backgroundQueue**

> A `GCDispatchQueue` object representing a `dispatch_queue` with `DISPATCH_QUEUE_PRIORITY_BACKGROUND`.

    + (GCDispatchQueue *)backgroundQueue;
    
>*Returns:*

>> A `GCDispatchQueue` object representing a `dispatch_queue` with `DISPATCH_QUEUE_PRIORITY_BACKGROUND`.

**currentQueueIsMainQueue**

> Returns `YES` if the current queue is the main queue.

    + (BOOL)currentQueueIsMainQueue;
    
>*Returns:*

>> `YES` if the current queue is the main queue.

##Properties##

**label**

    @property NSString *label;
    
> An `NSString` label used in identifying the `GCDispatchQueue`.

##Instance Methods##

**initWithLabel:**

    - (id)initWithLabel:(NSString *)label;

> Initializes and returns a `GCDispatchQueue` object with the given label and `GCDispatchSerialQueue` concurrency.

>*Parameters:*

>`label`

>>The `NSString` label used to identify this `GCDispatchQueue`.

>*Returns:*

>>A `GCDispatchQueue` object with the given label and `GCDispatchSerialQueue` concurrency.

**initWithLabel:andConcurrency:**

    - (id)initWithLabel(NSString *)label andConcurrency:(GCDispatchQueueConcurrency)concurrency;

> Initializes and returns a `GCDispatchQueue` object with the given label and concurrency.

>*Parameters:*

>`label`

>>The `NSString` label used to indentify this `GCDispatchQueue`.

>`concurrency`

>>A `GCDispatchQueueConcurrency`.

>*Returns:*

>>a `GCDispatchQueue` object with the given label and concurrency.

**performBlock:**

    - (void)performBlock:(GCDispatchBlock)block;
    
> Performs the given block on this queue.

>*Parameters:*

>`block`

>>The block to perform on this queue.

**performBlock:completion:**

    - (void)performBlock:(GCDispatchBlock)block completion:(GCDispatchBlock)completion;
    
> Performs the given block on this queue.

>*Parameters:*

>`block`

>>The block to perform on this queue.

>`completion`

>>The block to execute on the main queue when `block` has completed.

**performBlocks:**

    - (void)performBlock:(NSArray *)blocks;
    
> Performs the given blocks, in sequence, on this queue.

>*Parameters:*

>`blocks`

>>The blocks to perform on this queue.

**performBlocks:completion:**

    - (void)performBlock:(NSArray *)blocks completion:(GCDispatchBlock)completion;
    
> Performs the given blocks, in sequence, on this queue.

>*Parameters:*

>`blocks`

>>The blocks to perform on this queue.

>`completion`

>>The block to execute on the main queue when `blocks` have completed.

##Constants##

**GCDispatchQueueConcurrency**

> The battery power state of the device

    typedef enum
    {
        GCDispatchSerialQueue,
        GCDispatchConcurrentQueue
    } GCDispatchQueueConcurrency;
    
>*Discussion:*

>> Queues with concurrency `GCDispatchSerialQueue` execute a single task at a time, whereas queues with `GCDispatchConcurrentQueue` concurrency execute multiple tasks at a time.

#License#

License Agreement for Source Code provided by Patrick Perini

This software is supplied to you by Patrick Perini in consideration of your agreement to the following terms, and your use, installation, modification or redistribution of this software constitutes acceptance of these terms. If you do not agree with these terms, please do not use, install, modify or redistribute this software.

In consideration of your agreement to abide by the following terms, and subject to these terms, Patrick Perini grants you a personal, non-exclusive license, to use, reproduce, modify and redistribute the software, with or without modifications, in source and/or binary forms; provided that if you redistribute the software in its entirety and without modifications, you must retain this notice and the following text and disclaimers in all such redistributions of the software, and that in all cases attribution of Patrick Perini as the original author of the source code shall be included in all such resulting software products or distributions. Neither the name, trademarks, service marks or logos of Patrick Perini may be used to endorse or promote products derived from the software without specific prior written permission from Patrick Perini. Except as expressly stated in this notice, no other rights or licenses, express or implied, are granted by Patrick Perini herein, including but not limited to any patent rights that may be infringed by your derivative works or by other works in which the software may be incorporated.

The software is provided by Patrick Perini on an "AS IS" basis. Patrick Perini MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, REGARDING THE SOFTWARE OR ITS USE AND OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.

IN NO EVENT SHALL Patrick Perini BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION, MODIFICATION AND/OR DISTRIBUTION OF THE SOFTWARE, HOWEVER CAUSED AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE), STRICT LIABILITY OR OTHERWISE, EVEN IF Patrick Perini HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.