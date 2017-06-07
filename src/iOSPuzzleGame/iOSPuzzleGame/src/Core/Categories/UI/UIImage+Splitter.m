//
//  UIImage+Splitter.m
//  iOSPuzzleGame
//
//  Created by Sergey Teryokhin on 06/06/2017.
//  Copyright © 2017 imacdev. All rights reserved.
//

#import "UIImage+Splitter.h"

@implementation UIImage (Splitter)

- (NSArray *) splitWithNumberOfRows:(NSUInteger)rows columns:(NSUInteger)columns {
    float scale = 1.0;//[[UIScreen mainScreen] scale];
    
    float height = self.size.height * scale;
    float width  = self.size.width * scale;
    
    NSMutableArray *subImages = [NSMutableArray array];
    
    for(int y = 0; y < rows; y++) {
        for(int x = 0; x < columns; x++) {
            CGRect frame = CGRectMake((width/columns) * x,
                                      (height/rows) * y,
                                      (width/columns),
                                      (height/rows));
            
            CGImageRef subimageRef = CGImageCreateWithImageInRect(self.CGImage, frame);
            UIImage* subImage = [UIImage imageWithCGImage:subimageRef scale:scale orientation:UIImageOrientationUp];
//            CFRelease(subimageRef);
            
            [subImages addObject:subImage];
        }
    }
    
    return subImages;
}

@end
