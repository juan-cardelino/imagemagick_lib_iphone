#!/bin/bash

armflags () {
	export ARM_CC=$(xcrun -find -sdk iphoneos clang)
	export ARM_CXX=$(xcrun -find -sdk iphoneos clang++)
	export ARM_LD=$(xcrun -find -sdk iphoneos ld)

	export ARM_CFLAGS="-arch $1"
	export ARM_CFLAGS="$ARM_CFLAGS -I$IOSSDKROOT/usr/include"
	export ARM_CFLAGS="$ARM_CFLAGS -isysroot $IOSSDKROOT"
	export ARM_CFLAGS="$ARM_CFLAGS -miphoneos-version-min=$SDKVER"
	export ARM_LDFLAGS="-arch $1 -isysroot $IOSSDKROOT"
	export ARM_LDFLAGS="$ARM_LDFLAGS"
	
	export ARM_CFLAGS="$ARM_CFLAGS -O3"
	# uncomment this line if you want debugging stuff
	# export ARM_CFLAGS="$ARM_CFLAGS -O0 -g"
	
	# apply ARM_XX values
	export CC="$ARM_CC"
	export CXX="$ARM_CXX"
	export CFLAGS="$ARM_CFLAGS"
	export CXXFLAGS="$ARM_CFLAGS" #-std=libstdc++ #for Magick++ (by JUANC)
	export LD="$ARM_LD"
	export LDFLAGS="$ARM_LDFLAGS" #-std=libstdc++
	
	# export what we are building for
	export BUILDINGFOR="$1"
}

intelflags () {
	#this section cross-compiles for simulator, it is important to use SIMSDKROOT instead of IOSSDKROOT
	export INTEL_CC=$(xcrun -find -sdk iphonesimulator clang)
	export INTEL_CXX=$(xcrun -find -sdk iphonesimulator clang++)
	export INTEL_LD=$(xcrun -find -sdk iphonesimulator ld)
	
	export INTEL_CFLAGS="-arch $1 -isysroot $SIMSDKROOT -miphoneos-version-min=$SDKVER"
	export INTEL_CFLAGS="$INTEL_CFLAGS -I$SIMSDKROOT/usr/include"
	export INTEL_LDFLAGS="-arch $1 -isysroot $IOSSDKROOT"

	# apply INTEL_CC values
	export CC="$INTEL_CC"
	export CXX="$INTEL_CXX "
	export CCP="$INTEL_CC -E"
	export CFLAGS="$INTEL_CFLAGS"
	export CPPFLAGS="$INTEL_CFLAGS"
	export CXXFLAGS="$INTEL_CFLAGS" #-std=libstdc++#for Magick++ (by JUANC)
	export LD="$INTEL_LD" #-std=libstdc++
	export LDFLAGS="-L$SIMSDKROOT/usr/lib"	#this is important to set, if not configure will link against system libraries and fail
 	
	# export what we are building for
	export BUILDINGFOR="$1"
}

save() {
	export OLD_CC="$CC"
	export OLD_CFLAGS="$CFLAGS"
	export OLD_LDFLAGS="$LDFLAGS"
	export OLD_CPP="$CPP"
}

restore () {
	export CC="$OLD_CC"
	export CFLAGS="$OLD_CFLAGS"
	export LDFLAGS="$OLD_LDFLAGS"
	export CPP="$OLD_CPP"
}
