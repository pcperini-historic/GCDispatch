# Heads Up #

**This documentation is long outdated.** As you can see, it doesn't even refer to the classes as they exist anymore.
GCDispatch grew out of GCD, and it has yet to be documented. The .h files are pretty explanitory though, so they ought to suffice until I can write some documentation. Enjoy!

    /*
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

        ###Running Tasks Repeatedly###
            + doInForeground:every:
            + doInBackground:every:

        ###Flow Control###
            sync
            + doOnce:


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

        **doInForeground:every:**

        >Repeatedly executes a block on the main thread after waiting for the specified time.

                 + (void)doInForeground:(void (^)(void))block every:(NSTimeInterval)interval

        >*Parameters:*

        >`block`

        >>The block to execute synchronously. This function performs `Block_copy` and `Block_release` on behalf of callers.

        >`interval`

        >>The amount of time in seconds to wait between executing the given block.

        **doInBackground:every:**

        >Repeatedly executes a block on the main thread after waiting for the specified time.

                 + (void)doInBackground:(void (^)(void))block every:(NSTimeInterval)interval

        >*Parameters:*

        >`block`

        >>The block to execute asynchronously. This function performs `Block_copy` and `Block_release` on behalf of callers.

        >`interval`

        >>The amount of time in seconds to wait between executing the given block.

        **doOnce:**

        >Execute a block of code once in the lifetime of the program.

                + (void)doOnce:(void (^)(void))block
                
        >*Parameters:*

        >`block`

        >>The block to execute once.

        ##Macros##

        **sync**

        >Terminates the current function based on the value of the given semaphore.

                sync(semaphore)

        >*Parameters:*

        >`semaphore`

        >>The value used to determine whether the currently-executing function should terminate.
    */

#License#

License Agreement for Source Code provided by Patrick Perini

This software is supplied to you by Patrick Perini in consideration of your agreement to the following terms, and your use, installation, modification or redistribution of this software constitutes acceptance of these terms. If you do not agree with these terms, please do not use, install, modify or redistribute this software.

In consideration of your agreement to abide by the following terms, and subject to these terms, Patrick Perini grants you a personal, non-exclusive license, to use, reproduce, modify and redistribute the software, with or without modifications, in source and/or binary forms; provided that if you redistribute the software in its entirety and without modifications, you must retain this notice and the following text and disclaimers in all such redistributions of the software, and that in all cases attribution of Patrick Perini as the original author of the source code shall be included in all such resulting software products or distributions. Neither the name, trademarks, service marks or logos of Patrick Perini may be used to endorse or promote products derived from the software without specific prior written permission from Patrick Perini. Except as expressly stated in this notice, no other rights or licenses, express or implied, are granted by Patrick Perini herein, including but not limited to any patent rights that may be infringed by your derivative works or by other works in which the software may be incorporated.

The software is provided by Patrick Perini on an "AS IS" basis. Patrick Perini MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, REGARDING THE SOFTWARE OR ITS USE AND OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.

IN NO EVENT SHALL Patrick Perini BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION, MODIFICATION AND/OR DISTRIBUTION OF THE SOFTWARE, HOWEVER CAUSED AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE), STRICT LIABILITY OR OTHERWISE, EVEN IF Patrick Perini HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.