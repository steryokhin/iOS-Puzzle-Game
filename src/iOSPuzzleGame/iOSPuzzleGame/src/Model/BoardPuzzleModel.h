//
//  BoardPuzzleModel.h
//  iOSPuzzleGame
//
//  Created by Sergey Teryokhin on 04/06/2017.
//  Copyright © 2017 imacdev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class PuzzlePart;

@interface BoardPuzzleModel : NSObject

@property (nonatomic, strong, readonly) UIImage *originalImage;
@property (nonatomic, strong, readonly) NSArray<PuzzlePart *> *parts;

@property (nonatomic, assign, readonly) NSUInteger rowCount;
@property (nonatomic, assign, readonly) NSUInteger columnCount;

@end
