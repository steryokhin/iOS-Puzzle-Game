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

/*
 * Initial setup of the view with given model
 */
- (void)setupWithModel:(PuzzleViewModel *)model;

/*
 * Update fo hte view with given model. (state machine inside)
 */
- (void)updateWithModel:(PuzzleViewModel *)model;

@end
