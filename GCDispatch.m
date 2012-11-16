//
//  GCDispatch.m
//  GCDispatch
//
//  Created by Patrick Perini on 7/19/12.
//  Licensing information available in README.md
//

#import "GCDispatch.h"
#import "GCDispatchQueue.h"

@interface GCDispatchQueue (___)

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
            sleep(1);
        
        [queue performBlock: block];
    };
    
    [conditionalEvaluationQueue performBlock: evalutationBlock];
}

@end
