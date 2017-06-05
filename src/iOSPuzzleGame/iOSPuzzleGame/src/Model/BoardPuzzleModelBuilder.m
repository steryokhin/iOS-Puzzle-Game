//
// Created by Sergey Teryokhin on 04/06/2017.
// Copyright (c) 2017 imacdev. All rights reserved.
//

#import "BoardPuzzleModelBuilder.h"
#import "PuzzlePart.h"
#import "BoardPuzzleModel.h"
#import "GameConfig.h"


@implementation BoardPuzzleModelBuilder
- (instancetype)initWithConfig:(GameConfig *)config {
    self = [super init];
    if (self) {
        self.config = config;
    }

    return self;
}

- (instancetype)initWithConfig:(GameConfig *)config originalImage:(UIImage *)originalImage parts:(NSArray<PuzzlePart *> *)parts {
    self = [super init];
    if (self) {
        self.config = config;
        self.originalImage = originalImage;
        self.parts = parts;
    }

    return self;
}

+ (instancetype)builderWithConfig:(GameConfig *)config originalImage:(UIImage *)originalImage parts:(NSArray<PuzzlePart *> *)parts {
    return [[self alloc] initWithConfig:config originalImage:originalImage parts:parts];
}


+ (instancetype)builderWithConfig:(GameConfig *)config {
    return [[self alloc] initWithConfig:config];
}

- (BoardPuzzleModel *)build {
    return nil;
}

@end
