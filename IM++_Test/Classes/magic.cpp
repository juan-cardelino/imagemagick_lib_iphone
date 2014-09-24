//
//  magic.cpp
//  IM_Test
//
//  Created by Juan Cardelino on 9/14/14.
//
//

#include "magic.h"



int MagickProcessing::hola()
{
	try {
		cout<<"hola"<<endl;
		//InitializeMagick(NULL);
		// Create an image object and read an image
		Color color_red(MaxRGB, 0, 0, 1);
		Magick::Image red(Geometry(640, 480), color_red);

		// Crop the image to specified size
		// (Geometry implicitly initialized by char *)
		red.crop("100x100+100+100" );

		//image.display();

		// Write the image to a file
		//image.write( argv[2] );

	}
	catch( Exception &error_ )
   {
		cout << "Caught exception: " << error_.what() << endl;
		return 1;
   }
	return 0;
}

Image* MagickProcessing::raw2magick(unsigned char* im, int w, int h, int bytesPerPixel)
{
	// Create an image object and read an image
	Color color_red(MaxRGB, 0, 0, 1);
	Magick::Image* im2= new Magick::Image(Geometry(w, h), color_red);


	int bytesPerRow = bytesPerPixel * w;

	int byteIndex;

	im2->modifyImage();
	Magick::Pixels imview(*im2);
	PixelPacket *impix = imview.get(0,0,w,h);

	for(int yy=0; yy<h; yy++)
	{
		for(int xx=0;xx<w;xx++)
		{
			byteIndex = (bytesPerRow * yy) + xx * bytesPerPixel;

			impix->red = im[byteIndex+0];
			impix->green = im[byteIndex + 1];
			impix->blue = im[byteIndex + 2];
			impix->opacity = im[byteIndex + 3];
			impix++;

		}
	}

	imview.sync();

	im2->syncPixels();


	return im2;
}

unsigned char* MagickProcessing::magick2raw(Image* in, int &w, int &h, int &bytesPerPixel)
{
	Geometry size=in->size();

	w=size.width();
	h=size.height();

	int byteIndex;
	int channels=4;
	bytesPerPixel=channels;
	int bytesPerRow = bytesPerPixel * w;
	printf("bytesPerPixel: %d depth: %zd",bytesPerPixel,in->depth());

	in->modifyImage();
	Magick::Pixels imview(*in);
	PixelPacket *impix = imview.get(0,0,w,h);
	unsigned char* out=(unsigned char*) malloc(w*h*bytesPerPixel*sizeof(*out));
	for(int yy=0; yy<h; yy++)
	{
		for(int xx=0;xx<w;xx++)
		{
			byteIndex = (bytesPerRow * yy) + xx * bytesPerPixel;

			out[byteIndex+0]=impix->red;
			out[byteIndex + 1]=impix->green ;
			out[byteIndex + 2]=impix->blue ;
			out[byteIndex + 3]=impix->opacity ;
			impix++;

		}
	}

	return out;
}

void MagickProcessing::process()
{
	m_im->flop();
}

