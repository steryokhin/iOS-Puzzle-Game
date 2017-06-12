//
//  ImageServiceInput.h
//  iOSPuzzleGame
//
//  Created by Sergey Teryokhin on 04/06/2017.
//  Copyright © 2017 imacdev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

///UNUSED
@protocol ImageServiceInput <NSObject>

- (void)splitImage:(UIImage *)image rows:(NSUInteger)rows columns:(NSUInteger)columns;
- (void)mixImages:(NSArray<UIImage *> *)images;

@end
