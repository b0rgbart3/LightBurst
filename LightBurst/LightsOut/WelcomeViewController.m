//
//  WelcomeViewController.m
//  LightsOut
//
//  Created by Bart Dority on 5/10/13.
//  Copyright (c) 2013 Bart Dority. All rights reserved.
//

#import "WelcomeViewController.h"
#import "GameAppDelegate.h"
#import "jewelButton.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createMyButtons];
}




-(void) createMyButtons
{
  
    float width = self.view.bounds.size.width;
    float tilesize = 70;
    float tiletop = 100;
    float position1 = ((width/2) - (tilesize *1.5));
    float position2 = ((width/2) - (tilesize*.5));
    float position3 = ((width/2) + (tilesize*.5));

    //GameAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    GameAppDelegate *appDelegate = (GameAppDelegate*)[[UIApplication sharedApplication] delegate];
    
    float tileColor;
    
    if (appDelegate.model)
      tileColor = (float) appDelegate.model.color;
    else
      tileColor = arc4random() % 255;
    
    
    UIButton *button;
    float hue = (float) tileColor/255;
    
    
    // New Game Button
    button = [helperMethods createAButton: @"Play" at:position2 and:tiletop+tilesize ofWidth: tilesize andHeight: tilesize];
    
    standardButton *playButton = (standardButton *) button;
    
    playButton.color = [UIColor colorWithHue:hue saturation:.5 brightness:.4 alpha:1];
    playButton.strokeColor = [UIColor colorWithHue:hue saturation:.5 brightness:.6 alpha:1];
    playButton.highColor = [UIColor colorWithHue:hue saturation:.5 brightness:.7 alpha:1];
    playButton.highStrokeColor = [UIColor colorWithHue:hue saturation:.5 brightness:.8 alpha:1];
    
    [playButton addTarget:self action:@selector(startGame) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:playButton];
    
    
    CGRect tile1Frame = CGRectMake(position1, tiletop+tilesize, tilesize, tilesize);
    CGRect tile2Frame = CGRectMake(position2,tiletop,tilesize,tilesize);
    CGRect tile3Frame = CGRectMake(position3,tiletop+tilesize,tilesize,tilesize);
    CGRect tile4Frame = CGRectMake(position2,tiletop+tilesize*2,tilesize,tilesize);
    //CGRect tile5Frame = CGRectMake(position2,tiletop+tilesize,tilesize,tilesize);
    
    self.tile1 = [[TileView alloc] initWithFrame:tile1Frame];
    self.tile1.highlighted = NO;
    self.tile1.color = tileColor;
    [self.view addSubview:self.tile1];
    
    self.tile2 = [[TileView alloc] initWithFrame:tile2Frame];
    self.tile2.highlighted = NO;
    self.tile2.color = tileColor;
    [self.view addSubview:self.tile2];
   
    self.tile3 = [[TileView alloc] initWithFrame:tile3Frame];
    self.tile3.highlighted = NO;
    self.tile3.color= tileColor;
    [self.view addSubview:self.tile3];
    
    self.tile4 = [[TileView alloc] initWithFrame:tile4Frame];
    self.tile4.highlighted = NO;
    self.tile4.color = tileColor;
    [self.view addSubview:self.tile4];
    
    playButton.alpha = 0;
    [UIView animateWithDuration:1 animations:^{
        playButton.alpha = 1;
    }];
    
    [playButton fadeOut];
    
   // self.tile5 = [[TileView alloc] initWithFrame:tile5Frame];
  //  self.tile5.highlighted = NO;
   // self.tile5.color = tileColor;
   // [self.view addSubview:self.tile5];
    

   /* CGRect JewelFrame = CGRectMake(position2,tiletop+tilesize,tilesize,tilesize);
    

    jewelButton *jb = [[jewelButton alloc] initWithFrame:tile5Frame];
    jb.myColor = tileColor;
    
   
    
    jb.alpha = 0;	
    [jb addTarget:self action:@selector(startGame) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:jb];
    
    
    [UIView animateWithDuration:1 animations:^{
        jb.alpha = 1;
        self.play.alpha = 1;
    }]; 
    

    [jb fadeIn];*/
    
    
    
    
}


-(void) startGame
{
    [self performSegueWithIdentifier: @"FirstSegue" sender: self];
}

@end
