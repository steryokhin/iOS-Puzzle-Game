//
//  PuzzleViewModel.h
//  iOSPuzzleGame
//
//  Created by Sergey Teryokhin on 04/06/2017.
//  Copyright © 2017 imacdev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BoardPuzzleModel;
@class GameConfig;

/*
 * Game have some different stages.
 * PuzzleGameStateNoImage - on this stage application don't have image and downloading it from the server. This time
 * application displaying the "Loading" screen
 * PuzzleGameStateStarting - image successfully downloaded and displayed. This time we start back counter
 * PuzzleGameStateGameInProgress - game in progress. This time game counter counting back and user can interact with
 * the board to solve puzzle
 * PuzzleGameStateFinished - stage when game is done with successfull puzzle solved or when counter done
 */
typedef NS_ENUM(NSUInteger, PuzzleGameState) {
    PuzzleGameStateNoImage          = 1,
    PuzzleGameStateStarting         = 2,
    PuzzleGameStateGameInProgress   = 3,
    PuzzleGameStateFinished         = 4
};

NS_ASSUME_NONNULL_BEGIN

/*
 * Wrapper around BoardPuzzleModel
 */
@interface PuzzleViewModel : NSObject <NSCopying>

/*
 * Config of the current game. This is initial parameter of the game which fully setup it.
 */
@property (nonatomic, strong, readonly) GameConfig *config;

/*
 * Model of the board - parts, original image and their positions
 */
@property (nonatomic, strong) BoardPuzzleModel *model;

/// Current game state based on the model
@property (nonatomic, assign) PuzzleGameState gameState;

/// NSDate when timer start ticking. Every 0.1 seconds we'll check how much time from the start we are playing
/// with calculating current time with startProgressDate
@property (nonatomic, strong) NSDate *startProgressDate;

/// Counter which is displaying on the screen before game starts
@property (nonatomic, assign) NSUInteger startGameCounter;

/// if YES -> user successfully resolved it
@property (nonatomic, assign) BOOL doesPuzzleSolved;

- (instancetype)initWithConfig:(GameConfig *)config;
+ (instancetype)modelWithConfig:(GameConfig *)config;

- (id)copyWithZone:(nullable NSZone *)zone;
- (NSString *)description;
- (BOOL)isEqual:(id)other;

- (BOOL)isEqualToModel:(PuzzleViewModel *)model;

- (NSUInteger)hash;

- (instancetype)initWithConfig:(GameConfig *)config model:(BoardPuzzleModel *)model gameState:(PuzzleGameState)gameState startGameCounter:(NSUInteger)startGameCounter startGameDelay:(float_t)startGameDelay gameCounter:(float_t)gameCounter;
+ (instancetype)modelWithConfig:(GameConfig *)config model:(BoardPuzzleModel *)model gameState:(PuzzleGameState)gameState startGameCounter:(NSUInteger)startGameCounter startGameDelay:(float_t)startGameDelay gameCounter:(float_t)gameCounter;

@end


@interface PuzzleViewModel(helper)

- (BOOL)isSolved;

- (float_t)puzzleProgress;
- (NSTimeInterval)puzzleRunningTime;

@end


NS_ASSUME_NONNULL_END
