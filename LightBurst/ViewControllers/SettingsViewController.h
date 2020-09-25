//
//  SettingsViewController.h
//  LightBurst
//
//  Created by Bart Dority on 9/21/20.
//

#ifndef SettingsViewController_h
#define SettingsViewController_h

#import <UIKit/UIKit.h>
#import "Game.h"
#import "GameViewController.h"
#import "AppDelegate.h"

@interface SettingsViewController : UIViewController <UIAlertViewDelegate>

@property AppDelegate *appDelegate;
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

#endif /* SettingsViewController_h */
