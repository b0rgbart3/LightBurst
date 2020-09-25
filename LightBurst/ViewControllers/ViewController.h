//
//  ViewController.h
//  LightBurst
//
//  Created by Bart Dority on 9/21/20.
//

#import <UIKit/UIKit.h>
#import "StandardButton.h"
#import "TileView.h"
#import "Jewel.h"

@interface ViewController : UIViewController


@property TileView *tile1;
@property TileView *tile2;
@property TileView *tile3;
@property TileView *tile4;
@property TileView *tile5;

@property StandardButton *play;

@property Jewel *jewel;

@end

