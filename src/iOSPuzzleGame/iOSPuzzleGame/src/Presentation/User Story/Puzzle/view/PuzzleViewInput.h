//
//  PuzzleViewInput.h
//  iOSPuzzleGame
//
//  Created by Sergey Teryokhin on 04/06/2017.
//  Copyright © 2017 imacdev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BoardPuzzleModel;
@class PuzzleViewModel;

@protocol PuzzleViewInput <NSObject>

- (void)setupWithModel:(PuzzleViewModel *)model;
- (void)updateWithModel:(PuzzleViewModel *)model;

- (void)updateWithBoardPuzzleModel:(BoardPuzzleModel *)boardModel;

@end
