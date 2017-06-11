//
//  SplitImageService.h
//  iOSPuzzleGame
//
//  Created by Sergey Teryokhin on 11/06/2017.
//  Copyright © 2017 imacdev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageServiceInput.h"
#import "ImageServiceOutput.h"

@interface ImageService : NSObject<ImageServiceInput>

@property (nonatomic, weak) NSObject<ImageServiceOutput> *delegate;

@end
