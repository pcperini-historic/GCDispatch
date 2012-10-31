#GCDispatch#

Inherits From:    NSObject

Declared In:      GCDispatch.h

##Overview##

The `GCDispatch` class provides a simple interface for performing blocks using Grand Central Dispatch queues.

To use this class, simply run the method most applicable to your concurrency needs.

##Tasks##

###Running Tasks by Queue###
    + performBlockInForeground:
    + performBlockInBackground:
    
###Running Tasks after Delay###
    + performBlock:afterDelay:
    + performBlock:afterDelay:inQueue:
    
###Running Tasks Repeatedly###
    + performBlock:numberOfTimes:
    + performBlock:numberOfTimes:inQueue:

###Running Tasks Once ###
    + performBlockOnce:withToken:
    
###Running Tasks by Condition###
    + performBlock:when:
    + performBlock:when:inQueue:    

##Class Methods##

**performBlockInForeground:**

> Submits the given block for executing on the main queue and returns immediately.

    + (void)performBlockInForeground:(void(^)())block;

>*Parameters:*

>`block`

>>The block to execute on the main queue.

**performBlockInBackground:**

> Submits the given block for executing on a background queue and returns immediately.

    + (void)performBlockInBackground:(void(^)())block;

>*Parameters:*

>`block`

>>The block to execute on a background queue.

**performBlock:afterDelay:**

    + (void)performBlock:(void(^)())block afterDelay:(NSTimeInterval)delay;

> Executes a block on the main queue after the specified time.

>*Parameters:*

>`block`

>>The block to execute on the main queue.

>`delay`

>>The amount of time in seconds to wait before executing the given block.

**performBlock:afterDelay:inQueue:**

    + (void)performBlock:(void(^)())block afterDelay:(NSTimeInterval)delay inQueue:(GCDispatchQueue *)queue;

> Executes a block on the given queue after the specified time.

>*Parameters:*

>`block`

>>The block to execute on the given queue.

>`delay`

>>The amount of time in seconds to wait before executing the given block.

>`queue`

>>A `GCDispatchQueue` object representing the desired `dispatch_queue` on which to run the given block.

**performBlock:numberOfTimes:**

    + (void)performBlock:(void(^)(size_t currentIteration))block numberOfTimes:(NSInteger)times;
    
> Executes a block on the main queue the specified number of times.

>*Parameters:*

>`block`

>>The block to execute on the main queue.

>`times`

>>The number of times to execute the block.

>*Discussion:*

>>The `size_t` block parameter, `currentIteration`, represents the number of times this block has been run so far.


**performBlock:numberOfTimes:inQueue:**

    + (void)performBlock:(void(^)(size_t currentIteration))block numberOfTimes:(NSInteger)times inQueue:(GCDispatchQueue *)queue;
    
> Executes a block on the main queue the specified number of times.

>*Parameters:*

>`block`

>>The block to execute on the main queue.

>`times`

>>The number of times to execute the block.

>`queue`

>>A `GCDispatchQueue` object representing the desired `dispatch_queue` on which to run the given block.

>*Discussion:*

>>The `size_t` block parameter, `currentIteration`, represents the number of times this block has been run so far.

**performBlockOnce:withToken:**

    + (void)performBlockOnce:(void(^)())block withToken:(dispatch_once_t)token;
    
> Executes a block on the main queue exactly once.

>*Parameters:*

>`block`

>>The block to execute on the main queue.

>`token`

>>The `static dispatch_once_t` token used to determine whether or not this block has run before.

**performBlock:when:**

    + (void)performBlock:(void(^)())block when:(_Bool(^)())conditionalBlock;
    
> Executes a block when the given conditional block returns truthfully.

>*Parameters:*

>`block`

>>The block to execute on the main queue.

>`conditionalBlock`

>>The block that, when it returns a truthy value, causes the execution of the given block.

**performBlock:when:inQueue:**

    + (void)performBlock:(void(^)())block when:(_Bool(^)())conditionalBlock inQueue:(GCDispatchQueue *)queue;
    
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
    + currentQueue
    
###Performing Actions###
    - performBlock:
    - performSelector:onTarget:
    - performBlock:synchronously:
    - performSelector:onTarget:synchronously:

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

**currentQueue**

> A `GCDispatchQueue` object representing the queue on which the code is currently running.

    + (GCDispatchQueue *)currentQueue;
    
>*Returns:*

>> A `GCDispatchQueue` object representing the queue on which the code is currently running.

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

    - (void)performBlock:(void(^)())block;
    
> Performs the given block on this queue asynchronously.

>*Parameters:*

>`block`

>>The block to perform on this queue.

**performSelector:onTarget:**

    - (void)performSelector:(SEL)selector onTarget:(id)target;
    
> Performs the given selector on the given target on this queue asynchronously.

>*Parameters:*

>`selector`

>>The selector to perform.

>`target`

>>The target on which to perform the given selector.

**performBlock:synchronously:**

    - (void)performBlock(void(^)())block synchronously:(BOOL)synchronously;

> Performs the given block on this queue with the given synchronicity.

>*Parameters:*

>`block`

>>The block to perform on this queue.

>`synchronously`

>>The synchronicty with which to run the given block.

**performSelector:onTarget:synchronously:**

    - (void)performSelector:(SEL)selector onTarget:(id)target synchronously:(BOOL)synchronously;
    
> Performs the given selector on the given target on this queue synchronously.

>*Parameters:*

>`selector`

>>The selector to perform.

>`target`

>>The target on which to perform the given selector.

>`synchronously`

>>The synchronicity with which to run the given block.

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


#GCDispatchGroup#

Inherits From:    NSObject

Declared In:      GCDispatchGroup.h

##Overview##

`GCDispatchGroup` provides a means of managing flow control for `GCDispatchQueue` objects. Dispatch groups can add completion blocks and timeouts to queues.

##Tasks##

###Adding Actions###
    - addBlock:inQueue:
    - addSelector:forTarget:inQueue:
    
###Adding Completion Actions###
    - addCompletionBlock:inQueue:
    - addCompletionSelector:forTarget:inQueue:
    
###Waiting###
    - waitWithTimeout:
    
##Instance Methods##

**addBlock:inQueue:**

    - (void)addBlock:(void(^)())block inQueue:(GCDispatchQueue *)queue;

> Adds the given block to the given queue for execution.

>*Parameters:*

>`block`

>>The block to add to the given queue.

>`queue`

>>A `GCDispatchQueue` object to which to add the given block.

**addSelector:forTarget:inQueue:**

    - (void)addSelector:(SEL)selector forTarget:(id)target inQueue;(GCDispatchQueue *)queue;
    
> Adds the given selector for the given target to the given queue for execution.

>*Parameters:*

>`selector`

>>The selector to add to the given queue.

>`target`

>>The target on which to perform the given selector.

>`queue`

>>A `GCDispatchQueue` object to which to add the given selector.

**addCompletionBlock:inQueue:**

    - (void)addCompletionBlock:(void(^)())block inQueue:(GCDispatchQueue *)queue;

> Adds the given block to the given queue for execution upon queue completion.

>*Parameters:*

>`block`

>>The block to add to the queue for execution upon queue completion.

>`queue`

>>A `GCDispatchQueue` object to which to add the given block.

**addCompletionSelector:forTarget:inQueue:**

    - (void)addCompletionSelector:(SEL)selector forTarget:(id)target inQueue:(GCDispatchQueue *)queue
    
> Adds the given selector for the given target to the given queue for execution upon queue completion.

>*Parameters:*

>`selector`

>>The selector to add to the given queue for execution upon queue completion.

>`target`

>>The target on which to perform the given selector.

>`queue`

>>A `GCDispatchQueue` object to which to add the given selector.

**waitWithTimeout:**

    - (void)waitWithTimeout:(NSTimeInterval)timeout;
    
> Causes this dispatch group to wait for the given time interval.

>*Parameters:*

>`timeout`

>>The time interval, in seconds, for this group to wait.

#License#

License Agreement for Source Code provided by Patrick Perini

This software is supplied to you by Patrick Perini in consideration of your agreement to the following terms, and your use, installation, modification or redistribution of this software constitutes acceptance of these terms. If you do not agree with these terms, please do not use, install, modify or redistribute this software.

In consideration of your agreement to abide by the following terms, and subject to these terms, Patrick Perini grants you a personal, non-exclusive license, to use, reproduce, modify and redistribute the software, with or without modifications, in source and/or binary forms; provided that if you redistribute the software in its entirety and without modifications, you must retain this notice and the following text and disclaimers in all such redistributions of the software, and that in all cases attribution of Patrick Perini as the original author of the source code shall be included in all such resulting software products or distributions. Neither the name, trademarks, service marks or logos of Patrick Perini may be used to endorse or promote products derived from the software without specific prior written permission from Patrick Perini. Except as expressly stated in this notice, no other rights or licenses, express or implied, are granted by Patrick Perini herein, including but not limited to any patent rights that may be infringed by your derivative works or by other works in which the software may be incorporated.

The software is provided by Patrick Perini on an "AS IS" basis. Patrick Perini MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, REGARDING THE SOFTWARE OR ITS USE AND OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.

IN NO EVENT SHALL Patrick Perini BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION, MODIFICATION AND/OR DISTRIBUTION OF THE SOFTWARE, HOWEVER CAUSED AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE), STRICT LIABILITY OR OTHERWISE, EVEN IF Patrick Perini HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.