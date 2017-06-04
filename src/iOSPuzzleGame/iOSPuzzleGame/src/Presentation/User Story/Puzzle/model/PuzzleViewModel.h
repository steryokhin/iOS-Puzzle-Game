//
//  PuzzleViewModel.h
//  iOSPuzzleGame
//
//  Created by Sergey Teryokhin on 04/06/2017.
//  Copyright © 2017 imacdev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BoardPuzzleModel;

typedef NS_ENUM(NSUInteger, PuzzleGameState) {
    PuzzleGameStateNoImage          = 0,
    PuzzleGameStateStarting         = 1,
    PuzzleGameStateGameInProgress   = 2
};

@interface PuzzleViewModel : NSObject

@property (nonatomic, assign) PuzzleGameState *gameState;
@property (nonatomic, strong, readonly) BoardPuzzleModel *model;

- (BOOL)isLandscape;



@end
