//
//  Helper.h
//  iOSPuzzleGame
//
//  Created by Sergey Teryokhin on 05/06/2017.
//  Copyright © 2017 imacdev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*
 * Dispatch block on the background queue
 */
void gcdDispatchAsyncOnBackgroundQueue(dispatch_block_t block);

/*
 * Dispatch block on the main queue
 */
void gcdDispatchAsyncOnMainQueue(dispatch_block_t block);

/*
 * Dispatch block on the main queue after \(delayInSeconds) seconds
 */
void gcdDispatchAsyncOnMainQueueAfter(float delayInSeconds, dispatch_block_t block);

#define RGB(R, G, B) [UIColor colorWithRed:R / 255.0 green:G / 255.0 blue:B / 255.0 alpha:1.0]
#define RGBA(R, G, B, A) [UIColor colorWithRed:R / 255.0 green:G / 255.0 blue:B / 255.0 alpha:A]

@interface Helper : NSObject

@end
