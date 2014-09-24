//
//  ImageMagickWrapper.h
//  IM_Test
//
//  Created by Juan Cardelino on 9/15/14.
//
//

#import <Foundation/Foundation.h>

@interface ImageMagickWrapper : NSObject{

void *m_mp;
}

+(UIImage*)test:(UIImage*)im;
- (void)setImage:(UIImage*)im;
- (UIImage*)createUIImageFromMagick;
- (UIImage*)getImage;
- (void)process;

@end
