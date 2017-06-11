//
//  SplitImageService.m
//  iOSPuzzleGame
//
//  Created by Sergey Teryokhin on 11/06/2017.
//  Copyright © 2017 imacdev. All rights reserved.
//

#import "ImageService.h"
#import "UIImage+Splitter.h"
#import "ImageServiceOutput.h"

@implementation ImageService

- (void)splitImage:(UIImage *)image rows:(NSUInteger)rows columns:(NSUInteger)columns {
    NSArray *images = [image splitWithNumberOfRows:rows columns:columns];

    if ([self.delegate conformsToProtocol:@protocol(ImageServiceOutput)]) {
        [self.delegate service:self splitResult:images originalImage:image];
    }
}

- (void)mixImages:(NSArray<UIImage *> *)images {

}


@end
