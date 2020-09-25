//
//  TileBurst.m
//  LightsOut
//
//  Created by Bart Dority on 5/12/13.
//  Copyright (c) 2013 Bart Dority. All rights reserved.
//

#import "TileBurst.h"

@implementation TileBurst



#define STANDARD_LINE_WIDTH 6


- (void)drawRect:(CGRect)rect
{
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    //CGFloat margin = self.bounds.size.width *.2;
    
    //CGFloat left = 0;
    //CGFloat top = 0;
    CGFloat right = width;
    CGFloat bottom = height;
    
    CGRect myBounds = CGRectMake(0, 0, right, bottom);
    
    float hue = (float) self.color / 255;
    UIColor *lighterColor = [UIColor colorWithHue:hue saturation:.4 brightness:.9 alpha:.96];
    
            [self drawBoxWithColor: lighterColor
                            stroke: lighterColor
                            bounds: myBounds];

        
    
}


-(void) drawBoxWithColor: (UIColor*) color
stroke:(UIColor*) stroke
bounds: (CGRect) bounds
{
    float roundedCornerSize = self.bounds.size.width * .2;
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:bounds cornerRadius:roundedCornerSize];
    [roundedRect addClip];
    
    [color setFill];
    UIRectFill(bounds);
    
    roundedRect.lineWidth = self.bounds.size.width *.1; //STANDARD_LINE_WIDTH;
    [stroke setStroke];
    [roundedRect stroke];
}

@end
