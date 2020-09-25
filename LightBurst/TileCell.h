//
//  TileCell.h
//  LightBurst
//
//  Created by Bart Dority on 9/21/20.
//

#ifndef TileCell_h
#define TileCell_h


#import <UIKit/UIKit.h>
#import "GameViewController.h"
#import "TileView.h"
#import "TileBurst.h"

@interface TileCell : UICollectionViewCell

//  This is our handle to the tileView, which originally was
//  the only reason this class is customized

// Now I am adding animation effects while I turn on the views
// within this cell, so now I'm adding methods to the cell, too.

@property (strong, nonatomic) TileView *tileView;
@property (strong, nonatomic) TileBurst *tileBurstView;

@property (nonatomic) BOOL on;
@property (nonatomic) BOOL solutionCell;
@property (nonatomic) NSInteger color;


-(void) updateWithHighlight:(BOOL)highlight color:(NSInteger)color andPartOfTheSolution:(BOOL)solutionCell;


@end
#endif /* TileCell_h */
