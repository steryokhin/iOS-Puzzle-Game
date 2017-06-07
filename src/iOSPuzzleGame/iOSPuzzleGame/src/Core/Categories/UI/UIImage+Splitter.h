//
//  UIImage+Splitter.h
//  iOSPuzzleGame
//
//  Created by Sergey Teryokhin on 06/06/2017.
//  Copyright © 2017 imacdev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Splitter)

- (NSArray*) splitWithNumberOfRows:(NSUInteger)rows columns:(NSUInteger)columns;

@end
