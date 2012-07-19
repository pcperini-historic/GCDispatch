//
//  GCDispatchQueue.m
//  GCDispatch
//
//  Created by Patrick Perini on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GCDispatchQueue.h"
#include <objc/message.h>

@interface GCDispatchQueue ()

#pragma mark - Properties
@property dispatch_queue_t internalQueue;

#pragma mark - Initializers
- (id)initWithDispatch_Queue:(dispatch_queue_t)queue_t;

@end


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
        mainQueue = [[GCDispatchQueue alloc] initWithDispatch_Queue: dispatch_get_main_queue()];
    });
}

+ (GCDispatchQueue *)backgroundQueue
{
    static dispatch_once_t backgroundQueueInitializationToken;
    dispatch_once(&backgroundQueueInitializationToken, ^()
    {
        dispatch_queue_t queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
        backgroundQueue = [[GCDispatchQueue alloc] initWithDispatch_Queue: queue_t];
    });
}

#pragma mark - Class Accessors
+ (GCDispatchQueue *)currentQueue
{
    dispatch_queue_t queue_t = dispatch_get_current_queue();
    return [[GCDispatchQueue alloc] initWithDispatch_Queue: queue_t];
}

#pragma mark - Initializers
- (id)initWithDispatch_Queue:(dispatch_queue_t)queue_t
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
    
    dispatch_queue_attr_t attr = (dispatch_queue_attr_t) concurrency;
    internalQueue = dispatch_queue_create([label UTF8String], attr);
    
    return self;
}

#pragma mark - Performers
- (void)performBlock:(void (^)())block
{
    [self performBlock: block
         synchronously: NO];
}

- (void)performSelector:(SEL)selector onTarget:(id)target
{
    [self performSelector: selector
                 onTarget: target
            synchronously: NO];
}

- (void)performBlock:(void (^)())block synchronously:(BOOL)synchronously
{
    if (synchronously)
    {
        dispatch_async(internalQueue, block);
    }
    else
    {
        dispatch_sync(internalQueue, block);
    }
}

- (void)performSelector:(SEL)selector onTarget:(id)target synchronously:(BOOL)synchronously
{
    void (^block)() = ^()
    {
        objc_msgSend(target, selector);
    };
    
    [self performBlock: block synchronously: synchronously];
}

@end
