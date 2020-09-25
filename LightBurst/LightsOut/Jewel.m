//
//  Jewel.m
//  LightsOut
//
//  Created by Bart Dority on 6/2/13.
//  Copyright (c) 2013 Bart Dority. All rights reserved.
//

#import "Jewel.h"

@implementation Jewel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // This is where we define the gradient
    float hue = (float) self.myColor / 255;
    
    self.jewelColor = [UIColor colorWithHue:hue saturation:.5 brightness:.5 alpha:1];
    self.jewelColorBright = [UIColor colorWithHue:hue saturation:.6 brightness:.8 alpha:1];
    self.jewelColorDull = [UIColor colorWithHue:hue saturation:.5 brightness:.3 alpha:1];
    //struct CGColor *color1 = self.jewelColor.CGColor;
    
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    CGFloat colors[] =
    {
        255.0 / 255.0, 255.0 / 255.0, 255.0 / 255.0, 1.00,
        .5, .25, .25, 1.00,
        0.0 / 255.0,  0.0 / 255.0, 0 / 255.0, 1.00,
    };
    
    
    const CGFloat* components = CGColorGetComponents(self.jewelColor.CGColor);
    
    self.red = components[0];
    self.green = components[1];
    self.blue = components[2];
    self.alpha = components[3];
    
    colors[4] = self.red;
    colors[5] = self.green;
    colors[6] = self.blue;
    colors[7] = self.alpha;
    
    
    components = CGColorGetComponents(self.jewelColorBright.CGColor);
    
    self.red = components[0];
    self.green = components[1];
    self.blue = components[2];
    self.alpha = components[3];
    
    colors[0] = self.red;
    colors[1] = self.green;
    colors[2] = self.blue;
    colors[3] = self.alpha;
    
    components = CGColorGetComponents(self.jewelColorDull.CGColor);
    
    self.red = components[0];
    self.green = components[1];
    self.blue = components[2];
    self.alpha = components[3];
    
    colors[8] = self.red;
    colors[9] = self.green;
    colors[10] = self.blue;
    colors[11] = self.alpha;

    
    
    //CGGradientCreateWithColors(rgb, <#CFArrayRef colors#>, <#const CGFloat *locations#>)
    CGGradientRef gradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
    			
    // Setting up the values for the gradient
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGPoint start = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CGPoint end = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    
    CGFloat r = self.bounds.size.width < self.bounds.size.height ? self.bounds.size.width : self.bounds.size.height;
    CGFloat startRadius =  0;
    CGFloat endRadius = r * .75;
    int options = 2;
    
    // Draw the gradient
    
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:12.0];
    
    [roundedRect addClip];
    CGContextDrawRadialGradient(context, gradient, start, startRadius, end, endRadius, options);
    
    
}


@end
