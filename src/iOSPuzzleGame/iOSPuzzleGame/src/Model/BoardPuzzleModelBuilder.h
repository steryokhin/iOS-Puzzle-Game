//
// Created by Sergey Teryokhin on 04/06/2017.
// Copyright (c) 2017 imacdev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class PuzzlePart;
@class BoardPuzzleModel;
@class GameConfig;

NS_ASSUME_NONNULL_BEGIN

@interface BoardPuzzleModelBuilder : NSObject

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithConfig:(GameConfig *)config;

+ (instancetype)builderWithConfig:(GameConfig *)config;

- (instancetype)initWithConfig:(GameConfig *)config originalImage:(UIImage *)originalImage parts:(NSArray<PuzzlePart *> *)parts;

+ (instancetype)builderWithConfig:(GameConfig *)config originalImage:(UIImage *)originalImage parts:(NSArray<PuzzlePart *> *)parts;

/// Configuration of the board and of the game
@property (nonatomic, strong) GameConfig *config;

@property (nonatomic, strong) UIImage *originalImage;
@property (nonatomic, strong) NSArray<PuzzlePart *> *parts;

- (BoardPuzzleModel *)build;

@end

NS_ASSUME_NONNULL_END
