//
//  GCDispatchQueue.h
//  GCDispatch
//
//  Created by Patrick Perini on 7/19/12.
//  Licensing information available in README.md
//

#import <Foundation/Foundation.h>

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
+ (GCDispatchQueue *)currentQueue;

#pragma mark - Initializers
- (id)initWithLabel:(NSString *)label;
- (id)initWithLabel:(NSString *)label andConcurrency:(GCDispatchQueueConcurrency)concurrency;

#pragma mark - Performers
- (void)performBlock:(void (^)())block;
- (void)performSelector:(SEL)selector onTarget:(id)target;

- (void)performBlock:(void (^)())block synchronously:(BOOL)synchronously;
- (void)performSelector:(SEL)selector onTarget:(id)target synchronously:(BOOL)synchronously;

@end