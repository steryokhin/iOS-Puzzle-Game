//
//  Helper.h
//  iOSPuzzleGame
//
//  Created by Sergey Teryokhin on 05/06/2017.
//  Copyright © 2017 imacdev. All rights reserved.
//

#import <Foundation/Foundation.h>

void gcdDispatchAsyncOnMainQueue(dispatch_block_t block);
void gcdDispatchAsyncOnMainQueueAfter(float delayInSeconds, dispatch_block_t block);

@interface Helper : NSObject

@end
