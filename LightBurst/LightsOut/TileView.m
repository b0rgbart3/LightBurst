//
//  TileView.m
//  LightsOut
//
//  Created by Bart Dority on 5/9/13.
//  Copyright (c) 2013 Bart Dority. All rights reserved.
//

#import "TileView.h"

@implementation TileView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //NSLog(@"TileView width == %f",frame.size.width);
    }
    return self;
}


#define STANDARD_LINE_WIDTH 6


- (void)drawRect:(CGRect)rect
{
    
    float hue = (float) self.color / 255;
    UIColor *glowColor = [UIColor colorWithHue:hue saturation:.6 brightness:.8 alpha:1];
    UIColor *lighterColor = [UIColor colorWithHue:hue saturation:.7 brightness:.9 alpha:1];
    UIColor *brightColor = [UIColor colorWithHue:hue saturation:.7 brightness:.7 alpha:1];//brightBlue;
    UIColor *normalColor = [UIColor colorWithHue:hue saturation:.8 brightness:.35 alpha:1];//Blue;
    UIColor *darkerColor = [UIColor colorWithHue:hue saturation:.9 brightness:.2 alpha:1];
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    CGFloat margin = self.bounds.size.width *.14;
    
    CGFloat left = margin;
    CGFloat top = margin;
    CGFloat right = width-(margin*2);
    CGFloat bottom = height-(margin*2);
    
    CGRect innerGlowBounds = CGRectMake(left, top, right, bottom);
    CGRect solutionIndicator = CGRectMake(margin*2,margin*2,right-(margin*2),bottom-(margin*2));
    
    UIColor *solutionHiColor = [UIColor colorWithHue:hue saturation:.6 brightness:.6 alpha:1];
    UIColor *solutionLoColor = [UIColor colorWithHue:hue saturation:.8 brightness:.7 alpha:1];
    
    if (self.highlighted)
    {
        //[self drawBoxWithColor: lighterColor
          //              stroke: lighterColor
            //            bounds: outerGlowBounds];
        
        [self drawBoxWithColor: brightColor
                                    stroke: normalColor
                                    bounds: self.bounds];
        
        
        [self drawBoxWithColor:glowColor stroke:lighterColor bounds:innerGlowBounds];

        if (self.solutionCell)
        {
            [self drawBoxWithColor: solutionHiColor
                            stroke: solutionHiColor
                            bounds: solutionIndicator];
        }
    }
    else
    {
       
            [self drawBoxWithColor: normalColor
                                    stroke: darkerColor
                                    bounds: self.bounds];
        
        if (self.solutionCell)
        {
            [self drawBoxWithColor: solutionLoColor
                            stroke: solutionLoColor
                            bounds: solutionIndicator];
        }
    }
    
   
    
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
