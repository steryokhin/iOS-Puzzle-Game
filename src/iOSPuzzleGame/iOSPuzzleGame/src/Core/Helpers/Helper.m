//
//  Helper.m
//  iOSPuzzleGame
//
//  Created by Sergey Teryokhin on 05/06/2017.
//  Copyright © 2017 imacdev. All rights reserved.
//

#import "Helper.h"

void gcdDispatchAsyncOnBackgroundQueue(dispatch_block_t block) {
    dispatch_queue_t backgroundQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);

    dispatch_async(backgroundQueue, block);
}

void gcdDispatchAsyncOnMainQueue(dispatch_block_t block) {
    dispatch_async(dispatch_get_main_queue(), block);
}

void gcdDispatchAsyncOnMainQueueAfter(float delayInSeconds, dispatch_block_t block){
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}

@implementation Helper

@end
