//
//  panelBox.h
//  LightsOut
//
//  Created by Bart Dority on 2/28/14.
//  Copyright (c) 2014 Bart Dority. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface panelBox : UIView

@property BOOL special;
@property UIColor *smallBoxColor;


- (id)initWithFrame:(CGRect)frame andColor:(UIColor*)smallBoxColor;
-(void) turnOnSmallBox;


@end
