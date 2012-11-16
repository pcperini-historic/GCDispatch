//
//  GCDispatchQueue.h
//  GCDispatch
//
//  Created by Patrick Perini on 7/19/12.
//  Licensing information available in README.md
//

#import <Foundation/Foundation.h>
#import "GCDispatch.h"

#pragma mark - External Constants
typedef enum
{
    GCDispatchSerialQueue,
    GCDispatchConcurrentQueue
} GCDispatchQueueConcurrency;

@interface GCDispatchQueue : NSObject

#pragma mark - Properties
@property NSString *label;

#pragma mark - Singletons
+ (GCDispatchQueue *)mainQueue;
+ (GCDispatchQueue *)backgroundQueue;

#pragma mark - Class Accessors
+ (BOOL)currentQueueIsMainQueue;

#pragma mark - Initializers
- (id)initWithLabel:(NSString *)label;
- (id)initWithLabel:(NSString *)label andConcurrency:(GCDispatchQueueConcurrency)concurrency;

#pragma mark - Performers
- (void)performBlock:(GCDispatchBlock)block;
- (void)performBlock:(GCDispatchBlock)block completion:(GCDispatchBlock)completion;
- (void)performBlocks:(NSArray *)blocks;
- (void)performBlocks:(NSArray *)blocks completion:(GCDispatchBlock)completion;

@end