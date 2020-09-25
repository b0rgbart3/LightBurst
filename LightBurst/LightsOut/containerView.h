//
//  containerView.h
//  LightsOut
//
//  Created by Bart Dority on 2/16/14.
//  Copyright (c) 2014 Bart Dority. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "standardButton.h"

@interface containerView : UIView

@property standardButton *myButton;

- (id)initWithLeft:(CGFloat)left top:(CGFloat) top size:(CGFloat) size image:(NSString *) image label:(NSString *) label andHue: (CGFloat) hue;


@end
