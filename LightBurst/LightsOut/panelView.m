//
//  panelView.m
//  LightsOut
//
//  Created by Bart Dority on 2/7/14.
//  Copyright (c) 2014 Bart Dority. All rights reserved.
//

#import "panelView.h"

@implementation panelView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void) drawBoxWithColor: (UIColor*) color
                  stroke:(UIColor*) stroke
                  bounds: (CGRect) bounds
{
    
    [color setFill];
    UIRectFill(bounds);
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //float panelValue = .2;
    //float topPanelValue = .3;
    
    //UIColor *panelColor = [UIColor colorWithRed:topPanelValue green:topPanelValue blue:topPanelValue alpha:1];
    //UIColor *topPanelColor = [UIColor colorWithRed:panelValue  green:panelValue blue:panelValue alpha:1];
    [self drawBoxWithColor: _color2
                    stroke: 0
                    bounds: self.bounds];
    
    CGPoint topleft = {0,0};
    CGSize size = {self.bounds.size.width, self.bounds.size.height*.25};
    CGRect topPanelRect = {topleft, size};
  
    [self drawBoxWithColor:_color1 stroke:0 bounds:topPanelRect];
    
}


@end
