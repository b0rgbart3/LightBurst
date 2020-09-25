//
//  TileCell.m
//  LightsOut
//
//  Created by Bart Dority on 5/9/13.
//  Copyright (c) 2013 Bart Dority. All rights reserved.
//

#import "TileCell.h"

@implementation TileCell


-(void) updateWithHighlight:(BOOL)highlight color:(NSInteger)color andPartOfTheSolution:(BOOL)solutionCell
{
    [self setOn:highlight];
    
    [self setColor:color];
    
    [self setSolutionCell:solutionCell];
    self.tileBurstView.alpha = 0;
    
}

-(void) setOn:(BOOL) on
{
    self.tileView.highlighted = on;
    //[self setBursting:NO];
    [self.tileView setNeedsDisplay];
}
 

-(void) setSolutionCell:(BOOL)solution
{
    self.tileView.solutionCell = solution;
    [self.tileView setNeedsDisplay];
    
}


-(void) setColor:(NSInteger)color
{
    self.tileView.color = color;
    self.tileBurstView.color = color;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CGRect smallerFrame = CGRectMake(.01, .01, frame.size.width-.01, frame.size.height-.01);
        
        self.tileView = [[TileView alloc] initWithFrame:smallerFrame];
        self.tileBurstView = [[TileBurst alloc] initWithFrame:smallerFrame];
        [self addSubview:self.tileView];
        [self addSubview:self.tileBurstView];
        //UIColor *testColor = [[UIColor alloc] initWithRed:1 green:0 blue:0 alpha:.4];
        //self.backgroundColor = testColor;
        //NSLog(@"In Cell Init: size==%f",frame.size.height);
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
