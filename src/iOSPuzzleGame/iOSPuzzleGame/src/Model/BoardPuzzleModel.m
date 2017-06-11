//
//  BoardPuzzleModel.m
//  iOSPuzzleGame
//
//  Created by Sergey Teryokhin on 04/06/2017.
//  Copyright © 2017 imacdev. All rights reserved.
//

#import "BoardPuzzleModel.h"
#import "GameConfig.h"
#import "PuzzleViewModel.h"

@implementation BoardPuzzleModel

- (instancetype)initWithOriginalImage:(UIImage *)originalImage {
    return [self initWithOriginalImage:originalImage originalParts:nil parts:nil];
}

- (instancetype)initWithOriginalImage:(UIImage *)originalImage originalParts:(NSArray<UIImage *> *)originalParts parts:(NSArray<UIImage *> *)parts {
    self = [super init];
    if (self) {
        self.originalImage = originalImage;
        self.originalParts = originalParts;
        self.parts = parts;
    }

    return self;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    BoardPuzzleModel *copy = [[[self class] allocWithZone:zone] init];

    if (copy != nil) {
        copy.originalImage = self.originalImage;
        copy.originalParts = self.originalParts;
        copy.parts = self.parts;
    }

    return copy;
}

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![[other class] isEqual:[self class]])
        return NO;

    return [self isEqualToModel:other];
}

- (BOOL)isEqualToModel:(BoardPuzzleModel *)model {
    if (self == model)
        return YES;
    if (model == nil)
        return NO;
    if (self.originalImage != model.originalImage && ![self.originalImage isEqual:model.originalImage])
        return NO;
    if (self.originalParts != model.originalParts && ![self.originalParts isEqualToArray:model.originalParts])
        return NO;
    if (self.parts != model.parts && ![self.parts isEqualToArray:model.parts])
        return NO;
    return YES;
}

- (NSUInteger)hash {
    NSUInteger hash = [self.originalImage hash];
    hash = hash * 31u + [self.originalParts hash];
    hash = hash * 31u + [self.parts hash];
    return hash;
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@:%p", NSStringFromClass([self class]), self];
    [description appendFormat:@"self.originalImage=%@", self.originalImage];
    [description appendFormat:@", self.originalParts=%@", self.originalParts];
    [description appendFormat:@", self.parts=%@", self.parts];
    [description appendString:@">"];
    return description;
}


+ (instancetype)modelWithOriginalImage:(UIImage *)originalImage originalParts:(NSArray<UIImage *> *)originalParts parts:(NSArray<UIImage *> *)parts {
    return [[self alloc] initWithOriginalImage:originalImage originalParts:originalParts parts:parts];
}


@end

@implementation BoardPuzzleModel(helper)

- (BOOL)isSolved {
    if ([self.parts isEqualToArray:self.originalParts]) {
        return YES;
    }

    return NO;
}

@end

