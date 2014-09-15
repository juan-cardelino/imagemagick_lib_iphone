/*======================================================== 
 Program:	Trauma Simulator
 Date:		23/01/2012
 Version:	1.0 
 Authors:	Javier Preciozzi 
 
 
 This software is distributed WITHOUT ANY WARRANTY; without even
 the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 
 
 File Description: 
 This file contains the declaration of class "UImageToBuffer"
 =========================================================*/ 

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


  /** 
   This class implements a conversion between UImage to a (char *) buffer 
   */
@interface UImageToBuffer : NSObject {
    
}
+ (unsigned char *)CreateBufferFromUIImage:(UIImage *)image with:(int *)w height:(int *)h bytesperpixel:(int *)bpp ; 

+ (uint8_t *)CreateBufferFromCMSampleBuffer:(CMSampleBufferRef)sampleBuffer with:(int *)w height:(int *)h bytesPerRow:(size_t *) bbr;

@end