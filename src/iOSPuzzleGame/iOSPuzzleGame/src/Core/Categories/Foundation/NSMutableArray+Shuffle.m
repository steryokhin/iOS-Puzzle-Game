//
//  NSMutableArray+Shuffle.m
//  iOSPuzzleGame
//
//  Created by Sergey Teryokhin on 11/06/2017.
//  Copyright © 2017 imacdev. All rights reserved.
//

#import "NSMutableArray+Shuffle.h"

@implementation NSMutableArray (Shuffle)

- (void)shuffle
{
    for (NSInteger i = self.count - 1; i > 0; i--) {
        [self exchangeObjectAtIndex:i withObjectAtIndex:arc4random_uniform((u_int32_t)i)];
    }    
}

@end
