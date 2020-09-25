//
//  SettingsViewController.m
//  LightBurst
//
//  Created by Bart Dority on 9/21/20.
//

#import <Foundation/Foundation.h>

#import "SettingsViewController.h"
#import "HelperMethods.h"
#import "panelBox.h"

#define STANDARD_SATURATION .8
#define STANDARD_BRIGHTNESS .6
#define MATRIX_CONTROL_OFFSET 4


@interface SettingsViewController ()
@property (strong, nonatomic) UISlider *cSlider;
@property (strong, nonatomic) UIView *colorView;
//@property (strong, nonatomic) UISegmentedControl *matrixSizeControl;
@property (strong,nonatomic) UISlider *matrixSlider;
@property (strong, nonatomic) UILabel *gameColorLabel;
@property (strong, nonatomic) UILabel *matrixSizeLabel;
@property (strong, nonatomic) UILabel *numberOfTilesLabel;
@property (strong, nonatomic) UILabel *numberOfTilesValueLabel;
@property (strong, nonatomic) UILabel *difficultyLabel;
@property (strong, nonatomic) UILabel *sequenceLengthLabel;
@property (strong, nonatomic) UILabel *sequenceLengthValueLabel;
@property (strong, nonatomic) UILabel *easyLabel;
@property (strong, nonatomic) UILabel *hardLabel;
@property (strong, nonatomic) panelBox *r1View;
@property (strong, nonatomic) UISlider *difficultySlider;

@end



@implementation SettingsViewController

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

    // The delegate is where I can get game-specific data that I need.
    // However, I noticed that I am access some of these data properties
    // directly here, and I might want to change that to be more generic?
    
    // --fix warnings
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.model = self.appDelegate.model;
    self.newColorValue = self.model.color;
    
    self.warningString = @"Changing the matrix size or sequence length requires that you start a new game.  Are you sure you want to start a new game?";
    [self layoutTheScreen];
    [self adjustControls];
    
}


-(void) layoutTheScreen
{
    // We have 3 controls to layout, plus the ok and cancel buttons at the bottom of the screen.
    // So we want to split the screen into 3 vertical sections, but since different devices have
    // different vertical dimensions, we base our sizing of elements on that.
    
    // Box Values
    float verticalMargin = self.view.frame.size.height * .01;
    float horizontalMargin = self.view.frame.size.width *.01;
    float boxHeight =  (self.view.frame.size.height * .73) / 3;
    float verticalPosition1 = self.view.frame.size.height*.05;
    float verticalPosition2 = verticalPosition1 + boxHeight + verticalMargin;
    float verticalPosition3 = verticalPosition2 + boxHeight + verticalMargin;
    UIColor *dkGrayColor = [[UIColor alloc] initWithRed:.2 green:.2 blue:.2 alpha:1];
    
    // Button Values
    float buttonWidth = self.view.frame.size.width * .32;
    float buttonHeight = self.view.frame.size.height * .09;
    float buttonVerticalOrigin = self.view.frame.size.height * .81;
    
    // Text Values
    float labelHeight = self.view.frame.size.height * .05;
    float titleLabelSize = self.view.frame.size.width *.05;
    float subTitleLabelSize = titleLabelSize * .86;
    float valueNumberSize = titleLabelSize * 1.45;
    float tinySize = titleLabelSize *.75;
    float rightX = (self.view.frame.size.width * .95) - buttonWidth;
    float leftX = self.view.frame.size.width * .05;
    float subTitleVerticalOffset = boxHeight * .7;
    float threeQuartersWidth = self.view.frame.size.width*.85;
    
    UIButton *button;
    
    // Control Values
    float basicWidth = self.view.frame.size.width * .86;
    float leftPosition = (self.view.frame.size.width - basicWidth) / 2;
    float sliderVerticalOffset = titleLabelSize + (verticalMargin * 3);
    
    
    // Create the rounded boxes
    // ------------------------------------------------------------------------------------------------
    CGRect rect1 = CGRectMake(horizontalMargin, verticalPosition1, self.view.frame.size.width-(horizontalMargin*2), boxHeight);
    CGRect rect2 = CGRectMake(horizontalMargin, verticalPosition2, self.view.frame.size.width-(horizontalMargin*2), boxHeight);
    CGRect rect3 = CGRectMake(horizontalMargin, verticalPosition3, self.view.frame.size.width-(horizontalMargin*2), boxHeight);

    // Put in 3 custom view objects which will give us 3 rounded rectangles
    // we need a public handle to the first one so we can change the color on the fly
    self.r1View = [[panelBox alloc] initWithFrame:rect1];
    panelBox *r2View = [[panelBox alloc] initWithFrame:rect2 andColor:dkGrayColor];
    panelBox *r3View = [[panelBox alloc] initWithFrame:rect3 andColor:dkGrayColor];
    
    // Setting this local variable to TRUE will draw the sub-panel pane at the bottom of our rounded rect
    [self.r1View setSpecial:TRUE];
    [r2View setSpecial:TRUE];
    [r3View setSpecial:TRUE];
    
    // Add them to our view
    [self.view addSubview:self.r1View];
    [self.view addSubview:r2View];
    [self.view addSubview:r3View];

    
    // Create the Controls for changing the Color
    // ---------------------------------------------------------------------------------------------------------------------
    CGRect gameColorLabelFrame = CGRectMake(leftPosition, verticalPosition1 + verticalMargin, basicWidth /2, titleLabelSize);
    CGRect cSliderFrame = CGRectMake(leftPosition, verticalPosition1+sliderVerticalOffset, basicWidth, labelHeight);
   
    self.gameColorLabel = [HelperMethods createALabel:@"Game Color:" ofSize:titleLabelSize withFrame:gameColorLabelFrame];
    [self.view addSubview:self.gameColorLabel];
    
    // Allocate the slider control and set it's target action method
    self.cSlider = [[UISlider alloc] initWithFrame:cSliderFrame];
    [self.cSlider setMinimumValue:0];
    [self.cSlider setMaximumValue:255];
    [self.cSlider setValue:self.model.color];
    [self.cSlider addTarget:self action:@selector(changeMe) forControlEvents:UIControlEventValueChanged];
    [self.cSlider setMinimumTrackTintColor: [UIColor blackColor]];
    [self.cSlider setMaximumTrackTintColor: dkGrayColor];
    [self.view addSubview:self.cSlider];
    
    
    // Create the Controls for changing the Matrix Size
    // ---------------------------------------------------------------------------------------------------------------------
    
    CGRect matrixSizeLabelFrame = CGRectMake(leftPosition, verticalPosition2 + verticalMargin, basicWidth/2, titleLabelSize);
    CGRect matrixSliderFrame = CGRectMake(leftPosition,verticalPosition2+sliderVerticalOffset, basicWidth, labelHeight);
    CGRect numberOfTilesLabelFrame = CGRectMake(0, verticalPosition2 + subTitleVerticalOffset, threeQuartersWidth, labelHeight);
    CGRect numberOfTilesValueLabelFrame = CGRectMake(threeQuartersWidth, verticalPosition2 + subTitleVerticalOffset, valueNumberSize*3, valueNumberSize);
    
    self.matrixSizeLabel = [HelperMethods createALabel:@"Matrix Size:" ofSize:titleLabelSize withFrame:matrixSizeLabelFrame];
    [self.view addSubview:self.matrixSizeLabel];
    self.numberOfTilesLabel = [HelperMethods createALabel:@"Number of Tiles:" ofSize:subTitleLabelSize withFrame:numberOfTilesLabelFrame];
    [self.numberOfTilesLabel setTextAlignment:NSTextAlignmentRight];
    [self.view addSubview:self.numberOfTilesLabel];
    
    self.numberOfTilesValueLabel =[HelperMethods createALabel:@"4" ofSize:valueNumberSize withFrame:numberOfTilesValueLabelFrame];
    [self.view addSubview:self.numberOfTilesValueLabel];
    
    
    // Allocate the slider control and set it's target action method
    self.matrixSlider = [[UISlider alloc] initWithFrame:matrixSliderFrame];
    [self.matrixSlider setValue:(float) (self.model.rowCount-4) / 8];
    [self.matrixSlider setMinimumTrackTintColor: [UIColor blackColor]];
    [self.matrixSlider setMaximumTrackTintColor: dkGrayColor];
    [self.matrixSlider addTarget:self action:@selector(changeMyMatrixSize) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.matrixSlider];
    
    /*  I used to use a UISegmented Control for the Matrix size, but now I'm changing it to be a slider, so that it's
     simpler, and more consistent with the other controls. */
     
/*
     CGRect matrixSizeControlFrame = CGRectMake(slightyMoreLeft, verticalPosition2+(labelHeight*1.5), slightlyWider, labelHeight*1.2);
    self.matrixSizeControl = [[UISegmentedControl alloc] initWithFrame:matrixSizeControlFrame];
    [self.matrixSizeControl setApportionsSegmentWidthsByContent:YES];
    for (int i = 4; i < 13; i++)
    {
        NSString *sizeString = [NSString stringWithFormat:@"%d",i];
        [self.matrixSizeControl insertSegmentWithTitle:sizeString atIndex:i-4 animated:NO];
    }
    [self.matrixSizeControl addTarget:self action:@selector(changeMyMatrixSize) forControlEvents:UIControlEventValueChanged];

    NSDictionary *myTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:14],
                                       NSForegroundColorAttributeName:[UIColor whiteColor]};
        
    [self.matrixSizeControl setTitleTextAttributes:myTextAttributes forState:UIControlStateNormal];
    
    // This tint color doesn't seem to have any affect on the object
    //[self.matrixSizeControl setTintColor:myRedColor];
    //[self.matrixSizeControl setBackgroundColor:myRedColor];
 
    UIImage *normal = [UIImage imageNamed:@"normal.png"];
    UIImage *selected = [UIImage imageNamed:@"highlighted.png"];
    UIImage *rightSelected = [UIImage imageNamed:@"rightselected.png"];
    UIImage *leftSelected = [UIImage imageNamed:@"leftselected.png"];
    UIImage *noneSelected = [UIImage imageNamed:@"noneselected.png"];
    
    
    [self.matrixSizeControl setBackgroundImage:normal forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.matrixSizeControl setBackgroundImage:selected forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [self.matrixSizeControl setDividerImage:noneSelected forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.matrixSizeControl setDividerImage:leftSelected forLeftSegmentState:UIControlStateSelected rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.matrixSizeControl setDividerImage:rightSelected forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [self.matrixSizeControl setContentPositionAdjustment:UIOffsetMake(5, 0)
                        forSegmentType:UISegmentedControlSegmentLeft
                            barMetrics:UIBarMetricsDefault];
    [self.matrixSizeControl  setContentPositionAdjustment:UIOffsetMake(-5, 0)
                        forSegmentType:UISegmentedControlSegmentRight
                            barMetrics:UIBarMetricsDefault];
    
    
            
    [self.view addSubview:self.matrixSizeControl];
 */
    
    

    
    // Create the Controls for changing the Sequence Length (Game Difficulty)
    // ---------------------------------------------------------------------------------------------------------------------

    CGRect difficultyLabelFrame = CGRectMake(leftPosition, verticalPosition3 + verticalMargin, basicWidth/2, titleLabelSize);
    CGRect sequenceLengthLabelFrame = CGRectMake(0, verticalPosition3 + subTitleVerticalOffset, threeQuartersWidth, labelHeight);
    CGRect sequenceLengthValueLabelFrame = CGRectMake(threeQuartersWidth, verticalPosition3 + subTitleVerticalOffset, basicWidth/2, labelHeight);
    CGRect difficultySliderFrame = CGRectMake(leftPosition, verticalPosition3 + sliderVerticalOffset, basicWidth, labelHeight);
    CGRect easyLabelFrame = CGRectMake(difficultySliderFrame.origin.x, difficultySliderFrame.origin.y + labelHeight, basicWidth/2, labelHeight*.8);
    CGRect hardLabelFrame = CGRectMake(0, difficultySliderFrame.origin.y + difficultySliderFrame.size.height, difficultySliderFrame.origin.x + difficultySliderFrame.size.width, labelHeight*.8);
    
    
    self.difficultyLabel = [HelperMethods createALabel:@"Difficulty:" ofSize:titleLabelSize withFrame:difficultyLabelFrame];
    [self.view addSubview:self.difficultyLabel];
    
    self.sequenceLengthLabel = [HelperMethods createALabel:@"Sequence Length:" ofSize:subTitleLabelSize withFrame:sequenceLengthLabelFrame];
    [self.sequenceLengthLabel setTextAlignment:NSTextAlignmentRight];
    [self.view addSubview:self.sequenceLengthLabel];
    
    self.sequenceLengthValueLabel = [HelperMethods createALabel:@"0" ofSize:valueNumberSize withFrame:sequenceLengthValueLabelFrame];
    [self.view addSubview:self.sequenceLengthValueLabel];
    
    self.easyLabel = [HelperMethods createALabel:@"easy" ofSize:tinySize withFrame:easyLabelFrame];
    [self.easyLabel setAlpha:.35];
    [self.view addSubview:self.easyLabel];
    self.hardLabel = [HelperMethods createALabel:@"hard" ofSize:tinySize withFrame:hardLabelFrame];
    [self.hardLabel setAlpha:.35];
    [self.hardLabel setTextAlignment:NSTextAlignmentRight];
    [self.view addSubview:self.hardLabel];
    
    // Allocate the slider control and set it's target action method
    self.difficultySlider = [[UISlider alloc] initWithFrame:difficultySliderFrame];
    [self.difficultySlider addTarget:self action:@selector(updateSequenceLength) forControlEvents:UIControlEventValueChanged];
    [self.difficultySlider setMinimumTrackTintColor: [UIColor blackColor]];
    [self.difficultySlider setMaximumTrackTintColor:dkGrayColor];
    [self.view addSubview:self.difficultySlider];
    
    

    
    // Finally, create the ok and cancel buttons at the bottom of the screen.
    // ---------------------------------------------------------------------------------------------------------------------
    
    // Accept
    button = [HelperMethods createAButton: @"Accept" at:rightX and:buttonVerticalOrigin ofWidth: buttonWidth andHeight: buttonHeight];
    [button addTarget:self action:@selector(playButtonHit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    // Cancel
    button = [HelperMethods createAButton: @"Cancel" at:leftX and:buttonVerticalOrigin ofWidth: buttonWidth andHeight: buttonHeight];
    [button addTarget:self action:@selector(proceedBackToGame) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
}

// This method interprets the current model data into the controls
-(void) adjustControls
{
    //self.matrixSizeControl.selectedSegmentIndex = self.model.columnCount - MATRIX_CONTROL_OFFSET;
    CGFloat mSValue = (float) (((float) self.model.columnCount-4)/8);
    //NSLog(@"Value: %f",mSValue);
    
    [self.matrixSlider setValue:(float)mSValue];
    [self.matrixSlider setNeedsDisplay];
    //self.numberOfTilesValueLabel.text = [NSString stringWithFormat:@"%d",(int)self.model.columnCount];
    [self changeMyMatrixSize];
    
    // Determine how easy or hard the puzzle is by comparing the sequence length to the matrix size.
    
    int sL = (int) self.model.sequenceLength;
    self.newSequenceLength = sL;
    self.newMatrixSize = self.model.rowCount;
    int minimumSL = (int) self.model.rowCount;
    int maxSL = (int) self.model.rowCount * 4;
    float myDiffiPercentage = (float) sL / (float) maxSL;
    self.difficulty = maxSL * myDiffiPercentage;

    self.sequenceLengthValueLabel.text = [NSString stringWithFormat:@" %d",(int) sL];
    
    [self.cSlider setMinimumValue:0];
    [self.cSlider setMaximumValue:255];
    [self.cSlider setValue:self.model.color];
    [self.cSlider setNeedsDisplay];
    
    
    //[self.matrixSizeControl setSelectedSegmentIndex:self.model.rowCount - 4];
    //[self.matrixSizeControl setNeedsDisplay];
    
    [self.difficultySlider setMinimumValue:minimumSL];
    [self.difficultySlider setMaximumValue:maxSL];
    [self.difficultySlider setValue: (float) self.difficulty];
    [self.difficultySlider setNeedsDisplay];
    
    [self updateColorView];
    [self updateSequenceLength];
    
}

-(void) updateColorView
{
    self.newColorValue = self.cSlider.value;
    float newColorHue = (float) self.newColorValue / 255;
    //NSLog(@"self.newColorValue == %d",self.newColorValue);
    UIColor *newColor = [UIColor colorWithHue: newColorHue saturation:STANDARD_SATURATION brightness:STANDARD_BRIGHTNESS alpha:1];
    //self.colorView.backgroundColor = newColor;
    [self.r1View setSmallBoxColor:newColor];
    [self.r1View setNeedsDisplay];
    
    
}

// This method updates the sequence length after the user changes the Martrix size.
-(void) updateSequenceLength {
    
    
    // Calculate the min and max possible sequence lengths  (yes, the 4 is just arbitrary)
    int minimumSL = (int) self.newMatrixSize;
    int maxSL = (int) self.newMatrixSize * 4;
    
    // Calculate the percentage of the diffiSlider position, so we can keep it in the same
    // spot even though the sequence length and possible values are changing.
    
    float myDiffiPercentage = self.difficultySlider.value / self.difficultySlider.maximumValue;
    
    // Calculate the new sequence length as a percentage of the new maximum
    self.newSequenceLength = maxSL * myDiffiPercentage;
    
    // Contain the values (not sure if this is necessary)
    if (self.newSequenceLength > maxSL)
        self.newSequenceLength = maxSL;
    
    if (self.newSequenceLength < minimumSL)
        self.newSequenceLength = minimumSL;
    
    // Now we set the difficulty property to match what the new Sequence Length is.
    self.difficulty = self.newSequenceLength;
    
    // Update the interface
    
    UIFont *labelFont = [UIFont boldSystemFontOfSize:self.view.frame.size.width *.07];
    NSAttributedString *sLValueAttributedString;
    NSDictionary *attributes = @{ NSFontAttributeName: labelFont, NSForegroundColorAttributeName: [UIColor whiteColor]};
    NSString *string = [NSString stringWithFormat:@" %d", (int) self.newSequenceLength];
    
    sLValueAttributedString = [[NSAttributedString alloc] initWithString:string attributes:attributes];
    
    self.sequenceLengthValueLabel.attributedText = sLValueAttributedString;
    
    
    //[self.sequenceLengthValueLabel setText:[NSString stringWithFormat:@"%d", (int) self.newSequenceLength]];
    
   
    
    [self.sequenceLengthValueLabel setNeedsDisplay];
    [self.difficultySlider setMinimumValue:minimumSL];
    [self.difficultySlider setMaximumValue:maxSL];
    [self.difficultySlider setValue:self.difficulty];
    [self.difficultySlider setNeedsDisplay];
    
    
}

- (void)changeMe {
    
    self.newColorValue = self.cSlider.value;
    [self updateColorView];
   
}

-(void)changeMyMatrixSize {
    self.newMatrixSize = (int) 8 * self.matrixSlider.value + 4;
    //self.matrixSizeControl.selectedSegmentIndex + MATRIX_CONTROL_OFFSET;
    UIFont *labelFont = [UIFont boldSystemFontOfSize:self.view.frame.size.width *.07];
    NSAttributedString *sLValueAttributedString;
    NSDictionary *attributes = @{ NSFontAttributeName: labelFont, NSForegroundColorAttributeName: [UIColor whiteColor]};
    NSString *string = [NSString stringWithFormat:@" %d", (int) self.newMatrixSize];
    
    sLValueAttributedString = [[NSAttributedString alloc] initWithString:string attributes:attributes];
    
    //self.sequenceLengthValueLabel.attributedText = sLValueAttributedString;
    
    [self.numberOfTilesValueLabel setAttributedText:sLValueAttributedString];
    
    //[self.numberOfTilesValueLabel setText:[NSString stringWithFormat:@"%d",self.newMatrixSize]];
    [self updateSequenceLength];
}



// We alerted to the user that changing these values would require that they start a new game
// this method is the delegate method that the UIAlertView will call when the user responds.
// 1 = OK, 0 = CANCEL

- (void)alertView:(UIAlertController *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        // here we need to create a new model
        
        
        self.appDelegate.matrixSize = self.newMatrixSize;
        self.appDelegate.sequenceLength = self.newSequenceLength;
        self.model.color = self.newColorValue;
        self.appDelegate.color = self.model.color;
        
        self.model = nil;
        self.appDelegate.model = nil;
        
        self.appDelegate.needNewModel = YES;
        
        [self.appDelegate createNewModel];
        [self proceedBackToGame];
    }
    else
    {
        // otherwise just pass the old one back (it might have a new color)
        self.appDelegate.model = self.model;
        [self.appDelegate saveGame];
        [self proceedBackToGame];
    }
}

-(void) playButtonHit
{
 
    
//    if ((self.newMatrixSize != self.model.rowCount) || (self.newSequenceLength != self.model.sequenceLength))
//    {
//        self.GameAlert= [[UIAlertView alloc] initWithTitle:@"NewGame" message:self.warningString delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
//        [self.GameAlert addButtonWithTitle:@"OK"];
//
//        [self.GameAlert show];
//    }
//    else
//    {
//        self.model.color = self.newColorValue;
//        self.appDelegate.color = self.model.color;
//        [self proceedBackToGame];
//    }
}

-(void) proceedBackToGame
{
    [self performSegueWithIdentifier: @"GameSegue" sender: self];
}


//- (void)viewDidUnload {
//    [super viewDidUnload];
//}
@end
