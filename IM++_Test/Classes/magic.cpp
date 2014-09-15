//
//  magic.cpp
//  IM_Test
//
//  Created by Juan Cardelino on 9/14/14.
//
//

#include "magic.h"

#define MAGICKCORE_QUANTUM_DEPTH 8
#include "Magick++/Image.h"
#include <iostream>
using namespace std;
using namespace Magick;
int hola()
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
