//
//  jewelButton.m
//  LightsOut
//
//  Created by Bart Dority on 6/2/13.
//  Copyright (c) 2013 Bart Dority. All rights reserved.
//

#import "jewelButton.h"

@implementation jewelButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //NSLog(@"Glow Init.");
        self.jewel = [[Jewel alloc] initWithFrame:self.frame];
        self.jewel.myColor =  self.myColor;
        self.jewel.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0];
    
         [self addSubview:self.jewel];
    }
    return self;
}

-(void) fadeIn
{
    float timerLength = 2;
    self.alpha = 0;
    
    [UIView animateWithDuration:1 animations:^{
        self.alpha = 1;
    }];
    
    
    [NSTimer scheduledTimerWithTimeInterval:timerLength
                                     target:self
                                   selector:@selector(fadeOut)
                                   userInfo:nil
                                    repeats:NO];
}

-(void) fadeOut
{
    self.alpha = 1;
    
    
    [UIView animateWithDuration:1 animations:^{
        self.alpha = 0;
    }];
    
    [NSTimer scheduledTimerWithTimeInterval:1
                                     target:self
                                   selector:@selector(fadeIn)
                                   userInfo:nil
                                    repeats:NO];
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
