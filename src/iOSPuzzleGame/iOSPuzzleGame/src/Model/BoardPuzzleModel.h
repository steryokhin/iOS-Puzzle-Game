//
//  BoardPuzzleModel.h
//  iOSPuzzleGame
//
//  Created by Sergey Teryokhin on 04/06/2017.
//  Copyright © 2017 imacdev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class GameConfig;

NS_ASSUME_NONNULL_BEGIN

/*
 * Class with properties to describe the board
 */
@interface BoardPuzzleModel : NSObject <NSCopying>

/*
 * Original image from which we take the parts
 */
@property (nonatomic, strong) UIImage *originalImage;

/*
 * Original parts with right order
 */
@property (nonatomic, strong) NSArray<UIImage *> *originalParts;

/*
 * Parts in order which is visible for the user on the screen
 */
@property (nonatomic, strong) NSArray<UIImage *> *parts;

/*
 * Initialiser with original image.
 */
- (instancetype)initWithOriginalImage:(UIImage *)originalImage;

- (instancetype)initWithOriginalImage:(UIImage *)originalImage originalParts:(nullable NSArray<UIImage *> *)originalParts parts:(nullable NSArray<UIImage *> *)parts;

+ (instancetype)modelWithOriginalImage:(UIImage *)originalImage originalParts:(nullable NSArray<UIImage *> *)originalParts parts:(nullable NSArray<UIImage *> *)parts;

- (id)copyWithZone:(nullable NSZone *)zone;

- (BOOL)isEqual:(id)other;

- (BOOL)isEqualToModel:(BoardPuzzleModel *)model;

- (NSUInteger)hash;

- (NSString *)description;

@end


NS_ASSUME_NONNULL_END
