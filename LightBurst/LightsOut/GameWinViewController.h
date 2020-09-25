//
//  GameWinViewController.h
//  LightsOut
//
//  Created by Bart Dority on 5/9/13.
//  Copyright (c) 2013 Bart Dority. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameAppDelegate.h"

@interface GameWinViewController : UIViewController

@property GameAppDelegate *appDelegate;

- (void)playAgain;


@end
