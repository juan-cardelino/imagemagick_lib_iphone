//
//  magic.h
//  IM_Test
//
//  Created by Juan Cardelino on 9/14/14.
//
//

#ifndef __IM_Test__magic__
#define __IM_Test__magic__

#define MAGICKCORE_QUANTUM_DEPTH 8
#include "Magick++/Image.h"
#include "Magick++/Pixels.h"
#include <iostream>
using namespace std;
using namespace Magick;

#include <iostream>

/**
 This class stores a Magick++ image and converts back and forth from it to a raw pointer. It also performs an example processing. It works as a singleton.
 */
class MagickProcessing
{
public:
	int hola();
	Image*  raw2magick(unsigned char* im, int w, int h, int bytesPerPixel);
	unsigned char* magick2raw(Image* in, int &w, int &h, int &bytesPerPixel);
	void process();
	Image* m_im;

};
#endif /* defined(__IM_Test__magic__) */
