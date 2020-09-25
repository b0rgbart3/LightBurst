//
//  TileView.h
//  LightBurst
//
//  Created by Bart Dority on 9/21/20.
//

#ifndef TileView_h
#define TileView_h

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


#endif /* TileView_h */
