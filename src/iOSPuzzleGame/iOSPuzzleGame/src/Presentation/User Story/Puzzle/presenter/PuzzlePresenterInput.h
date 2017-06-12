//
//  PuzzlePresenterInput.h
//  iOSPuzzleGame
//
//  Created by Sergey Teryokhin on 04/06/2017.
//  Copyright © 2017 imacdev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PuzzleViewInput;
@class GameConfig;

/*
 * Protocol to manage puzzle presenter with provided interface.
 */
@protocol PuzzlePresenterInput <NSObject>

- (instancetype)initWithView:(NSObject<PuzzleViewInput> *)view config:(GameConfig *)config;

@end
