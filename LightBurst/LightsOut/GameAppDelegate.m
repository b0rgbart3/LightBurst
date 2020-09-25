//
//  GameAppDelegate.m
//  LightsOut
//
//  Created by Bart Dority on 5/8/13.
//  Copyright (c) 2013 Bart Dority. All rights reserved.
//

#import "GameAppDelegate.h"
#import "Persistence.h"



@implementation GameAppDelegate

-(void) saveGame
{
    //NSLog(@"Saving the game.");
    self.matrixSize = self.model.columnCount;
    self.sequenceLength = self.model.sequenceLength;
    self.color = self.model.color;
    
    [Persistence saveObject: self.model withFileName:@"LightsOut_Model"];
    
}

-(void) loadGame
{
    // if the load methods returns nil, then the getters should create these objects
    
    self.model = [Persistence loadObjectfromFileName:@"LightsOut_Model"];
    if (self.model.solutionTiles.count < 1)
    {
        [self createNewModel];
    }

}

-(void) createNewModel
{
   //NSLog(@"CreateNewModel got called, with size: %d", self.matrixSize);
    _model = [[Game alloc] initWithBoardSize:self.matrixSize andSequenceLength:self.sequenceLength andColor:self.color];
}

-(Game*) model
{
    if (!_model)
    {
      //  NSLog(@"Creating the model in the appDelegate.");
        _model = [[Game alloc] initWithBoardSize:self.matrixSize andSequenceLength:self.sequenceLength andColor:self.color];
        self.needNewModel = NO;
    }
    return _model;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.needNewModel = NO;
    self.matrixSize = INITIAL_BOARD_SIZE;
    self.sequenceLength = INITIAL_SEQUENCE_LENGTH;
    self.color = INITIAL_COLOR;
    
    [self loadGame];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    //GameViewController *myVC = self.window.rootViewController;
    
    [self saveGame];
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [self saveGame];
}

@end
