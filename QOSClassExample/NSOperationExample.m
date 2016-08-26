//
//  NSOperationExample.m
//  QOSClassExample
//
//  Created by Alper KARATAŞ on 25/08/16.
//  Copyright © 2016 Alper KARATAŞ. All rights reserved.
//

#import "NSOperationExample.h"

@implementation NSOperationExample

typedef void (^Work)(int);

+ (void)run {
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 100; i++) {
            NSLog(@"1-%d", i);
        }
    }];
    [op1 setQualityOfService:NSQualityOfServiceBackground];
    //[op1 setQueuePriority:NSOperationQueuePriorityLow];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 100; i++) {
            NSLog(@"2-%d", i);
        }
    }];
    [op2 setQualityOfService:NSQualityOfServiceUtility];
    //[op2 setQueuePriority:NSOperationQueuePriorityLow];
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 100; i++) {
            NSLog(@"3-%d", i);
        }
    }];
    [op3 setQualityOfService:NSQualityOfServiceUserInteractive];
    //[op3 setQueuePriority:NSOperationQueuePriorityVeryHigh];
    
    //[op2 addDependency:op1];
    
    NSOperationQueue *runner = [NSOperationQueue new];
    [runner addOperations:@[ op1, op2, op3 ] waitUntilFinished:NO];
}

@end
