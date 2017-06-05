//
// Created by Sergey Teryokhin on 04/06/2017.
// Copyright (c) 2017 imacdev. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*
 * Configuration paramethers of the board and of the game
 */
@interface GameConfig : NSObject

/*
 * Path to the image to work use as puzzle pattern
 */
@property (nonatomic, strong, readonly) NSString *imagePath;

/*
 * Count of rows to which we split image
 */
@property (nonatomic, assign, readonly) NSUInteger rowCount;

/*
 * Count or columns to which we split image
 */
@property (nonatomic, assign, readonly) NSUInteger columnCount;

/*
 * Number of counts we backcount before game start
 */
@property (nonatomic, assign, readonly) NSUInteger startGameCounter;

/*
 * Delay in the seconds between start of game and start back counter
 */
@property (nonatomic, assign, readonly) float_t startGameDelay;

/*
 * Duration of the game in the seconds
 */
@property (nonatomic, assign, readonly) float_t gameDuration;

- (instancetype)initWithImagePath:(NSString *)imagePath rowCount:(NSUInteger)rowCount columnCount:(NSUInteger)columnCount startGameCounter:(NSUInteger)startGameCounter startGameDelay:(float_t)startGameDelay gameDuration:(float_t)gameDuration;

- (BOOL)isEqual:(id)other;

- (BOOL)isEqualToConfig:(GameConfig *)config;

- (NSUInteger)hash;

- (NSString *)description;

+ (instancetype)configWithImagePath:(NSString *)imagePath rowCount:(NSUInteger)rowCount columnCount:(NSUInteger)columnCount startGameCounter:(NSUInteger)startGameCounter startGameDelay:(float_t)startGameDelay gameDuration:(float_t)gameDuration;

@end

NS_ASSUME_NONNULL_END
