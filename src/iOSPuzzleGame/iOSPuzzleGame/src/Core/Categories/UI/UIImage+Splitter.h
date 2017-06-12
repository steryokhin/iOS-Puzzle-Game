//
//  UIImage+Splitter.h
//  iOSPuzzleGame
//
//  Created by Sergey Teryokhin on 06/06/2017.
//  Copyright © 2017 imacdev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Splitter)

/*
 * Split image into multiple images with given row and colums cont
 * Return array of images if successfull and nil otherwise
 * rows and columns should be more then 1
 */
- (NSArray*) splitWithNumberOfRows:(NSUInteger)rows columns:(NSUInteger)columns;

@end
