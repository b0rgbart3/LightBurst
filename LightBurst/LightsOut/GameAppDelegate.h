//
//  GameAppDelegate.h
//  LightsOut
//
//  Created by Bart Dority on 5/8/13.
//  Copyright (c) 2013 Bart Dority. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"   // our model object

@interface GameAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

// this is my custom properties which I am using to preload the model
@property (nonatomic) Game *model;

@property NSInteger matrixSize;
@property NSInteger sequenceLength;
@property NSInteger color;
@property BOOL needNewModel;

// These methods call the persistence methods to load and save the model
// from a file on the device.

-(void) saveGame;
-(void) loadGame;
-(void) createNewModel;

@end
