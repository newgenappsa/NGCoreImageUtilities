//
//  NGCoreImageUtilities.h
//
//  Created by Newgenapps on 12/24/13.
//  Copyright (c) 2013-14 Newgenapps. All rights reserved.
//

/**
  This is a utility class that provides convenient methods to manipulate a 
  UIImage using Core Image framework.
 */

#import <Foundation/Foundation.h>
#import <CoreImage/CoreImage.h>
#import <QuartzCore/QuartzCore.h>

@interface NGCoreImageUtilities : NSObject
{
    
}

/** Rotates the image by the specified degrees. Uses CoreImage */
-(UIImage *)rotateImage:(UIImage *)image  Withdegree:(int)degree ;

/** Flips the image horizontally. Uses CoreImage */
-(UIImage *)flipHorizontal:(UIImage *)image;

/** Returns a UIImage that is the required cropped part 
 of the given image. Uses CoreImage
*/
-(UIImage *)cropImage:(UIImage *)image withRect:(CGRect)rect;

@property (nonatomic,retain) CIContext *context;

@end
