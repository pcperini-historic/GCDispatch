//
//  GCDispatch.m
//  GCDispatch
//
//  Created by Patrick Perini on 7/19/12.
//  Licensing information available in README.md
//

#import "GCDispatch.h"
#import "GCDispatchQueue.h"

@interface GCDispatchQueue ()

#pragma mark - Properties
@property dispatch_queue_t internalQueue;

@end

#pragma mark - Global Variabls
static GCDispatchQueue *conditionalEvaluationQueue;

#pragma mark - Internal Constants
NSString *const GCDispatchConditionalEvaluationQueueLabelFormat = @"%@.conditionalEvaluationQueue";

@implementation GCDispatch

#pragma mark - Initializers
+ (void)initialize
{
    static GCDispatchOnceToken conditionalEvaluationQueueInitializationToken;
    dispatch_once(&conditionalEvaluationQueueInitializationToken, ^()
    {
        NSString *conditionalEvaluationQueueLabel = [NSString stringWithFormat: GCDispatchConditionalEvaluationQueueLabelFormat, NSStringFromClass(self)];
        conditionalEvaluationQueue = [[GCDispatchQueue alloc] initWithLabel: conditionalEvaluationQueueLabel
                                                             andConcurrency: GCDispatchConcurrentQueue];
    });
}

#pragma mark - Main Queue Performers
+ (void)performBlockInMainQueue:(GCDispatchBlock)block
{
    [[GCDispatchQueue mainQueue] performBlock: block];
}

+ (void)performBlockInMainQueue:(GCDispatchBlock)block completion:(GCDispatchBlock)completion
{
    [[GCDispatchQueue mainQueue] performBlock: block
                                   completion: completion];
}

+ (void)performBlocksInMainQueue:(NSArray *)blocks
{
    [[GCDispatchQueue mainQueue] performBlocks: blocks];
}

+ (void)performBlocksInMainQueue:(NSArray *)blocks completion:(GCDispatchBlock)completion
{
    [[GCDispatchQueue mainQueue] performBlocks: blocks
                                    completion: completion];
}

#pragma mark - Background Queue Performers
+ (void)performBlockInBackgroundQueue:(GCDispatchBlock)block
{
    [[GCDispatchQueue backgroundQueue] performBlock: block];
}

+ (void)performBlockInBackgroundQueue:(GCDispatchBlock)block completion:(GCDispatchBlock)completion
{
    [[GCDispatchQueue backgroundQueue] performBlock: block
                                         completion: completion];
}

+ (void)performBlocksInBackgroundQueue:(NSArray *)blocks
{
    [[GCDispatchQueue backgroundQueue] performBlocks: blocks];
}

+ (void)performBlocksInBackgroundQueue:(NSArray *)blocks completion:(GCDispatchBlock)completion
{
    [[GCDispatchQueue backgroundQueue] performBlocks: blocks
                                          completion: completion];
}

#pragma mark - Misc. Performers
+ (void)performBlock:(GCDispatchBlock)block inMainQueueAfterDelay:(NSTimeInterval)delay
{
    [self performBlock: block
               inQueue: [GCDispatchQueue mainQueue]
            afterDelay: delay];
}

+ (void)performBlock:(GCDispatchBlock)block inQueue:(GCDispatchQueue *)queue afterDelay:(NSTimeInterval)delay
{
    dispatch_time_t delay_t = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
    dispatch_after(delay_t, [queue internalQueue], block);
}

+ (void)performBlock:(GCDispatchIterativeBlock)block inMainQueueNumberOfTimes:(NSInteger)times
{
    [self performBlock: block
               inQueue: [GCDispatchQueue mainQueue]
         numberOfTimes: times];
}

+ (void)performBlock:(GCDispatchIterativeBlock)block inQueue:(GCDispatchQueue *)queue numberOfTimes:(NSInteger)times
{
    dispatch_apply(times, [queue internalQueue], block);
}

+ (void)performBlockOnce:(GCDispatchBlock)block inMainQueueWithToken:(GCDispatchOnceToken)token
{
    dispatch_once(&token, block);
}

+ (void)performBlock:(GCDispatchBlock)block inMainQueueWhen:(GCDispatchConditionalBlock)conditionalBlock
{
    [self performBlock: block
               inQueue: [GCDispatchQueue mainQueue]
                  when: conditionalBlock];
}

+ (void)performBlock:(GCDispatchBlock)block inQueue:(GCDispatchQueue *)queue when:(GCDispatchConditionalBlock)conditionalBlock
{
    GCDispatchBlock evalutationBlock = ^()
    {
        while (!conditionalBlock())
        {
            [[NSRunLoop mainRunLoop] runUntilDate: [NSDate dateWithTimeIntervalSinceNow: 1]];
        }
        
        [queue performBlock: block];
    };
    
    [conditionalEvaluationQueue performBlock: evalutationBlock];
}

+ (void)performBlock:(GCDispatchBlock)block inQueue:(GCDispatchQueue *)queue periodicallyWithTimeInterval:(NSTimeInterval)timeInterval timer:(GCDispatchTimer *)timerPointer
{
    GCDispatchTimer timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, [queue internalQueue]);
    if (!timer)
        return;
    
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), timeInterval * NSEC_PER_SEC, FLT_EPSILON * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, block);
    
    dispatch_resume(timer);
    *timerPointer = timer;
}

+ (void)performBlockRecursively:(GCDispatchContinuousBlock)block inQueue:(GCDispatchQueue *)queue;
{
    __block GCDispatchBlock recursiveBlockPerformer;
    __block GCDispatchIteration index = 0;
    GCDispatchBlock blockPerformer = ^()
    {
        BOOL continuePerforming = block(index);
        index++;
        
        if (!continuePerforming)
        {
            recursiveBlockPerformer = nil;
            return;
        }
        
        [queue performBlock: recursiveBlockPerformer];
    };
    
    recursiveBlockPerformer = [blockPerformer copy];
    [queue performBlock: recursiveBlockPerformer];
}


@end
