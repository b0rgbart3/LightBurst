//
//  StandardButton.h
//  LightBurst
//
//  Created by Bart Dority on 9/21/20.
//

#ifndef StandardButton_h
#define StandardButton_h

#import <UIKit/UIKit.h>

@interface StandardButton : UIButton

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


#endif /* StandardButton_h */
