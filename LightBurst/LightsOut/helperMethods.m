//
//  helperMethods.m
//  miniCalc
//
//  Created by Bart Dority on 3/3/13.
//  Copyright (c) 2013 Bart Dority. All rights reserved.
//

#import "helperMethods.h"
#import "standardButton.h"



@implementation helperMethods


+(void) drawBoxWithColor: (UIColor*) color
                     stroke:(UIColor*) stroke
                     bounds: (CGRect) bounds
{
    float bevelSize = bounds.size.width * .2;
    
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:bounds cornerRadius:bevelSize];
    [roundedRect addClip];
    
    [color setFill];
    UIRectFill(bounds);
    
    roundedRect.lineWidth = bounds.size.width *.1; //BUTTON_LINE_WIDTH;
    [stroke setStroke];
    [roundedRect stroke];
}

/*
+(void) changeTextColorOfButton: (UIButton *) thisButton to:(UIColor*) newColor forState: (UIControlState) state
{
    NSMutableAttributedString* myFaceString =
    [[thisButton attributedTitleForState:state] mutableCopy];
    
    NSRange range = [[myFaceString string] rangeOfString:[myFaceString string]];
    [myFaceString addAttributes:@{ NSForegroundColorAttributeName: newColor} range:range];
    
    [thisButton setAttributedTitle:myFaceString forState:state];
}*/


/*
    Note, icon buttons use a UIView to contain both the button, and a larger frame which will include a UILabel,
    that sits below the button.  (whereas in a standard button, the uilabel is just part of the button, and sits inside it.
*/
/*
+(containerView *) createAnIconButton: (NSString *) string at:(float)left and:(float) top ofSize:(float) size withImage:(NSString *) image withColor: (UIColor *) color
{
    CGPoint buttonOrigin = {10,0};
    CGSize buttonSize = {size,size};
    CGRect buttonFrame = {buttonOrigin, buttonSize};
    
    CGPoint buttonViewOrigin = {left-10, top};   // the button view needs to be slighty larger than the button
    CGSize buttonViewSize = {size + 20, size + 20};
    CGRect buttonViewFrame = {buttonViewOrigin, buttonViewSize};
    
    CGPoint labelOrigin = {0, size};
    CGSize labelSize = {size+20, 20};
    CGRect labelFrame = {labelOrigin,labelSize};
    
    standardButton *button;
    containerView *buttonView;

    //NSLog(@"Creating an Icon Button at: %f, %f, of size: %f, with image name:%@", left, top, size, image);
    
    button = [[standardButton alloc] initWithFrame:buttonFrame];
    //[button setColor:color];
    UIFont *buttonFont = [UIFont boldSystemFontOfSize:14];
    NSAttributedString *buttonAttributedString;
    NSDictionary *attributes = @{ NSFontAttributeName: buttonFont,      NSForegroundColorAttributeName: [UIColor whiteColor]};
    buttonAttributedString = [[NSAttributedString alloc] initWithString:string attributes:attributes];
    
    buttonView = [[containerView alloc] initWithFrame:buttonViewFrame];
    buttonView.backgroundColor = [[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0];
    
   UILabel *buttonViewLabel = [[UILabel alloc] initWithFrame:labelFrame];
    [buttonViewLabel setAttributedText:buttonAttributedString];
    [buttonViewLabel setBackgroundColor:[[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0]];
    [buttonViewLabel setTextAlignment:NSTextAlignmentCenter];
    
    buttonView.myButton = button;
    
    [button setBackgroundColor:[[UIColor alloc]initWithRed:1 green:0 blue:0 alpha:1]];
    
    [buttonView addSubview:button];
    [buttonView addSubview:buttonViewLabel];
    
    UIImage *iconImage = [UIImage imageNamed:image];
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:buttonFrame];
    [iconImageView setImage:iconImage];
    
    [buttonView addSubview:iconImageView];
    
    
    return buttonView;
}*/


+(UIButton *) createAButton: (NSString *) string at:(float) left and:(float) top ofWidth:(float) width andHeight: (float) height 
{
    CGPoint buttonOrigin = {left,top};
    CGSize buttonSize = {width,height};
    CGRect frame = {buttonOrigin, buttonSize};
    standardButton *button;

    button = [[standardButton alloc] initWithFrame:frame];
    UIFont *buttonFont = [UIFont boldSystemFontOfSize:15];
    NSAttributedString *buttonAttributedString;
    NSDictionary *attributes = @{ NSFontAttributeName: buttonFont, NSForegroundColorAttributeName: [UIColor whiteColor]};
    buttonAttributedString = [[NSAttributedString alloc] initWithString:string attributes:attributes];
        
    [button setAttributedTitle:buttonAttributedString forState:UIControlStateNormal];
    
    
    return button;
}

+(UILabel *) createALabel: (NSString *) string ofSize: (float) labelSize withFrame:(CGRect)labelFrame
{
    UILabel *newLabel = [[UILabel alloc] initWithFrame:labelFrame];
    UIFont *labelFont = [UIFont boldSystemFontOfSize:labelSize];
    NSAttributedString *labelAttributedString;
    NSDictionary *attributes = @{ NSFontAttributeName: labelFont, NSForegroundColorAttributeName: [UIColor whiteColor]};
    labelAttributedString = [[NSAttributedString alloc] initWithString:string attributes:attributes];
    
    UIColor *transparentColor = [[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0];
    
    [newLabel setAttributedText:labelAttributedString];
    
    [newLabel setBackgroundColor:transparentColor];
    return newLabel;
    
}


@end
