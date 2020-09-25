//
//  SettingsViewController.h
//  LightsOut
//
//  Created by Bart Dority on 5/10/13.
//  Copyright (c) 2013 Bart Dority. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"
#import "GameViewController.h"
#import "GameAppDelegate.h"

@interface SettingsViewController : UIViewController <UIAlertViewDelegate>

@property GameAppDelegate *appDelegate;
@property (strong,nonatomic) Game *model;

@property NSInteger newMatrixSize;
@property NSInteger fullMatrix; 
@property float divider;
@property NSInteger newSequenceLength;
@property NSInteger newColorValue;
@property NSInteger difficulty;
@property NSString *warningString;
@property (strong, nonatomic) UIAlertController *GameAlert;


// Alert Delegate protocol methods

- (void)alertView:(UIAlertController *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;




@end
