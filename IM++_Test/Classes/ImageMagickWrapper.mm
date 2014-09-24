//
//  ImageMagickWrapper.m
//  IM_Test
//
//  Created by Juan Cardelino on 9/15/14.
//
//

#import "ImageMagickWrapper.h"
#include "magic.h"
#import "UImageToBuffer.h"

@implementation ImageMagickWrapper

+ (UIImage*)test:(UIImage*)im {
	NSLog(@"calling magick++");


	return im;
}

-(MagickProcessing*)getMagickProcessing
{
	MagickProcessing* mp;
	if(!m_mp)
	{
		m_mp=new MagickProcessing();
		mp=(MagickProcessing*)m_mp;
	}else
		mp=(MagickProcessing*)m_mp;
	return mp;
}

- (void)setImage:(UIImage*)im{

	MagickProcessing* mp=[self getMagickProcessing];

	int width;
	int height;
	int bytesPerPixel;

	// rawData must be free after using it
	unsigned char *rawData = [UImageToBuffer CreateBufferFromUIImage:im with:&width height:&height  bytesperpixel: &bytesPerPixel];

	mp->m_im=mp->raw2magick(rawData, width, height, bytesPerPixel);

	free(rawData);

}

/**
This method creates a Magick++ image and converts it to an UIImage. It serves as a test for getImage
 */
- (UIImage*)createUIImageFromMagick
{
	Color color_red(MaxRGB, 0, 0, 1);
	Magick::Image* red=new Magick::Image(Geometry(640, 480), color_red);

	MagickProcessing* mp=[self getMagickProcessing];
	mp->m_im=red;
	UIImage* im=[self getImage];
	return im;
}

/**
 This method assumes a preexisting Magick++ image and converts it to an UIImage.
 */
- (UIImage*)getImage{

	int width;
	int height;
	int bytesPerPixel;
	int bytesPerRow;
	unsigned char* ptrPixels;

	MagickProcessing* mp=[self getMagickProcessing];

	ptrPixels=mp->magick2raw(mp->m_im, width, height,bytesPerPixel);
	int length=width*height*bytesPerPixel;
	bytesPerRow=bytesPerPixel*width;
	int bitsPerComponent=mp->m_im->depth();
	int bitsPerPixel=bitsPerComponent*bytesPerPixel;

	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	NSData *data = [NSData dataWithBytes:ptrPixels length:length];
	CGDataProviderRef provider = CGDataProviderCreateWithCFData((CFDataRef)data);
	CGImageRef imageRef = CGImageCreate(width, height,
													bitsPerComponent, bitsPerPixel, bytesPerRow,
													colorSpace, kCGImageAlphaNone|kCGBitmapByteOrderDefault,
													provider, NULL, false, kCGRenderingIntentDefault);

	UIImage *ret = [UIImage imageWithCGImage:imageRef];

	// Se libera todo lo utilizado
	CGImageRelease(imageRef);
	CGDataProviderRelease(provider);
	CGColorSpaceRelease(colorSpace);
	
	return ret;
}

- (void)process{
	MagickProcessing* mp=[self getMagickProcessing];
	mp->process();
}
@end
