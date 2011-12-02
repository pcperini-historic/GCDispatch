//
//  GCD.m
//  GCD
//
//  Created by Patrick Perini on 11/14/11.
//  Licensing information available in README.md
//

#import "GCD.h"

@implementation GCD

// Main Threading Methods
+(void)doInBackground:(void (^)(void))block
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}

+(void)doInForeground:(void (^)(void))block
{
    dispatch_async(dispatch_get_main_queue(), block);
}

// Misc. Threading Methods
+ (void)doInForeground:(void (^)(void))block after:(NSTimeInterval)interval
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, interval * NSEC_PER_SEC), dispatch_get_main_queue(), block);
}

+ (void)doInForeground:(void (^)(void))block when:(_Bool)condition
{
    [GCD doInBackground: ^{
        while (!condition)
        {
            sleep(1);
        }
        
        [GCD doInForeground: block];
    }];
}

@end
