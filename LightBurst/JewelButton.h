//
//  JewelButton.h
//  LightBurst
//
//  Created by Bart Dority on 9/21/20.
//

#ifndef JewelButton_h
#define JewelButton_h


#import <UIKit/UIKit.h>
#import "Jewel.h"

@interface jewelButton : UIButton

@property Jewel *jewel;
@property int myColor;

-(void) fadeIn;
-(void) fadeOut;

@end


#endif /* JewelButton_h */
