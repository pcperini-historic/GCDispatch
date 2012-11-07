//
//  GCDispatch.m
//  GCDispatch
//
//  Created by Patrick Perini on 7/19/12.
//  Licensing information available in README.md
//

#import "GCDispatch.h"

@interface GCDispatchQueue (___)

#pragma mark - Properties
@property dispatch_queue_t internalQueue;

@end

#pragma mark - Global Variabls
static GCDispatchQueue *conditionalEvaluationQueue;

@implementation GCDispatch

#pragma mark - Initializers
+ (void)initialize
{
    static dispatch_once_t conditionalEvaluationQueueInitializationToken;
    dispatch_once(&conditionalEvaluationQueueInitializationToken, ^()
    {
        NSString *conditionalEvaluationQueueLabel = [NSString stringWithFormat: @"%@.conditionalEvaluationQueue", NSStringFromClass(self)];
        conditionalEvaluationQueue = [[GCDispatchQueue alloc] initWithLabel: conditionalEvaluationQueueLabel
                                                             andConcurrency: GCDispatchConcurrentQueue];
    });
}

#pragma mark - Convenience Performers
+ (void)performBlockInForeground:(void (^)())block
{
    [[GCDispatchQueue mainQueue] performBlock: block];
}

+ (void)performBlocksInForeground:(NSArray *)blocks
{
    [[GCDispatchQueue mainQueue] performBlocks: blocks];
}

+ (void)performBlockInBackground:(void (^)())block
{
    [[GCDispatchQueue backgroundQueue] performBlock: block];
}

+ (void)performBLocksInBackground:(NSArray *)blocks
{
    [[GCDispatchQueue backgroundQueue] performBlocks: blocks];
}

#pragma mark - Misc. Performers
+ (void)performBlock:(void(^)())block afterDelay:(NSTimeInterval)delay
{
    [self performBlock: block
            afterDelay: delay
               inQueue: [GCDispatchQueue mainQueue]];
}

+ (void)performBlock:(void(^)())block afterDelay:(NSTimeInterval)delay inQueue:(GCDispatchQueue *)queue
{
    dispatch_time_t delay_t = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
    dispatch_after(delay_t, [queue internalQueue], block);
}

+ (void)performBlock:(void(^)(size_t))block numberOfTimes:(NSInteger)times
{
    [self performBlock: block
         numberOfTimes: times
               inQueue: [GCDispatchQueue mainQueue]];
}

+ (void)performBlock:(void (^)(size_t))block numberOfTimes:(NSInteger)times inQueue:(GCDispatchQueue *)queue
{
    dispatch_apply(times, [queue internalQueue], block);
}

+ (void)performBlockOnce:(void (^)())block withToken:(dispatch_once_t)token
{
    dispatch_once(&token, block);
}

+ (void)performBlock:(void (^)())block when:(_Bool (^)())conditionalBlock
{
    [self performBlock: block
                  when: conditionalBlock
               inQueue: [GCDispatchQueue mainQueue]];
}

+ (void)performBlock:(void (^)())block when:(bool (^)())conditionalBlock inQueue:(GCDispatchQueue *)queue
{
    void (^evaluationBlock)() = ^()
    {
        while (!conditionalBlock()) {sleep(1);}
        [queue performBlock: block];
    };
    
    [conditionalEvaluationQueue performBlock: evaluationBlock];
}

@end
