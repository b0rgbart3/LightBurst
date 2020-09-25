//
//  GameWinViewController.m
//  LightsOut
//
//  Created by Bart Dority on 5/9/13.
//  Copyright (c) 2013 Bart Dority. All rights reserved.
//

#import "GameWinViewController.h"
#import "GameViewController.h"
#import "standardButton.h"
#import "helperMethods.h"

@interface GameWinViewController ()
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation GameWinViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.appDelegate = (GameAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    //UIFont *infoFont = [UIFont systemFontOfSize:basicFontSize];
    CGFloat largeTextSize = self.view.frame.size.width*.07;
    UIFont *infoBoldFont = [UIFont boldSystemFontOfSize:largeTextSize];
    //UIFont *basicFont = [UIFont boldSystemFontOfSize:largeTextSize*.6];
    UIColor *myWhite = [UIColor whiteColor];
    CGRect labelFrame = CGRectMake(largeTextSize, self.view.frame.size.height*.2, self.view.frame.size.width-(largeTextSize*3), largeTextSize*2.5);
    UILabel *label1 = [[UILabel alloc] initWithFrame:labelFrame];
    
    float currentY = labelFrame.origin.y + labelFrame.size.height + largeTextSize;
    //float fullWidth = self.view.frame.size.width;
    float labelHeight = largeTextSize*.8;
    
    [label1 setTextAlignment:NSTextAlignmentCenter];
    [label1 setFont:infoBoldFont];
    [label1 setText:@"Congratulations!\nYou solved the puzzle."];
    [label1 setTextColor: myWhite];
    [label1 setNumberOfLines:3];
    [self.view addSubview:label1];

    // Note:  We used to calculate the score as the game progressed,
    // but then I decided that the user didn't need to know about the score until they've completed the puzzle.
    // (otherwise they could use their score as a way to determine if they had hit a tile correctly or not).
    // So we are going to calculate it here and display those calculations on the screen.
    
    float possibleScore = self.appDelegate.model.columnCount * self.appDelegate.model.sequenceLength * 10;
    [self createAndDisplayAScoreLabel: @"Possible score:"  atY:currentY];
    [self createAndDisplayAScoreValueLabel:[NSString stringWithFormat:@"%d",(int) possibleScore] atY:currentY];
    
    currentY += labelHeight;
    float sequenceLength = self.appDelegate.model.sequenceLength;
    [self createAndDisplayAScoreLabel: @"Sequence length:"  atY:currentY];
    [self createAndDisplayAScoreValueLabel:[NSString stringWithFormat:@"%d",(int) sequenceLength] atY:currentY];
    
    currentY += labelHeight;
    float moveCount = self.appDelegate.model.moveCount;
    [self createAndDisplayAScoreLabel: @"Your moves:"  atY:currentY];
    [self createAndDisplayAScoreValueLabel:[NSString stringWithFormat:@"%d",(int) moveCount] atY:currentY];
    
    currentY += labelHeight;
    float initScore = sequenceLength/moveCount * possibleScore;
    [self createAndDisplayAScoreLabel: @"Your initial score:"  atY:currentY];
    [self createAndDisplayAScoreValueLabel:[NSString stringWithFormat:@"%d",(int) initScore] atY:currentY];
    
    currentY += labelHeight;
    int cheatCount = (int) self.appDelegate.model.cheatCount;
    [self createAndDisplayAScoreLabel: @"Solution used:"  atY:currentY];
    [self createAndDisplayAScoreValueLabel:[NSString stringWithFormat:@"%d",(int) cheatCount] atY:currentY];
    
    currentY += labelHeight + labelHeight;
    float finalScore = initScore - (initScore * (cheatCount * .25));
    [self createAndDisplayAScoreLabel: @"Final score:"  atY:currentY];
    [self createAndDisplayAScoreValueLabel:[NSString stringWithFormat:@"%d",(int) finalScore] atY:currentY];
    
    
    [self createMyButtons];
}

-(void) createAndDisplayAScoreValueLabel: (NSString*)displayString atY: (float) verticalPosition
{
    UIFont *basicFont = [UIFont boldSystemFontOfSize:15];
    UIColor *myWhite = [UIColor whiteColor];
    
    CGRect displayFrame = CGRectMake(self.view.frame.size.width*.6,verticalPosition,self.view.frame.size.width*.3,20);
    UILabel *displayLabel = [[UILabel alloc] initWithFrame:displayFrame];
    [displayLabel setFont:basicFont];
    [displayLabel setTextColor:myWhite];
    [displayLabel setTextAlignment:NSTextAlignmentLeft];
    
    [displayLabel setText:displayString];
    [self.view addSubview:displayLabel];
    
}


-(void) createAndDisplayAScoreLabel: (NSString*)displayString atY: (float) verticalPosition
{
    UIFont *basicFont = [UIFont boldSystemFontOfSize:15];
    UIColor *myWhite = [UIColor whiteColor];
    
    CGRect displayFrame = CGRectMake(0,verticalPosition,self.view.frame.size.width*.5,20);
    UILabel *displayLabel = [[UILabel alloc] initWithFrame:displayFrame];
    [displayLabel setFont:basicFont];
    [displayLabel setTextColor:myWhite];
    [displayLabel setTextAlignment:NSTextAlignmentRight];
    
    [displayLabel setText:displayString];
    [self.view addSubview:displayLabel];
    
}

-(void) createMyButtons
{
    float buttonWidth = self.view.frame.size.width*.45;
    float buttonHeight = self.view.frame.size.height*.1;
    // float margin= 10.0;
    // float buttonVerticalOrigin = 375;
    float buttonVerticalOrigin2 = self.view.frame.size.height * .7;
    
    //NSInteger leftStartingX = 18;
    NSInteger centerStartingX = (self.view.frame.size.width/2) - (buttonWidth/2);
    
    UIButton *button;
    
    // New Game Button
    button = [helperMethods createAButton: @"Play Again" at:centerStartingX and:buttonVerticalOrigin2 ofWidth: buttonWidth andHeight: buttonHeight];
    
    [button addTarget:self action:@selector(playAgain) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)playAgain
{
    //NSLog(@"User wants to play again.");
    
    [self performSegueWithIdentifier:@"PlaySegue" sender:self];
    
    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    
    // maintain the model even though we will be starting a new game.
    self.appDelegate.matrixSize = self.appDelegate.model.columnCount;
    self.appDelegate.sequenceLength = self.appDelegate.model.sequenceLength;
    self.appDelegate.color = self.appDelegate.model.color;
    self.appDelegate.model = nil;
    self.appDelegate.needNewModel = YES;
    [self.appDelegate createNewModel];
}
@end
