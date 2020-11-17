//
//  AppDelegate.m
//  LightBurst
//
//  Created by Bart Dority on 9/21/20.
//

#import "AppDelegate.h"
#import "persistence.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


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
   // if (self.model && self.model.solutionTiles && self.model.solutionTiles.count < 1)
   // {
        [self createNewModel];
    //}

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


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.needNewModel = NO;
    self.matrixSize = INITIAL_BOARD_SIZE;
    self.sequenceLength = INITIAL_SEQUENCE_LENGTH;
    self.color = INITIAL_COLOR;

    
    [self loadGame];
    return YES;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
// Return YES for supported orientations
// return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    return NO;
}

#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
