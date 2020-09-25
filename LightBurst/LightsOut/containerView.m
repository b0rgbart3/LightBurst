//
//  containerView.m
//  LightsOut
//
//  Created by Bart Dority on 2/16/14.
//  Copyright (c) 2014 Bart Dority. All rights reserved.
//

#import "containerView.h"



@implementation containerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithLeft:(CGFloat)left top:(CGFloat) top size:(CGFloat) size image:(NSString *) image label:(NSString *) label andHue: (CGFloat) hue
{
    CGPoint viewOrigin = {left-10, top};
    CGSize viewSize = {size + 20,size + 20};
    CGRect frame = {viewOrigin,viewSize};
    
    self = [super initWithFrame:frame];
    if (self) {
        CGPoint buttonOrigin = {10,0};
        CGSize buttonSize = {size,size};
        CGRect buttonFrame = {buttonOrigin, buttonSize};
        
        CGPoint labelOrigin = {0, size};
        CGSize labelSize = {size+20, 20};
        CGRect labelFrame = {labelOrigin,labelSize};
        
        
        _myButton = [[standardButton alloc] initWithFrame:buttonFrame];
       
        UIFont *buttonFont = [UIFont boldSystemFontOfSize:14];
        NSAttributedString *buttonAttributedString;
        NSDictionary *attributes = @{ NSFontAttributeName: buttonFont,      NSForegroundColorAttributeName: [UIColor whiteColor]};
        buttonAttributedString = [[NSAttributedString alloc] initWithString:label attributes:attributes];
        
        //self.backgroundColor = [[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0];
        
        UILabel *buttonViewLabel = [[UILabel alloc] initWithFrame:labelFrame];
        [buttonViewLabel setAttributedText:buttonAttributedString];
        [buttonViewLabel setBackgroundColor:[[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0]];
        [buttonViewLabel setTextAlignment:NSTextAlignmentCenter];
        
        
        //[_myButton setBackgroundColor:[[UIColor alloc]initWithRed:1 green:0 blue:0 alpha:1]];
        
        [self addSubview:_myButton];
        [self addSubview:buttonViewLabel];
        
        UIImage *iconImage = [UIImage imageNamed:image];
        UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:buttonFrame];
        [iconImageView setImage:iconImage];
        
        [self addSubview:iconImageView];
        
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
