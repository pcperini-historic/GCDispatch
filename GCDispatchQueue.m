//
//  GCDispatchQueue.m
//  GCDispatch
//
//  Created by Patrick Perini on 7/19/12.
//  Licensing information available in README.md
//

#import "GCDispatchQueue.h"
#include <objc/message.h>

@interface GCDispatchQueue ()

#pragma mark - Properties
@property dispatch_queue_t internalQueue;

#pragma mark - Initializers
- (id)initWithDispatch_queue:(dispatch_queue_t)queue_t;

#pragma mark - Converters
+ (dispatch_queue_attr_t)dispatch_attrFromConcurrency:(GCDispatchQueueConcurrency)concurrency;

@end

static GCDispatchQueue *mainQueue;
static GCDispatchQueue *backgroundQueue;

@implementation GCDispatchQueue

#pragma mark - Properties
@synthesize internalQueue;
@synthesize label;

#pragma mark - Singletons
+ (GCDispatchQueue *)mainQueue
{
    static dispatch_once_t mainQueueInitializationToken;
    dispatch_once(&mainQueueInitializationToken, ^()
    {
        mainQueue = [[GCDispatchQueue alloc] initWithDispatch_queue: dispatch_get_main_queue()];
    });
    
    return mainQueue;
}

+ (GCDispatchQueue *)backgroundQueue
{
    static dispatch_once_t backgroundQueueInitializationToken;
    dispatch_once(&backgroundQueueInitializationToken, ^()
    {
        dispatch_queue_t queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
        backgroundQueue = [[GCDispatchQueue alloc] initWithDispatch_queue: queue_t];
    });
    
    return backgroundQueue;
}

#pragma mark - Class Accessors
+ (BOOL)currentQueueIsMainQueue
{
    return [[NSThread currentThread] isMainThread];
}

#pragma mark - Converters
+ (dispatch_queue_attr_t) dispatch_attrFromConcurrency:(GCDispatchQueueConcurrency)concurrency
{
    switch (concurrency)
    {
        case GCDispatchSerialQueue:
            return DISPATCH_QUEUE_SERIAL;
        
        case GCDispatchConcurrentQueue:
            return DISPATCH_QUEUE_CONCURRENT;
    }
}

#pragma mark - Initializers
- (id)initWithDispatch_queue:(dispatch_queue_t)queue_t
{
    self = [super init];
    if (!self)
        return nil;
    
    internalQueue = queue_t;
    label = [NSString stringWithUTF8String: dispatch_queue_get_label(internalQueue)];
    
    return self;
}

- (id)initWithLabel:(NSString *)aLabel
{
    return [self initWithLabel: aLabel andConcurrency: GCDispatchSerialQueue];
}

- (id)initWithLabel:(NSString *)aLabel andConcurrency:(GCDispatchQueueConcurrency)concurrency
{
    self = [super init];
    if (!self)
        return nil;
    
    label = aLabel;
    
    dispatch_queue_attr_t attr = [GCDispatchQueue dispatch_attrFromConcurrency: concurrency];
    internalQueue = dispatch_queue_create([label UTF8String], attr);
    
    return self;
}

#pragma mark - Performers
- (void)performBlock:(GCDispatchBlock)block
{
    [self performBlock: block
            completion: nil];
}

- (void)performBlock:(GCDispatchBlock)block completion:(GCDispatchBlock)completion
{
    GCDispatchBlock performance = ^()
    {
        block();
        if (completion)
        {
            dispatch_async([[GCDispatchQueue mainQueue] internalQueue], completion);
        }
    };
    
    dispatch_async(internalQueue, performance);
}

- (void)performBlocks:(NSArray *)blocks
{
    [self performBlocks: blocks
             completion: nil];
}

- (void)performBlocks:(NSArray *)blocks completion:(GCDispatchBlock)completion
{
    __block NSInteger currentIteration = -1;
    __block GCDispatchBlock performances = [^()
    {
        currentIteration++;
        if (currentIteration >= [blocks count])
        {
            if (completion)
            {
                dispatch_async([[GCDispatchQueue mainQueue] internalQueue], completion);
            }
            
            performances = nil;
            return;
        }
        
        [self performBlock: [blocks objectAtIndex: currentIteration]
                completion: performances];
    } copy];
    
    dispatch_async(internalQueue, performances);
}

#pragma mark - Accessors
- (BOOL)isEqual:(id)object
{
    BOOL objectsAreEqual = YES;
    objectsAreEqual &= ([self internalQueue] == [object internalQueue]);
    objectsAreEqual &= ([[self label] isEqualToString: [object label]]);
    
    return objectsAreEqual;
}

@end
