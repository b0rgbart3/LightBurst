//
//  standardButton.h
//  LightsOut
//
//  Created by Bart Dority on 5/9/13.
//  Copyright (c) 2013 Bart Dority. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface standardButton : UIButton

// - -fixing warnings -- @property (nonatomic) BOOL highlighted;
@property BOOL toggledOn;
@property (nonatomic) UIColor *color;
@property (nonatomic) UIColor *strokeColor;
@property (nonatomic) UIColor *highColor;
@property (nonatomic) UIColor *highStrokeColor;

/*
@property CGFloat myRed;
@property CGFloat myGreen;
@property CGFloat myBlue;
@property CGFloat myAlpha;*/


-(void) fadeIn;
-(void) fadeOut;

@end
