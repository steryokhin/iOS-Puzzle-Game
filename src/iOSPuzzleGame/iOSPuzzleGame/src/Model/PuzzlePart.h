//
//  PuzzlePart.h
//  iOSPuzzleGame
//
//  Created by Sergey Teryokhin on 04/06/2017.
//  Copyright © 2017 imacdev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PuzzlePart : NSObject

@property (nonatomic, strong, readonly) UIImage *image;
@property (nonatomic, assign, readonly) NSUInteger originalIndex;
@property (nonatomic, assign, readonly) NSUInteger currentIndex;

@end
