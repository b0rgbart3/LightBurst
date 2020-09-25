//
//  TileView.h
//  LightsOut
//
//  Created by Bart Dority on 5/9/13.
//  Copyright (c) 2013 Bart Dority. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TileView : UIView

@property NSInteger myColumn;
@property NSInteger myRow;
@property (nonatomic) BOOL highlighted;
@property (nonatomic) BOOL solutionCell;
@property NSInteger color;

-(void) drawBoxWithColor: (UIColor*) color
                  stroke:(UIColor*) stroke
                  bounds: (CGRect) bounds;

@end
