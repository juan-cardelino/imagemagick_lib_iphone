//
//  OpenCVProcessing.m
//  ARDemo
//
//  Created by Javier Preciozzi on 10/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UImageToBuffer.h"

@implementation UImageToBuffer

    
/** 
Given a UIImage, it returns the corresponding buffer plus width, height
 Caller is responsible of rel
 */
+ (unsigned char *)CreateBufferFromUIImage:(UIImage *)image with:(int *)w height:(int *)h bytesperpixel:(int *)bpp {
    
  // First get the image into your data buffer
  CGImageRef imageRef = [image CGImage];
  NSUInteger width = CGImageGetWidth(imageRef);
  NSUInteger height = CGImageGetHeight(imageRef);
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  unsigned char *rawData = malloc(height * width * 4);
  NSUInteger bytesPerPixel = 4;
  NSUInteger bytesPerRow = bytesPerPixel * width;
  NSUInteger bitsPerComponent = 8;
  CGContextRef context = CGBitmapContextCreate(rawData, width, height,
                                               bitsPerComponent, bytesPerRow, colorSpace,
                                               kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
  CGColorSpaceRelease(colorSpace);
  
  CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
  CGContextRelease(context);
  
           
  *w = width;
  *h = height;
  *bpp = bytesPerPixel;
  
  return (rawData);        
}



+ (uint8_t *)CreateBufferFromCMSampleBuffer:(CMSampleBufferRef)sampleBuffer with:(int *)w height:(int *)h bytesPerRow:(size_t *) bbr {
  
  // this is the image buffer
  CVImageBufferRef cvimgRef = CMSampleBufferGetImageBuffer(sampleBuffer);
  
  // Lock the image buffer
  CVPixelBufferLockBaseAddress(cvimgRef,0);
  // access the data
  *w=CVPixelBufferGetWidth(cvimgRef);
  *h=CVPixelBufferGetHeight(cvimgRef);

  // get the raw image bytes
  uint8_t *buf=(uint8_t *) CVPixelBufferGetBaseAddress(cvimgRef);
  *bbr=CVPixelBufferGetBytesPerRow(cvimgRef);
  
  return(buf);  
}


@end
