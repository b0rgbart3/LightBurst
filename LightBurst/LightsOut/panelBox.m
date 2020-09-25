//
//  panelBox.m
//  LightsOut
//
//  Created by Bart Dority on 2/28/14.
//  Copyright (c) 2014 Bart Dority. All rights reserved.
//

#import "panelBox.h"
#import "helperMethods.h"

/// This panelbox is what creates the 3 rounded rects that come up in the Settings Screen

@implementation panelBox

- (id)initWithFrame:(CGRect)frame andColor:(UIColor*)smallBoxColor
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        if (smallBoxColor)
            self.smallBoxColor = smallBoxColor;
        else
            self.smallBoxColor = [[UIColor alloc] initWithRed:.2 green:.2 blue:.2 alpha:1];
        self.backgroundColor = [[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    UIColor *myColor = [[UIColor alloc] initWithRed:.3 green:.3 blue:.3 alpha:1];
    //UIColor *stroke = [[UIColor alloc] initWithRed:.6 green:.6 blue:.6 alpha:.6];
    
    float bevelSize = self.bounds.size.width * .05;
    
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:bevelSize];
    [roundedRect addClip];
    
    [myColor setFill];
    UIRectFill(self.bounds);
    
    if (self.special)
    {
        [self turnOnSmallBox];
    }
    //roundedRect.lineWidth = self.bounds.size.width *.0125; //BOX stroke width
    //[stroke setStroke];
    //[roundedRect stroke];

}

//  This puts a darker gray box towards the bottom of the panelBox -- which is used for the
//  Difficulty section of the settings screen, to delineate the Sequence Length# from the Difficulty #.

-(void) turnOnSmallBox
{
    UIColor *myColor = self.smallBoxColor; //[[UIColor alloc] initWithRed:.2 green:.2 blue:.2 alpha:1];
    [myColor setFill];
    
    CGRect myFrame = CGRectMake(0, self.bounds.size.height-45, self.bounds.size.width, 50);
    
    UIRectFill(myFrame);
    [self setNeedsDisplay];
    
}


@end
