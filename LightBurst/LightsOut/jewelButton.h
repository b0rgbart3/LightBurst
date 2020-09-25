//
//  jewelButton.h
//  LightsOut
//
//  Created by Bart Dority on 6/2/13.
//  Copyright (c) 2013 Bart Dority. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Jewel.h"

@interface jewelButton : UIButton

@property Jewel *jewel;
@property int myColor;

-(void) fadeIn;
-(void) fadeOut;

@end
