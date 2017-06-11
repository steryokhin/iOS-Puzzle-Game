//
//  BoardPuzzleModel.h
//  iOSPuzzleGame
//
//  Created by Sergey Teryokhin on 04/06/2017.
//  Copyright © 2017 imacdev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class PuzzlePart;
@class GameConfig;

NS_ASSUME_NONNULL_BEGIN

@interface BoardPuzzleModel : NSObject <NSCopying>

@property (nonatomic, strong) UIImage *originalImage;
@property (nonatomic, strong) NSArray<UIImage *> *originalParts;
@property (nonatomic, strong) NSArray<UIImage *> *parts;

- (instancetype)initWithOriginalImage:(UIImage *)originalImage;

- (instancetype)initWithOriginalImage:(UIImage *)originalImage originalParts:(nullable NSArray<UIImage *> *)originalParts parts:(nullable NSArray<UIImage *> *)parts;

+ (instancetype)modelWithOriginalImage:(UIImage *)originalImage originalParts:(nullable NSArray<UIImage *> *)originalParts parts:(nullable NSArray<UIImage *> *)parts;

- (id)copyWithZone:(nullable NSZone *)zone;

- (BOOL)isEqual:(id)other;

- (BOOL)isEqualToModel:(BoardPuzzleModel *)model;

- (NSUInteger)hash;

- (NSString *)description;

@end

@interface BoardPuzzleModel(helper)

/*
 * Return YES if puzzle solved and NO otherwise
 */
- (BOOL)isSolved;

@end

NS_ASSUME_NONNULL_END
