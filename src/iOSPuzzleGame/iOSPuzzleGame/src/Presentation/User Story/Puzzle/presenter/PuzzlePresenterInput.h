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

@protocol PuzzlePresenterInput <NSObject>

- (instancetype)initWithView:(NSObject<PuzzleViewInput> *)view config:(GameConfig *)config;

@end
