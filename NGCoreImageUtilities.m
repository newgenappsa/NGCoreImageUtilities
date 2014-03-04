//
//  NGCoreImageUtilities.m
//
//  Created by Newgenapps on 12/24/13.
//  Copyright (c) 2013-14 Newgenapps. All rights reserved.
//

#import "NGCoreImageUtilities.h"
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface NGCoreImageUtilities() {

}

@end


@implementation NGCoreImageUtilities

-(UIImage *)rotateImage:(UIImage *)image  Withdegree:(int)degree 
{
    if (self.context == nil) {
        self.context = [CIContext contextWithOptions:nil];
        
    }
    
    CIImage *ciImage = [CIImage imageWithCGImage:[image CGImage]];;
     CIFilter *filter = [CIFilter filterWithName:@"CIAffineTransform"];
    [filter setValue:ciImage forKey:kCIInputImageKey];
    NSValue *value = [NSValue valueWithCGAffineTransform:CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(degree))];
    [filter setValue:value forKey:@"inputTransform"];
    CIImage *outoputCIImage = [filter outputImage];
    
    CGImageRef  outputRef = [self.context createCGImage:outoputCIImage fromRect:[outoputCIImage extent]];
    UIImage *filteredImage = [UIImage imageWithCGImage:outputRef scale:image.scale orientation:UIImageOrientationUp];
    CGImageRelease(outputRef);
    return filteredImage;
    
}

-(UIImage *)flipHorizontal:(UIImage *)image
{
    if (self.context == nil) {
        self.context = [CIContext contextWithOptions:nil];
    }
    CIImage *ciImage = [CIImage imageWithCGImage:[image CGImage]];
     CIFilter *filter = [CIFilter filterWithName:@"CIAffineTransform"];
    [filter setValue:ciImage forKey:kCIInputImageKey];
    NSValue *value = [NSValue valueWithCGAffineTransform:CGAffineTransformMakeScale(-1, 1)];
    [filter setValue:value forKey:@"inputTransform"];
    CGImageRef  outputRef = [self.context createCGImage:[filter outputImage] fromRect:[[filter outputImage] extent]];
    UIImage *outputImage = [UIImage imageWithCGImage:outputRef];
    CGImageRelease(outputRef);
    ciImage = nil;
    filter = nil;
    return outputImage;
}

-(UIImage *)cropImage:(UIImage *)image withRect:(CGRect)rect
{
    if (self.context == nil) {
        self.context = [CIContext contextWithOptions:nil];
    }
    CIImage *ciImage = [CIImage imageWithCGImage:[image CGImage]];
    CIFilter *cropFilter = [CIFilter filterWithName:@"CICrop"];
    [cropFilter setValue:ciImage forKey:kCIInputImageKey];
    
    CIVector *vector = [CIVector vectorWithX:rect.origin.x Y:image.size.height - (rect.origin.y+rect.size.height) Z:rect.size.width W:rect.size.height];
    [cropFilter setValue:vector forKey:@"inputRectangle"];
    CGImageRef  outputRef = [self.context createCGImage:[cropFilter outputImage] fromRect:[[cropFilter outputImage] extent]];
    UIImage *filteredOutput = [UIImage imageWithCGImage:outputRef];
    CGImageRelease(outputRef);
    cropFilter = nil;
    vector = nil;
    return filteredOutput;
}

-(float)convertUIKitCoToCoreImageCo:(float)y inRect:(CGRect )rect
{
    return rect.size.height-y;
}



@end
