//
//  Game.h
//  LightsOut
//
//  Created by Bart Dority on 5/8/13.
//  Copyright (c) 2013 Bart Dority. All rights reserved.
//

#import <Foundation/Foundation.h>

#define INITIAL_BOARD_SIZE 5
#define INITIAL_SEQUENCE_LENGTH 5
#define INITIAL_COLOR 150


// This class will implement the NSCoding protocol so that I can save the model object to a file.

@interface Game : NSObject <NSCoding>


@property NSInteger columnCount;
@property NSInteger rowCount;
@property (nonatomic) NSInteger tileCount;
@property NSMutableArray *displayBoard;
@property NSMutableArray *originalBoard;
@property NSInteger sequenceLength;
@property NSMutableArray *sequence;
@property (strong, nonatomic) NSMutableArray *userSequence;
@property NSInteger moveCount;
@property int score;
@property NSMutableArray *solutionTiles;
@property int cheatCount;

@property NSInteger color;
@property BOOL showSolution;


- (id) initWithBoardSize:(NSUInteger)count andSequenceLength: (NSInteger)sequenceLength andColor:(NSInteger) color;
-(void) createBoard;
-(void) generateBoard;
-(void) generateRandomSequence;
-(void) interpretSequence;
-(NSMutableArray *) touchTileAt:(NSInteger)tilePath humanTouch:(BOOL) human;
-(BOOL) checkForWin;
-(void) scoreDeduction;
-(void) resetOriginalBoard;

// These methods will rotate the model to the left or right - not the display
// Note: this assumes a square (equilateral) matrix.

-(void) rotateLeft;
-(void) rotateRight;

-(NSInteger) tile: (NSInteger) path ExistsIn:(NSMutableArray*) array;


- (void)encodeWithCoder:(NSCoder *)coder;
- (id)initWithCoder:(NSCoder *)coder;

@end
