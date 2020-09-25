//
//  Jewel.h
//  LightBurst
//
//  Created by Bart Dority on 9/21/20.
//

#ifndef Jewel_h
#define Jewel_h
#import <UIKit/UIKit.h>

#import "Game.h"

@interface Jewel : UIView

// this is the 0 -> 255 integer color value that we get from the model
@property int myColor;

// this is the UIColor equivalent - based on a preset saturation and brightness
@property UIColor *jewelColor;
@property UIColor *jewelColorBright;
@property UIColor *jewelColorDull;

@property CGFloat red;
@property CGFloat green;
@property CGFloat blue;
@property CGFloat alpha;

@end


#endif /* Jewel_h */
