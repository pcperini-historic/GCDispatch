//
//  GCDTestsViewController.m
//  GCDispatchTests
//
//  Created by Patrick Perini on 10/7/13.
//  Copyright (c) 2013 pcperini. All rights reserved.
//

#import "GCDTestsViewController.h"
#import "GCDispatch.h"
#import "GCDispatchQueue.h"

@interface GCDTestsViewController ()

@end

@implementation GCDTestsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [GCDispatch performBlockRecursively: ^(GCDispatchIteration currentIteration, BOOL *loop, BOOL *stop)
    {
        if (currentIteration > 10)
        {
            *stop = YES;
            return;
        }
        
        NSLog(@"%zu", currentIteration);
    } inQueue: [GCDispatchQueue mainQueue] withTimeInterval: 0.5];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
