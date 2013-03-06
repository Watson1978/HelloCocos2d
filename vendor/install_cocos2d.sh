#!/bin/sh

curl -O http://cocos2d-iphone.googlecode.com/files/cocos2d-iphone-2.1-rc0a.tar.gz
tar xzf cocos2d-iphone-2.1-rc0a.tar.gz

# build cocos2d-iphone
cd cocos2d-iphone-2.1-rc0a
xcodebuild -project cocos2d-ios.xcodeproj -arch armv6 -arch armv7 -arch armv7s
xcodebuild -project cocos2d-ios.xcodeproj -sdk iphonesimulator

cd ..
mkdir -p cocos2d-iphone/libs

# make universal binaries
IPHONE=cocos2d-iphone-2.1-rc0a/build/Release-iphoneos
SIMULATOR=cocos2d-iphone-2.1-rc0a/build/Release-iphonesimulator
OUTPUT=cocos2d-iphone/libs
lipo -create $IPHONE/libbox2d.a              $SIMULATOR/libbox2d.a              -output $OUTPUT/libbox2d.a
lipo -create $IPHONE/libChipmunk.a           $SIMULATOR/libChipmunk.a           -output $OUTPUT/libChipmunk.a
lipo -create $IPHONE/libcocos2d_box2d.a      $SIMULATOR/libcocos2d_box2d.a      -output $OUTPUT/libcocos2d_box2d.a
lipo -create $IPHONE/libcocos2d_chipmunk.a   $SIMULATOR/libcocos2d_chipmunk.a   -output $OUTPUT/libcocos2d_chipmunk.a
lipo -create $IPHONE/libcocos2d.a            $SIMULATOR/libcocos2d.a            -output $OUTPUT/libcocos2d.a
lipo -create $IPHONE/libCocosBuilderReader.a $SIMULATOR/libCocosBuilderReader.a -output $OUTPUT/libCocosBuilderReader.a
lipo -create $IPHONE/libCocosDenshion.a      $SIMULATOR/libCocosDenshion.a      -output $OUTPUT/libCocosDenshion.a
lipo -create $IPHONE/libjsbindings.a         $SIMULATOR/libjsbindings.a         -output $OUTPUT/libjsbindings.a
lipo -create $IPHONE/libkazmath.a            $SIMULATOR/libkazmath.a            -output $OUTPUT/libkazmath.a

# copy header files
cp -R cocos2d-iphone-2.1-rc0a/cocos2d cocos2d-iphone/Headers
cp -R cocos2d-iphone-2.1-rc0a/external/kazmath/include/kazmath cocos2d-iphone/Headers/kazmath
find cocos2d-iphone -name "*.c" -delete
find cocos2d-iphone -name "*.m" -delete
find cocos2d-iphone -name "*.mm" -delete
