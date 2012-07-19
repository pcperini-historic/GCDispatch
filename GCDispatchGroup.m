//
//  GCDispatchGroup.m
//  GCDispatch
//
//  Created by Patrick Perini on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GCDispatchGroup.h"
#import "GCDispatchQueue.h"
#include <objc/message.h>

@interface GCDispatchGroup ()

#pragma mark - Properties
@property dispatch_group_t internalGroup;

@end

@interface GCDispatchQueue (___)

#pragma mark - Properties
@property dispatch_queue_t internalQueue;

@end

@implementation GCDispatchGroup

#pragma mark - Properties
@synthesize internalGroup;

#pragma mark - Initializers
- (id)init
{
    self = [super init];
    if (!self)
        return nil;
    
    internalGroup = dispatch_group_create();
    
    return self;
}

#pragma mark - Mutators
- (void)addBlock:(void (^)())block inQueue:(GCDispatchQueue *)queue
{
    dispatch_group_async(internalGroup, [queue internalQueue], block);
}

- (void)addSelector:(SEL)selector forTarget:(id)target inQueue:(GCDispatchQueue *)queue
{
    void (^block)() = ^()
    {
        objc_msgSend(target, selector);
    };
    
    [self addBlock: block inQueue: queue];
}

- (void)addCompletionBlock:(void (^)())block inQueue:(GCDispatchQueue *)queue
{
    dispatch_group_notify(internalGroup, [queue internalQueue], block);
}

- (void)addCompletionSelector:(SEL)selector forTarget:(id)target inQueue:(GCDispatchQueue *)queue
{
    void (^block)() = ^()
    {
        objc_msgSend(target, selector);
    };
    
    [self addCompletionBlock: block inQueue: queue];
}

#pragma mark - Flow Controllers
- (void)waitWithTimeout:(NSTimeInterval)timeout
{
    dispatch_time_t time_t = dispatch_time(DISPATCH_TIME_NOW, timeout * NSEC_PER_SEC);
    dispatch_group_wait(internalGroup, time_t);
}

@end
