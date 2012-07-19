//
//  GCDispatchGroup.h
//  GCDispatch
//
//  Created by Patrick Perini on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GCDispatchQueue;

@interface GCDispatchGroup : NSObject

#pragma mark - Mutators
- (void)addBlock:(void(^)())block inQueue:(GCDispatchQueue *)queue;
- (void)addSelector:(SEL)selector forTarget:(id)target inQueue:(GCDispatchQueue *)queue;

- (void)addCompletionBlock:(void(^)())block inQueue:(GCDispatchQueue *)queue;
- (void)addCompletionSelector:(SEL)selector forTarget:(id)target inQueue:(GCDispatchQueue *)queue;

#pragma mark - Flow Controllers
- (void)waitWithTimeout:(NSTimeInterval)timeout;

@end