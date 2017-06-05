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

@property (nonatomic, strong) UIImage *originalImage;
@property (nonatomic, strong) NSArray<PuzzlePart *> *parts;

- (instancetype)initWithBoardPuzzleModel:(BoardPuzzleModel *)model;

- (instancetype)initWithOriginalImage:(UIImage *)originalImage parts:(NSArray<PuzzlePart *> *)parts;

+ (instancetype)builderWithOriginalImage:(UIImage *)originalImage parts:(NSArray<PuzzlePart *> *)parts;

- (NSString *)description;

- (BoardPuzzleModel *)build;

@end

NS_ASSUME_NONNULL_END
