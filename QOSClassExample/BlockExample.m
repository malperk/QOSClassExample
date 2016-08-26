//
//  BlockExample.m
//  QOSClassExample
//
//  Created by Alper KARATAŞ on 26/08/16.
//  Copyright © 2016 Alper KARATAŞ. All rights reserved.
//

#import "BlockExample.h"
#include <dispatch/dispatch.h>

extern NSInteger CounterGlobal;
static NSInteger CounterStatic;

@implementation BlockExample

typedef void (^blocktype1)(void);
typedef int (^blocktype2)(void);
typedef int (^blocktype3)(int);

+ (void)run {
    ^{
        NSLog(@"I am Block");
    };
    (int)^{
        return 5;
    };
    
    (int)^(int num) {
        return num;
    };
    
    void (^myblock1)() = ^{
        NSLog(@"I am Block");
    };
    int (^myblock2)() = ^int {
        return 5;
    };
    
    int (^myblock3)(int) = ^int(int num) {
        return num;
    };
    
    void (^myblock4)();
    myblock4 = myblock1;
    int (^myblock5)();
    myblock5 = myblock2;
    int (^myblock6)(int);
    myblock6 = myblock3;
    
    blocktype1 myblock7;
    blocktype2 myblock8;
    blocktype3 myblock9;
    
    myblock7 = myblock4;
    myblock8 = myblock5;
    myblock9 = myblock6;
    
    
}

+ (void)run2 {
    NSInteger localCounter = 42;
    __block char localCharacter;
    
    void (^aBlock)(void) = ^(void) {
        ++CounterGlobal;
        ++CounterStatic;
        CounterGlobal = localCounter; // localCounter fixed at block creation
        localCharacter = 'a';         // sets localCharacter in enclosing scope
    };
    
    ++localCounter; // unseen by the block
    localCharacter = 'b';
    
    aBlock(); // execute the block
    // localCharacter now 'a'
}

+ (void)run3 {
    // Using a Block as a Function Argument
    size_t count = 10;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_apply(count, queue, ^(size_t i) {
        printf("%zu\n", i);
    });
}

+ (void)run4 {
    // Using a Block as a Method Argument
    [BlockExample metodGetBlock1:^int(int num) {
        return 5;
    }];
    
    [BlockExample metodGetBlock2:^{
        
    }];
}

+ (void)metodGetBlock1:(int (^)(int))blockName {
    blockName(4);
}

+ (void)metodGetBlock2:(blocktype1)block {
    block();
}

@end
