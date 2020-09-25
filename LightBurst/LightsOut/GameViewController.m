//
//  GameViewController.m
//  LightsOut
//
//  Created by Bart Dority on 5/8/13.
//  Copyright (c) 2013 Bart Dority. All rights reserved.
//

#import "GameViewController.h"
#import "helperMethods.h"

#define VERTICAL_LABEL_MARGIN 16
#define gray0 0
#define gray1 .1
#define gray2 .2
#define gray3 .3
#define gray4 .4
#define gray5 .5
#define gray6 .6
#define gray7 .7
#define gray8 .8
#define gray9 .9
#define gray10 1

@interface GameViewController ()

@end

@implementation GameViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.appDelegate = (GameAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // This is a weird little check I had to put in when I added the data persistence
    if (self.model)
    {
        if ([self.model checkForWin] == YES)
        {
            // if the display array loaded in all zeros, then we really need to create a new model.
            self.model = nil;
        }
    }
    
    [self.swipeGR setDirection:UISwipeGestureRecognizerDirectionRight];
    [self setColors];
    [self createMyButtons];
    [self updatePanelInfo];
    [self refreshDisplay];
  
}


-(void) setColors
{
    self.color0 = [[UIColor alloc] initWithRed:gray0 green:gray0 blue:gray0 alpha:1];
    self.color1 = [[UIColor alloc] initWithRed:gray1 green:gray1 blue:gray1 alpha:1];
    self.color2 = [[UIColor alloc] initWithRed:gray2 green:gray2 blue:gray2 alpha:1];
    self.color3 = [[UIColor alloc] initWithRed:gray3 green:gray3 blue:gray3 alpha:1];
    self.color4 = [[UIColor alloc] initWithRed:gray4 green:gray4 blue:gray4 alpha:1];
    self.color5 = [[UIColor alloc] initWithRed:gray5 green:gray5 blue:gray5 alpha:1];
    self.color6 = [[UIColor alloc] initWithRed:gray6 green:gray6 blue:gray6 alpha:1];
    self.color7 = [[UIColor alloc] initWithRed:gray7 green:gray7 blue:gray7 alpha:1];
    self.color8 = [[UIColor alloc] initWithRed:gray8 green:gray8 blue:gray8 alpha:1];
    self.color9 = [[UIColor alloc] initWithRed:gray9 green:gray9 blue:gray9 alpha:1];
    self.color10 = [[UIColor alloc] initWithRed:gray10 green:gray10 blue:gray10 alpha:1];
}

//- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
//{
//    //NSLog(@"Rotated: %d",fromInterfaceOrientation);
//
//}

-(Game*) model
{
    if (!_model)
    {
        _model = self.appDelegate.model;
    }
    return _model;
}

-(void) updatePanelInfo
{
   
    if (self.model)
    {
        self.touchesLabel.text = [NSString stringWithFormat:@"%ld",(long)self.model.moveCount];
        self.tilesLabel.text = [NSString stringWithFormat:@"%ld", (long)self.model.sequenceLength];
        //self.scoreLabel.text = [NSString stringWithFormat:@"score: %d  ",self.model.score];
    
        [self.view setNeedsDisplay];
    }
    
    
}

-(void) createMyButtons
{
    // Calculate the UI component size and positions based on the current device
    float screenWidth = self.view.frame.size.width;
    float pngButtonSize = self.view.frame.size.width * .16;
    float margin= pngButtonSize * .45;
    float verticalMargin = self.view.frame.size.height * .008;
    float buttonVerticalPosition = self.view.frame.size.height*.75;
    float panelY = self.view.frame.size.height *.64;
    float panelHeight = self.view.frame.size.height - panelY;
    float subPanelHeight = panelHeight *.22;
    
    // Center the TilePanel vertically above the gray panel.
    float tcvTop = ((panelY - screenWidth) / 2) * 1.08;
    float centerX = (self.view.frame.size.width / 2);
    
    float buttonHorizontalPosition1 = centerX -(margin*1.5) - (pngButtonSize *2);
    float buttonHorizontalPosition2 = (centerX - (margin*.5)) - pngButtonSize;
    float buttonHorizontalPosition3 = centerX + (margin*.5);
    float buttonHorizontalPosition4 = centerX + (margin*1.5) + pngButtonSize;
    
    UIColor *myTransparentColor = [[UIColor alloc] initWithRed:1 green:1 blue:1 alpha:0];
    UIFont *touchesLabelFont = [UIFont boldSystemFontOfSize:16];
    
    // Since the 4-inch iPhone has extxra vertical realestate, we put this proportional gray panel at the top
    //CGRect chromeRect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height*.05);
    //[self.chromePiece setFrame:chromeRect];
    //[self.chromePiece setNeedsDisplay];
    
    // This is the main CollectionView that holds the tiles   (The main game-play panel)
    self.myLayout = [[UICollectionViewFlowLayout alloc] init];
    [self.myLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    CGRect tileFrame = CGRectMake((screenWidth*.05), tcvTop, (screenWidth*.9), (screenWidth*.9));
    self.tileCollectionView = [[UICollectionView alloc] initWithFrame:tileFrame collectionViewLayout:self.myLayout];
    [self.tileCollectionView registerClass:[TileCell class] forCellWithReuseIdentifier:@"tileCell"];
    [self.tileCollectionView setBackgroundColor:[UIColor blackColor]];
    [self.tileCollectionView setDataSource:self];
    [self.tileCollectionView setDelegate:self];
    self.tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tileHit:)];
    [self.tileCollectionView addGestureRecognizer:self.tapGR];
    //[self addTarget:self action:@selector(tileHit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.tileCollectionView];
    
    //   Now we build the gray control panel at the bottom of the screen
    CGRect panelRect;
    panelView *panel;
    panelRect = CGRectMake(0, panelY, self.view.frame.size.width, self.view.frame.size.height*.28);
    panel = [[panelView alloc] initWithFrame: panelRect];
    [panel setColor1:self.color3];
    [panel setColor2:self.color4];
    [self.view addSubview:panel];
    CGFloat hue = (float) self.model.color / 255;
    self.myColor = [[UIColor alloc] initWithHue:hue saturation:.7 brightness:.7 alpha:1];

    // This is the 'more-info' button (with the question mark graphic)
    CGRect infoViewBounds = CGRectMake(margin,panelY + (subPanelHeight*.1),pngButtonSize,(subPanelHeight *.8));
    CGRect infoButtonBounds = CGRectMake(0, 0, pngButtonSize*.9, subPanelHeight*.7);
    
    CGRect infoImageBounds = CGRectMake((pngButtonSize/2)-(subPanelHeight/2), 0-(subPanelHeight * .1), (subPanelHeight), (subPanelHeight));
    UIView *infoView = [[UIView alloc] initWithFrame:infoViewBounds];
    standardButton *infoButton = [[standardButton alloc] initWithFrame:infoButtonBounds];
    UIImage *infoImage = [UIImage imageNamed:@"info.png"];
    UIImageView *infoImageView = [[UIImageView alloc] initWithFrame:infoImageBounds];
    [infoImageView setImage:infoImage];
    [infoButton addTarget:self action:@selector(showInfo) forControlEvents:UIControlEventTouchUpInside];
    [infoView addSubview:infoButton];
    [infoView addSubview:infoImageView];
    infoView.alpha = .85;
    [self.view addSubview:infoView];
    
  
    
    // Build the 4 main Buttons
    // --------------------------------------------------

    if (!self.restartButtonView)
    {
        self.restartButtonView = [[containerView alloc] initWithLeft:buttonHorizontalPosition1 top:buttonVerticalPosition size:pngButtonSize image:@"restart.png" label:@"restart" andHue: hue];
        
        [self.restartButtonView.myButton addTarget:self action:@selector(restart) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.restartButtonView];
    }
    
    if (!self.solutionButtonView)
    {
        self.solutionButtonView = [[containerView alloc] initWithLeft:buttonHorizontalPosition2 top:buttonVerticalPosition size:pngButtonSize image:@"solution.png" label:@"solution" andHue: hue];
        [self.solutionButtonView.myButton addTarget:self action:@selector(solutionToggle) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.solutionButtonView];
        
    }
   
    if (!self.settingsButtonView)
    {
        self.settingsButtonView = [[containerView alloc] initWithLeft:buttonHorizontalPosition3 top:buttonVerticalPosition size:pngButtonSize image:@"settings.png" label:@"settings" andHue: hue];
        
        [self.settingsButtonView.myButton addTarget:self action:@selector(settings) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.settingsButtonView];
    }
    
    if (!self.newgameButtonView)
    {
        self.newgameButtonView = [[containerView alloc] initWithLeft:buttonHorizontalPosition4 top:buttonVerticalPosition size:pngButtonSize image:@"newgame.png" label:@"new game" andHue: hue];
        [self.newgameButtonView.myButton addTarget:self action:@selector(newGame) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.newgameButtonView];
    }
    
    
    // The burst graphic displays how many times the user has touched a tile....
    UIImageView *burstGraphic;
    CGRect burstRect;
    burstRect = CGRectMake(self.view.frame.size.width*.6, panelY + verticalMargin, 20, 20);
    burstGraphic = [[UIImageView alloc] initWithFrame:burstRect];
    UIImage *touchImage = [UIImage imageNamed:@"touch.png"];
    [burstGraphic setImage:touchImage];
    [self.view addSubview:burstGraphic];
    
    CGRect touchesRect = CGRectMake(burstRect.origin.x+burstRect.size.width + (margin/2), panelY + verticalMargin, 50, 20);
    _touchesLabel = [[UILabel alloc] initWithFrame:touchesRect];
    [_touchesLabel setTextColor:_color10];
    [_touchesLabel setText:@"0"];
    [_touchesLabel setTextAlignment:NSTextAlignmentLeft];
    [_touchesLabel setFont:touchesLabelFont];
    [_touchesLabel setBackgroundColor:myTransparentColor];
    [self.view addSubview:_touchesLabel];
    
    
    // The tile graphic displays how long the game's original sequence is......
    UIImageView *tileGraphic;
    CGRect tileRect;
    tileRect = CGRectMake(self.view.frame.size.width*.8, panelY + verticalMargin, 20, 24);
    tileGraphic = [[UIImageView alloc] initWithFrame:tileRect];
    UIImage *tileImage = [UIImage imageNamed:@"tile_icon.png"];
    [tileGraphic setImage:tileImage];
    [self.view addSubview:tileGraphic];

    CGRect tilesRect = CGRectMake(tileRect.origin.x + tileRect.size.width+(margin/2), panelY + verticalMargin, 50, 20);
    _tilesLabel = [[UILabel alloc] initWithFrame:tilesRect];
    [_tilesLabel setTextColor:_color10];
    [_tilesLabel setText:@"23"];
    [_tilesLabel setTextAlignment:NSTextAlignmentLeft];
    [_tilesLabel setFont:touchesLabelFont];
    [_tilesLabel setBackgroundColor:myTransparentColor];
    [self.view addSubview:_tilesLabel];
    
    
}

-(void) solutionOff
{
    self.model.showSolution = FALSE;
    [(standardButton *)self.solutionButtonView.myButton setToggledOn:FALSE];
    [(standardButton *)self.solutionButtonView.myButton setNeedsDisplay];
}

-(void) solutionToggle
{
  
    if (self.model.showSolution)
    {
        self.model.showSolution = FALSE;
        [(standardButton *)self.solutionButtonView.myButton setToggledOn:FALSE];
        [(standardButton *)self.solutionButtonView.myButton setNeedsDisplay];
    }
    else
    {
        [(standardButton *)self.solutionButtonView.myButton setToggledOn:TRUE];
        [(standardButton *)self.solutionButtonView.myButton setNeedsDisplay];
        //[self.model scoreDeduction];
        self.model.showSolution = TRUE;
        self.model.cheatCount++;
        float timerLength = 5;
        [NSTimer scheduledTimerWithTimeInterval:timerLength
                                         target:self
                                       selector:@selector(solutionOff)
                                       userInfo:nil
                                        repeats:NO];
    }
    
    [self refreshDisplay];
}

-(void) settings
{
    [self performSegueWithIdentifier:@"SettingsSegue" sender:self];
}


#pragma mark Segue Stuff

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    

    
    // Here, I need to identify the segue
    
    if ([segue.identifier isEqualToString:@"SettingsSegue"])
    {
        //NSLog(@"In prepare for Settings Segue method");
        // I used to pass the model and settings objects directly between the VC's.
        // Now, I'm trying an approach where, I copy it back and forth between
        // the VC's and the app.Delegate - which makes it easier to load and save
        
        [self saveGame];
        
        
        // If we are going to the Settings Screen,
        // we need to pass the model, so we can effectively
        // save it.  We also pass the settingsObject.
        /*
        SettingsViewController* settings = segue.destinationViewController;
        settings.model = self.model;
        settings.settingsObject = self.settingsObject;*/
        
    }
    
    if ([segue.identifier isEqualToString:@"WinSegue"])
    {
        //NSLog(@"In prepare for Win Segue method");
        // I used to pass the model and settings objects directly between the VC's.
        // Now, I'm trying an approach where, I copy it back and forth between
        // the VC's and the app.Delegate - which makes it easier to load and save
        
        [self saveGame];
        // I save the game even if the user won because it will save the settings.
        
        /*GameWinViewController* gamewon = segue.destinationViewController;
        
       // NSLog(@"We are passing the settings object from the GameViewController to the GameWinViewController");
       // NSLog(@"Our settings object, matrixsize == %d", self.settingsObject.matrixSize);
        // maintain the settings object by passing it to the GameWin ViewController
        gamewon.settingsObject = self.settingsObject;*/
        
    }

}



-(void) refreshDisplay
{
    BOOL win = NO;
   
    //NSLog(@"Trying to refresh.");
    for (int i = 0; i < self.model.tileCount; i++)
    {
            NSIndexPath *indexPath;
            
            // Our collectionview only has 1 section, so we start with 0, in the indexPath.
            NSUInteger integerArray[] = {0,i};
            indexPath = [[NSIndexPath alloc] initWithIndexes:integerArray length:2];
            

            TileCell *tileCell = (TileCell *) [self.tileCollectionView cellForItemAtIndexPath:indexPath];
            
          			
            // these cells don't exist when the app first loads, so we need to make sure they exist before we try to re-display them.
            if (tileCell)
            {
                // set the tile's highlighted state to what is in the model's BOOL array
                [tileCell setOn:[self.model.displayBoard[i] boolValue]];

                
                NSInteger partOfSolution = [self.model tile:i ExistsIn:self.model.solutionTiles];
                if (((partOfSolution >=0) && (partOfSolution < self.model.solutionTiles.count)) && (self.model.showSolution == YES))
                {
                    [tileCell setSolutionCell:YES];
                }
                else
                {
                    [tileCell setSolutionCell:NO];
                }
            }
            
        
    }
    
    // just make sure the appDelegate has the latest info.
    self.appDelegate.model = self.model;
    
    [self updatePanelInfo];
    
    

    win = [self.model checkForWin];
    if (win)
    {
        [self displayWon];
    }
}

-(void) checkForWin
{
    BOOL win = NO;
    
    win = [self.model checkForWin];
    if (win)
    {
        [self displayWon];
    }
}

-(void) displayWon
{
       [self performSegueWithIdentifier: @"WinSegue" sender: self];
}

-(void) showInfo
{
    [self performSegueWithIdentifier:@"info" sender:self];
}

//  The bursting and flipping of cell's (VISUALLY) gets done here in the ViewController
// Rather than in the Cells or cell's Views themselves, because 'animateWithDuration'
// is a class method, so if we animate within the cell class, then all the cells animate
// at once.

-(void) burstCell:(TileCell*) cell
{
    // Burst the cell
    cell.tileBurstView.alpha = 1;
    cell.tileView.highlighted = !cell.tileView.highlighted;
    
    [UIView animateWithDuration:.3 animations:^{
      
        cell.tileBurstView.alpha = 0;
        
    }];
    [cell.tileView setNeedsDisplay];
     
}

-(void) flipCell:(TileCell*) cell
{
    // Burst the cell
    cell.tileBurstView.alpha = .4;
    cell.tileView.highlighted = !cell.tileView.highlighted;
    
    [UIView animateWithDuration:.4 animations:^{
        
        cell.tileBurstView.alpha = 0;
        
    }];
    [cell.tileView setNeedsDisplay];
    
}

-(void) tileHit:(UITapGestureRecognizer *) sender {
    //NSLog(@"Got hit.");
    CGPoint taplocation = [sender locationInView:self.tileCollectionView];
    NSIndexPath *indexPath = [self.tileCollectionView indexPathForItemAtPoint:taplocation];
    if (indexPath)
    {
        // I started out using rows and columns as index paths for the tiles,
        // but I gave that up for a single digit (tiles 0 thru 24), so
        // it's just a single array instead of nested arrays.
        
        //NSInteger row = indexPath.item / self.model.columnCount;
        //NSInteger column = indexPath.item - (row * self.model.columnCount);
        NSMutableArray *neighbors;
        
        TileCell *tileCell = (TileCell *)[self.tileCollectionView cellForItemAtIndexPath:indexPath];
        
        [self burstCell:tileCell];
        
        neighbors = [self.model touchTileAt:indexPath.item humanTouch:YES];
        
        
        for (int i = 0; i < neighbors.count; i++)
        {
            NSUInteger integerArray[] = {0,[[neighbors objectAtIndex:i] integerValue]};
            indexPath = [[NSIndexPath alloc] initWithIndexes:integerArray length:2];
            
            tileCell = (TileCell *)[self.tileCollectionView cellForItemAtIndexPath:indexPath];
            [self flipCell: tileCell];
        }
        
        
        [self refreshDisplay];
        //[self checkForWin];
         
    }
}

- (IBAction)swipeMe:(id)sender {
    UISwipeGestureRecognizer *swipe = sender;
    
    //NSLog(@"Got the swipe. %d", swipe.direction);
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight)
    {
        [self home];
    }
}

- (IBAction)rotateMe:(UIRotationGestureRecognizer *)sender {
    
    
    
    if (([sender state] == UIGestureRecognizerStateEnded) || ([sender state] == UIGestureRecognizerStateCancelled)) {
        
        if (sender.rotation > 1)
        {
            [self rotateBoardRight];
        }
        else if (sender.rotation < -1)
        {
            [self rotateBoardLeft];
        }
    }


    
}

-(void) rotateBoardLeft {
    [self.model rotateLeft];
    [self refreshDisplay];
    
}

-(void) rotateBoardRight{
    [self.model rotateRight];
    [self refreshDisplay];
    
}

- (void)restart {
    
    [self.model resetOriginalBoard];
    [self refreshDisplay];
}

-(void) home{
    //send the user to the "homepage"
    // perform the segue:  welcomeBackSegue
    [self performSegueWithIdentifier:@"welcomeBackSegue" sender:self];
    
}

- (void)newGame
{
    [self.appDelegate saveGame];
    
    self.GameAlert= [[UIAlertView alloc] initWithTitle:@"NewGame" message:@"Are you sure you would like to start a new game?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    [self.GameAlert addButtonWithTitle:@"OK"];
    
    [self.GameAlert show];

}

-(void) createNewGame
{
    self.model = nil;
    self.appDelegate.model = nil;
    [self refreshDisplay];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if (alertView == self.GameAlert)
    {
        if (buttonIndex == 1)
        {
            [self createNewGame];
        }
    }
}


// -------Collection View Data Source Methods-------------------------
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    NSInteger count = self.model.columnCount * self.model.rowCount;
    //NSLog(@"Count === %d",count);
    return count;
}

// -------Collection View Delegate Methods---------------------------

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TileCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"tileCell" forIndexPath:indexPath];
    
    //NSLog(@"currentIndex: %d",indexPath.item);
    
    // Initialize the Tile
    NSInteger path = indexPath.item;
    NSInteger highlight = [[self.model.displayBoard objectAtIndex:path] boolValue];
    NSInteger color =  self.model.color;
    NSInteger partOfTheSolution =[self.model tile:path ExistsIn:self.model.solutionTiles];
    BOOL solutionCell = NO;
    
    if ((((partOfTheSolution >=0) && (partOfTheSolution <= self.model.solutionTiles.count)))
        && (self.model.showSolution == YES))
        solutionCell = YES; 
    
    [cell updateWithHighlight:highlight color:color andPartOfTheSolution:solutionCell];
    
    //[cell setBackgroundColor:[UIColor redColor]];
    //NSLog(@"dqueueing a cell, sized: %f, %f",cell.frame.size.width, cell.frame.size.height);
    
    //[cell addTarget:self action:@selector(tileHit) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

// -------Collection View Flow Layout Methods-------------------------

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize tileSize;
    tileSize.width = (float) (collectionView.frame.size.width * .98) / self.model.columnCount;
    tileSize.height = tileSize.width;
    //NSLog(@"inFlowLayout: size==%f",tileSize.height);
    return tileSize;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

-(void) saveGame
{
    self.appDelegate.model = self.model;
    [self.appDelegate saveGame];
}

// I don't know if I need both of these life-cycle methods, but I'm trying the get game model
// saved when the user quits the simulator......

-(void) viewWillDisappear:(BOOL)animated
{
    [self saveGame];
}

-(void) viewDidDisappear:(BOOL)animated
{
    [self saveGame];
}


@end
