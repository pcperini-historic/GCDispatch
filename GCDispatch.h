//
//  GCDispatch.h
//  GCDispatch
//
//  Created by Patrick Perini on 7/19/12.
//  Licensing information available in README.md
//

#import <Foundation/Foundation.h>
#import "GCDispatchQueue.h"
#import "GCDispatchGroup.h"

@interface GCDispatch : NSObject

#pragma mark - Convenience Performers
+ (void)performBlockInForeground:(void(^)())block;
+ (void)performBlockInBackground:(void(^)())block;

#pragma mark - Misc. Performers
+ (void)performBlock:(void(^)())block afterDelay:(NSTimeInterval)delay;
+ (void)performBlock:(void(^)())block afterDelay:(NSTimeInterval)delay inQueue:(GCDispatchQueue *)queue;

+ (void)performBlock:(void(^)(size_t currentIteration))block numberOfTimes:(NSInteger)times;
+ (void)performBlock:(void(^)(size_t currentIteration))block numberOfTimes:(NSInteger)times inQueue:(GCDispatchQueue *)queue;

+ (void)performBlockOnce:(void (^)())block withToken:(dispatch_once_t)token;

+ (void)performBlock:(void (^)())block when:(_Bool(^)())conditionalBlock;
+ (void)performBlock:(void (^)())block when:(_Bool(^)())conditionalBlock inQueue:(GCDispatchQueue *)queue;

@end
