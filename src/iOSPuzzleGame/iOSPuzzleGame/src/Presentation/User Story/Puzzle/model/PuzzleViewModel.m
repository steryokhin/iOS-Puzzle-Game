//
//  PuzzleViewModel.m
//  iOSPuzzleGame
//
//  Created by Sergey Teryokhin on 04/06/2017.
//  Copyright © 2017 imacdev. All rights reserved.
//

#import "PuzzleViewModel.h"
#import "GameConfig.h"
#import "BoardPuzzleModel.h"

@implementation PuzzleViewModel

- (instancetype)initWithConfig:(GameConfig *)config {
    self = [super init];
    if (self) {
        _config = config;

        self.gameState = PuzzleGameStateNoImage;
    }

    return self;
}

- (instancetype)initWithConfig:(GameConfig *)config model:(BoardPuzzleModel *)model gameState:(PuzzleGameState)gameState startGameCounter:(NSUInteger)startGameCounter startGameDelay:(float_t)startGameDelay gameCounter:(float_t)gameCounter {
    self = [super init];
    if (self) {
        _config = config;
        self.model = model;
        self.gameState = gameState;
        self.startGameCounter = startGameCounter;
        self.startGameDelay = startGameDelay;
        self.gameCounter = gameCounter;
    }

    return self;
}

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![[other class] isEqual:[self class]])
        return NO;

    return [self isEqualToModel:other];
}

- (BOOL)isEqualToModel:(PuzzleViewModel *)model {
    if (self == model)
        return YES;
    if (model == nil)
        return NO;
    if (self.config != model.config && ![self.config isEqualToConfig:model.config])
        return NO;
    if (self.model != model.model && ![self.model isEqualToModel:model.model])
        return NO;
    if (self.gameState != model.gameState)
        return NO;
    if (self.startGameCounter != model.startGameCounter)
        return NO;
    if (self.startGameDelay != model.startGameDelay)
        return NO;
    if (self.gameCounter != model.gameCounter)
        return NO;
    return YES;
}

- (NSUInteger)hash {
    NSUInteger hash = [self.config hash];
    hash = hash * 31u + [self.model hash];
    hash = hash * 31u + (NSUInteger) self.gameState;
    hash = hash * 31u + self.startGameCounter;
    hash = hash * 31u + [[NSNumber numberWithDouble:self.startGameDelay] hash];
    hash = hash * 31u + [[NSNumber numberWithDouble:self.gameCounter] hash];
    return hash;
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@:%p", NSStringFromClass([self class]), self];
    [description appendFormat:@"self.config=%@", self.config];
    [description appendFormat:@", self.model=%@", self.model];
    [description appendFormat:@", self.gameState=%ld", self.gameState];
    [description appendFormat:@", self.startGameCounter=%lu", (unsigned long)self.startGameCounter];
    [description appendFormat:@", self.startGameDelay=%f", self.startGameDelay];
    [description appendFormat:@", self.gameCounter=%f", self.gameCounter];
    [description appendString:@">"];
    return description;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    PuzzleViewModel *copy = [[[self class] allocWithZone:zone] init];

    if (copy != nil) {
        copy->_config = _config;
        copy.model = [self.model copy];
        copy.gameState = self.gameState;
        copy.startGameCounter = self.startGameCounter;
        copy.startGameDelay = self.startGameDelay;
        copy.gameCounter = self.gameCounter;
    }

    return copy;
}


+ (instancetype)modelWithConfig:(GameConfig *)config model:(BoardPuzzleModel *)model gameState:(PuzzleGameState)gameState startGameCounter:(NSUInteger)startGameCounter startGameDelay:(float_t)startGameDelay gameCounter:(float_t)gameCounter {
    return [[self alloc] initWithConfig:config
                                  model:model
                              gameState:gameState
                       startGameCounter:startGameCounter
                         startGameDelay:startGameDelay
                            gameCounter:gameCounter];
}


+ (instancetype)modelWithConfig:(GameConfig *)config {
    return [[self alloc] initWithConfig:config];
}

- (BOOL)isLandscape {
    return YES;
}

@end
