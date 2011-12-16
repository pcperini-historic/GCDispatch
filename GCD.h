//
//  GCD.h
//  GCD
//
//  Created by Patrick Perini on 11/14/11.
//  Licensing information available in README.md
//

#import <Foundation/Foundation.h>

@interface GCD : NSObject

// Main Threading Methods
+ (void)doInBackground:        (void (^)(void))block;

+ (void)doInForeground:        (void (^)(void))block;

// Misc. Threading Methods
+ (void)doInForeground:        (void (^)(void))block            after: (NSTimeInterval)interval;

+ (void)doInForeground:        (void (^)(void))block            when:  (_Bool)condition;

+ (void)doInForeground:        (void (^)(void))block            every: (NSTimeInterval)interval

+ (void)doInBackground:        (void (^)(void))block            every: (NSTimeInterval)interval

// Misc. Macros
#define sync(semaphore)        if(!semaphore) {return;}

// Main Flow Control Methods
+ (void)doOnce                 (void (^)(void))block;

@end
