//
//  ImageServiceOutput.h
//  iOSPuzzleGame
//
//  Created by Sergey Teryokhin on 04/06/2017.
//  Copyright © 2017 imacdev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ImageServiceInput;

/*
 * Protocol descvribing output methods for the image service
 */
@protocol ImageServiceOutput <NSObject>

- (void)service:(NSObject<ImageServiceInput> *)service splitResult:(NSArray<UIImage *> *)parts originalImage:(UIImage *)originalImage;

- (void)service:(NSObject<ImageServiceInput> *)service mixResult:(NSArray<UIImage *> *)mixedParts withOriginal:(NSArray<UIImage *> *)oritinalParts;

@end
