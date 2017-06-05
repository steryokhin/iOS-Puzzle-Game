//
// Created by Sergey Teryokhin on 04/06/2017.
// Copyright (c) 2017 imacdev. All rights reserved.
//

#import "GameConfig.h"


@implementation GameConfig {

}
- (instancetype)initWithImagePath:(NSString *)imagePath rowCount:(NSUInteger)rowCount columnCount:(NSUInteger)columnCount startGameCounter:(NSUInteger)startGameCounter startGameDelay:(float_t)startGameDelay gameDuration:(float_t)gameDuration {
    self = [super init];
    if (self) {
        _imagePath = imagePath;
        _rowCount = rowCount;
        _columnCount = columnCount;
        _startGameCounter = startGameCounter;
        _startGameDelay = startGameDelay;
        _gameDuration = gameDuration;
    }

    return self;
}

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![[other class] isEqual:[self class]])
        return NO;

    return [self isEqualToConfig:other];
}

- (BOOL)isEqualToConfig:(GameConfig *)config {
    if (self == config)
        return YES;
    if (config == nil)
        return NO;
    if (self.imagePath != config.imagePath && ![self.imagePath isEqualToString:config.imagePath])
        return NO;
    if (self.rowCount != config.rowCount)
        return NO;
    if (self.columnCount != config.columnCount)
        return NO;
    if (self.startGameCounter != config.startGameCounter)
        return NO;
    if (self.startGameDelay != config.startGameDelay)
        return NO;
    if (self.gameDuration != config.gameDuration)
        return NO;
    return YES;
}

- (NSUInteger)hash {
    NSUInteger hash = [self.imagePath hash];
    hash = hash * 31u + self.rowCount;
    hash = hash * 31u + self.columnCount;
    hash = hash * 31u + self.startGameCounter;
    hash = hash * 31u + [[NSNumber numberWithDouble:self.startGameDelay] hash];
    hash = hash * 31u + [[NSNumber numberWithDouble:self.gameDuration] hash];
    return hash;
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@:%p", NSStringFromClass([self class]), self];
    [description appendFormat:@"self.imagePath=%@", self.imagePath];
    [description appendFormat:@", self.rowCount=%lu", (unsigned long)self.rowCount];
    [description appendFormat:@", self.columnCount=%lu", (unsigned long)self.columnCount];
    [description appendFormat:@", self.startGameCounter=%lu", (unsigned long)self.startGameCounter];
    [description appendFormat:@", self.startGameDelay=%f", self.startGameDelay];
    [description appendFormat:@", self.gameDuration=%f", self.gameDuration];
    [description appendString:@">"];
    return description;
}


+ (instancetype)configWithImagePath:(NSString *)imagePath rowCount:(NSUInteger)rowCount columnCount:(NSUInteger)columnCount startGameCounter:(NSUInteger)startGameCounter startGameDelay:(float_t)startGameDelay gameDuration:(float_t)gameDuration {
    return [[self alloc] initWithImagePath:imagePath rowCount:rowCount columnCount:columnCount startGameCounter:startGameCounter startGameDelay:startGameDelay gameDuration:gameDuration];
}

@end
