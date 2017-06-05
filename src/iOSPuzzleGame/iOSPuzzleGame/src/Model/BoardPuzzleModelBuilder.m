//
// Created by Sergey Teryokhin on 04/06/2017.
// Copyright (c) 2017 imacdev. All rights reserved.
//

#import "BoardPuzzleModelBuilder.h"
#import "PuzzlePart.h"
#import "BoardPuzzleModel.h"
#import "GameConfig.h"


@implementation BoardPuzzleModelBuilder

- (instancetype)initWithBoardPuzzleModel:(BoardPuzzleModel *)model {
    return [self initWithOriginalImage:model.originalImage parts:model.parts];
}

- (instancetype)initWithOriginalImage:(UIImage *)originalImage parts:(NSArray<PuzzlePart *> *)parts {
    self = [super init];
    if (self) {
        self.originalImage = originalImage;
        self.parts = parts;
    }

    return self;
}

+ (instancetype)builderWithOriginalImage:(UIImage *)originalImage parts:(NSArray<PuzzlePart *> *)parts {
    return [[self alloc] initWithOriginalImage:originalImage parts:parts];
}


- (BoardPuzzleModel *)build {
    return nil;
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@:%p", NSStringFromClass([self class]), self];
    [description appendFormat:@"self.originalImage=%@", self.originalImage];
    [description appendFormat:@", self.parts=%@", self.parts];
    [description appendString:@">"];
    return description;
}


@end
