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


- (id)copyWithZone:(nullable NSZone *)zone {
    BoardPuzzleModel *copy = [[[self class] allocWithZone:zone] init];

    if (copy != nil) {
        copy->_originalImage = _originalImage;
        copy->_parts = _parts;
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
    if (self.parts != model.parts && ![self.parts isEqualToArray:model.parts])
        return NO;
    return YES;
}

- (NSUInteger)hash {
    NSUInteger hash = [self.originalImage hash];
    hash = hash * 31u + [self.parts hash];
    return hash;
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@:%p", NSStringFromClass([self class]), self];
    [description appendFormat:@", self.originalImage=%@", self.originalImage];
    [description appendFormat:@", self.parts=%@", self.parts];
    [description appendString:@">"];
    return description;
}

@end
