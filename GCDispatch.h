//
//  GCDispatch.h
//  GCDispatch
//
//  Created by Patrick Perini on 7/19/12.
//  Licensing information available in README.md
//

#import <Foundation/Foundation.h>
@class GCDispatchQueue;

#pragma mark - Types
typedef size_t GCDispatchIteration;
typedef dispatch_once_t GCDispatchOnceToken;

typedef void(^GCDispatchBlock)();
typedef void(^GCDispatchIterativeBlock)(GCDispatchIteration currentIteration);
typedef _Bool(^GCDispatchConditionalBlock)();

@interface GCDispatch : NSObject

#pragma mark - Main Queue Performers
+ (void)performBlockInMainQueue:(GCDispatchBlock)block;
+ (void)performBlockInMainQueue:(GCDispatchBlock)block completion:(GCDispatchBlock)completion;
+ (void)performBlocksInMainQueue:(NSArray *)blocks;
+ (void)performBlocksInMainQueue:(NSArray *)blocks completion:(GCDispatchBlock)completion;

#pragma mark - Background Queue Performers
+ (void)performBlockInBackgroundQueue:(GCDispatchBlock)block;
+ (void)performBlockInBackgroundQueue:(GCDispatchBlock)block completion:(GCDispatchBlock)completion;
+ (void)performBlocksInBackgroundQueue:(NSArray *)blocks;
+ (void)performBlocksInBackgroundQueue:(NSArray *)blocks completion:(GCDispatchBlock)completion;

#pragma mark - Misc. Performers
+ (void)performBlock:(GCDispatchBlock)block inMainQueueAfterDelay:(NSTimeInterval)delay;
+ (void)performBlock:(GCDispatchBlock)block inQueue:(GCDispatchQueue *)queue afterDelay:(NSTimeInterval)delay;

+ (void)performBlock:(GCDispatchIterativeBlock)block inMainQueueNumberOfTimes:(NSInteger)times;
+ (void)performBlock:(GCDispatchIterativeBlock)block inQueue:(GCDispatchQueue *)queue numberOfTimes:(NSInteger)times;

+ (void)performBlockOnce:(GCDispatchBlock)block inMainQueueWithToken:(GCDispatchOnceToken)token;

+ (void)performBlock:(GCDispatchBlock)block inMainQueueWhen:(GCDispatchConditionalBlock)conditionalBlock;
+ (void)performBlock:(GCDispatchBlock)block inQueue:(GCDispatchQueue *)queue when:(GCDispatchConditionalBlock)conditionalBlock;

@end
