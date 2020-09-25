//
//  WelcomeViewController.h
//  LightsOut
//
//  Created by Bart Dority on 5/10/13.
//  Copyright (c) 2013 Bart Dority. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "helperMethods.h"
#import "TileView.h"
#import "Jewel.h"


#import "standardButton.h"

@interface WelcomeViewController : UIViewController

@property TileView *tile1;
@property TileView *tile2;
@property TileView *tile3;
@property TileView *tile4;
@property TileView *tile5;

@property standardButton *play;

@property Jewel *jewel;

@end
