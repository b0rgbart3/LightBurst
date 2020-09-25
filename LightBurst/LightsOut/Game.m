//
//  Game.m
//  LightsOut
//
//  Created by Bart Dority on 5/8/13.
//  Copyright (c) 2013 Bart Dority. All rights reserved.
//

#import "Game.h"

@implementation Game

-(void)encodeArray: (NSMutableArray*) array withArrayName: (NSString *)arrayName withCoder: (NSCoder*)coder
{
    //NSLog(@"Encoding Array:%@, %@",arrayName, array);
    NSString *keyName = [arrayName stringByAppendingString:@":count"];
    [coder encodeInteger: array.count forKey:keyName];
    
    for (int i = 0; i < array.count; i++)
    {
        NSString *keyName= [arrayName stringByAppendingFormat:@",%d",i];
        [coder encodeInteger:[[array objectAtIndex:i] integerValue] forKey:keyName];
    }
}

- (void)encodeWithCoder:(NSCoder *)coder {
    //NSLog(@"In the game encoder.");
    [coder encodeInteger:self.columnCount forKey:@"columnCount"];
    [coder encodeInteger:self.rowCount forKey:@"rowCount"];
    [coder encodeInteger:self.tileCount forKey:@"tileCount"];
    [self encodeArray: self.displayBoard withArrayName: @"displayBoard" withCoder: coder];
    [self encodeArray: self.originalBoard withArrayName: @"originalBoard" withCoder: coder];
    [coder encodeInteger:self.sequenceLength forKey:@"sequenceLength"];
    [self encodeArray: self.sequence withArrayName:@"sequence" withCoder:coder];
    [self encodeArray: self.userSequence withArrayName: @"userSequence" withCoder: coder];
    [self encodeArray: self.solutionTiles withArrayName: @"solutionTiles" withCoder: coder];
    [coder encodeInteger:self.color forKey:@"color"];
    [coder encodeBool:self.showSolution forKey:@"showSolution"];
}

-(NSMutableArray*) decodeArray: (NSString*) arrayName withCoder: (NSCoder *) coder
{
    NSMutableArray *array;
    
    //NSLog(@"          arrayName == %@",arrayName);
    
    NSInteger arraySize = [coder decodeIntegerForKey:[arrayName stringByAppendingString:@":count"]];
    if ((arraySize > 0) && (arraySize < 1000))
    {
        array = [[NSMutableArray alloc] initWithCapacity:arraySize];
        for (int i = 0; i < arraySize; i++)
        {
            NSString *decoderKey = [arrayName stringByAppendingFormat:@",%d",i];
            [array addObject:[NSNumber numberWithInteger:[coder decodeIntegerForKey:decoderKey]]];
        }
    }
    
    //NSLog(@"      Array == %@",array);
    return array;
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        //NSLog(@"In the game decoder...");
        _columnCount = [coder decodeIntegerForKey:@"columnCount"];
        _rowCount = [coder decodeIntegerForKey:@"rowCount"];
        _tileCount = [coder decodeIntegerForKey:@"tileCount"];
        _displayBoard = [self decodeArray:@"displayBoard" withCoder: coder];
        _originalBoard = [self decodeArray:@"originalBoard" withCoder: coder];
        _sequenceLength = [coder decodeIntegerForKey:@"sequenceLength"];
        _sequence = [self decodeArray:@"sequence" withCoder:coder];
        _userSequence = [self decodeArray:@"userSequence" withCoder: coder];
        _solutionTiles = [self decodeArray:@"solutionTiles" withCoder: coder];
        _color= [coder decodeIntegerForKey:@"color"];
        _showSolution = [coder decodeBoolForKey:@"showSolution"];
    }
    return self;
}

-(id) init
{
    self = [super init];
    if (self)
    {
        _rowCount = INITIAL_BOARD_SIZE;
        _columnCount = INITIAL_BOARD_SIZE;
        _tileCount = _rowCount * 2;
        _sequenceLength = INITIAL_SEQUENCE_LENGTH;
        
    }
    return self;

}








-(NSInteger) tileCount
{
    _tileCount = _columnCount * _rowCount;
    return _tileCount;
}

// This is my designated initializer

- (id) initWithBoardSize:(NSUInteger)count andSequenceLength: (NSInteger)sequenceLength andColor:(NSInteger) color
{
    self = [super init];
    if (self) {
        
        // Make the minimum matrix size 4.
        if (count < 4)
            count = 4;
        
       // NSLog(@"In Game Model INIT method:  count == %d",count);
        self.columnCount = count;
        self.rowCount = count;
        
        // For now I am just passing the sequence length from the settings object
        // and using it here - but I want to also offer the option of it being random.
        
        self.sequenceLength = sequenceLength;  // arc4random() % ((count*2)-4);
        self.color = color;
        
        //NSLog(@"About to generate the board.");
        [self generateBoard];
        
        self.cheatCount = 0;
        
    }
    return self;
}

// Getter for the userSequence array
-(NSMutableArray *) userSequence
{
    if (!_userSequence)
    {
        _userSequence = [[NSMutableArray alloc] init];
    }
    
    return _userSequence;
}


-(void) generateRandomSequence
{
    // Create the sequence Array, based on whatever the sequenceLength has been set to
    // (I don't know quite how it will ultimately be set, but for now it is in the Game init)
    
    //NSLog(@"In generateRandomSequence, SL == %d",self.sequenceLength);
    
    self.sequence = [NSMutableArray arrayWithCapacity:self.sequenceLength];
    
    for (int i = 0; i < self.sequenceLength; i++)
    {
        NSInteger randomPath = arc4random() % self.tileCount;
        
        // first check to make sure this tile doesn't already exist in our sequence.
        NSInteger tileExists = [self tile:randomPath ExistsIn:self.sequence];
        
        // while it exists in the sequence,
        // then just keep getting a different random# and checking that one
        while (tileExists != -1)
        {
            randomPath = arc4random() % self.tileCount;
            tileExists = [self tile:randomPath ExistsIn:self.sequence];
        }
        
        [self.sequence addObject:[NSNumber numberWithInt:(int)randomPath]];
        
    }
    
    //NSLog(@"Sequence Length == %d", self.sequence.count);
}

//----------------------------------------------------------------

-(void) updateSolution: (NSInteger) tilePath
{

    //NSNumber *tile = [self.displayBoard objectAtIndex:tilePath];
    
    //float scorePercentage = .1;
    //if (self.moveCount > 0)
      //scorePercentage = (float) self.moveCount / (float) self.sequenceLength;
    
//    NSLog(@"ScorePercentage : %f", scorePercentage);
    // If the tile we just touched is in the solution set, then we can take it out.
  
    
    NSInteger solutionLocation = [self tile:tilePath ExistsIn: self.solutionTiles];
    
    if ((solutionLocation >=0 )&&(solutionLocation < self.solutionTiles.count))
    {
        // The selection was part of the solution, so we remove it from the
        // solution array.
        
        [self.solutionTiles removeObjectAtIndex:solutionLocation];
        
        
        //New way of scoring:
     //   self.score += (int) (self.sequenceLength);
        
       // if (self.moveCount < self.sequenceLength)
         //   self.score += self.sequenceLength;
        
        
        
        /* The old way of scoring
        if (self.moveCount < self.sequenceLength)
          self.score += self.columnCount * (scorePercentage * 10)	;
        else
            self.score += self.columnCount;*/
        
    }
    else
    {
    // Otherwise, add it.
            [self.solutionTiles addObject:[NSNumber numberWithInteger:tilePath]];
        
        //New way of scoring:
        
        
    //    self.score -= (int) (self.sequenceLength );  //+ (myPercentage)
    //    if (self.moveCount > self.sequenceLength)
     //       self.score -= (int) (self.sequenceLength /2 );
        
        
        
        // old way of scoring
       /* self.score -= self.columnCount * scorePercentage;*/
        
    }
    
    //self.score = (self.rowCount * self.rowCount) - (self.moveCount - self.sequenceLength);
   
    //NSLog(@"Score == %d", self.score);
    
    
}

-(void) flipTile:(NSInteger)tilePath humanTouch:(BOOL) human
{
    NSNumber *tile = [self.displayBoard objectAtIndex:tilePath];
    
    NSNumber *on = [NSNumber numberWithBool:YES];
    NSNumber *off = [NSNumber numberWithBool:NO];
    
    if ([tile integerValue] == 0)
    {
        [self.displayBoard replaceObjectAtIndex:tilePath withObject:on];
    }
    else
    {
        [self.displayBoard replaceObjectAtIndex:tilePath withObject:off];
    }
    

}

-(NSMutableArray*) getNeighbors:(NSInteger)tilePath
{
    NSMutableArray* neighbors;
    
    neighbors = [NSMutableArray arrayWithCapacity:4];
    
    NSInteger row = tilePath / self.rowCount;
    NSInteger column = tilePath - (row*self.columnCount);
    
    NSInteger top =-1;
    NSInteger left=-1;
    NSInteger right=-1;
    NSInteger bottom=-1;
    
    if (row>0)
    {
        top = (row-1)*self.columnCount + column;
    }
    
    if (column > 0)
    {
        left = (column-1) + (row *self.columnCount);
    }
    
    if (row < (self.rowCount-1))
    {
        bottom = ((row+1) * self.columnCount) + column;
    }
    
    if (column < (self.columnCount-1))
    {
        right = (row*self.columnCount) + (column + 1);
    }

    [neighbors addObject:[NSNumber numberWithInteger:top]];
    [neighbors addObject:[NSNumber numberWithInteger:left]];
    [neighbors addObject:[NSNumber numberWithInteger:bottom]];
    [neighbors addObject:[NSNumber numberWithInteger:right]];
    
    //NSLog(@"For tile: %d, top == %d, left == %d, bottom=%d, right=%d\n",tilePath, top, left, bottom, right);

    return neighbors;
}

// this is a generic method that searches an array for a value
// and then returns either the location of the value in the array,
// or -1 if it is not found.  This method probably already exists
// within the NSMutableArray Class, but I will research that later.

-(NSInteger) tile: (NSInteger) path ExistsIn:(NSMutableArray*) array
{
    for (int i = 0; i < array.count; i++)
    {
        if ([[array objectAtIndex:i] integerValue] == path)
        {
            return i;
        }
    }
    return -1;
}

// this method updates the User Sequence
-(void) updateUserSequence: (NSInteger) tilePath
{
    NSInteger location = [self tile: tilePath ExistsIn:self.userSequence];
    
    // If the user has already hit this tile, then hitting it again is the same as
    // not having hit it at all, so we remove it from the userSequence
    
    if ((location >= 0) && (location < self.userSequence.count))
    {
        [self.userSequence removeObjectAtIndex:location];
        
    }
    else
    {
        [self.userSequence addObject:[NSNumber numberWithInteger:tilePath]];
    }
}

// Note:  'touching' a tile is just for the tiles that are getting touched,
// whereas 'flipping' tiles happens to neighboring tiles as well.
// But we pass the humanTouch element, to determine if this is a user-hit,
// or just part of the game-display setup.

-(NSMutableArray *) touchTileAt:(NSInteger)tilePath humanTouch:(BOOL) human
{
    if (human)
    {
        [self updateUserSequence:tilePath];
        [self updateSolution:tilePath];
        self.moveCount++;
    }
    
    // flip the tile that got touched.
    [self flipTile:tilePath humanTouch:human];
    
    // then flip it's neighbors
    NSMutableArray *neighbors = [self getNeighbors:tilePath];

    for (int i = 0; i < neighbors.count; i++)
    {
        NSInteger neighbor = [[neighbors objectAtIndex:i] integerValue];
        
        if (neighbor >=0 && neighbor <= self.tileCount)
        {
            [self flipTile:neighbor humanTouch:human];
        }
        
    }
    return neighbors;
}

// Steps through the sequence to determine what tiles will be on after
// 'digitally touching' all the tiles in the sequence.
// (because touching tiles, even digitally, will affect the on/ off
// state of it's neighbors.

-(void) interpretSequence
{
    for (int i = 0; i < self.sequenceLength; i++)
    {
        NSInteger currentTilePath = [[self.sequence objectAtIndex:i] integerValue];
        
        if (currentTilePath >= 0 && currentTilePath <= self.tileCount)
        {
            [self touchTileAt:currentTilePath humanTouch:NO];
        }
        
    }
}

-(NSMutableArray *) rotateArrayLeft: (NSMutableArray *) array withSize: (NSInteger) arraySize
{

    NSMutableArray *newArray;
    
    newArray = [NSMutableArray arrayWithCapacity:arraySize * arraySize];
    int start = 0;
    
    for (int row = 0; row < arraySize; row++)
    {
        start = ((int) arraySize-1) - row;
        for (int column = 0; column < arraySize; column++)
        {
            int index = start + (column * (int) arraySize);
            
            [newArray addObject:[array objectAtIndex:index]];
        }
    }

    return newArray;
}

-(NSMutableArray *) rotateArrayRight: (NSMutableArray *) array withSize: (NSInteger) arraySize
{
    
    NSMutableArray *newArray;
    
    newArray = [NSMutableArray arrayWithCapacity:arraySize * arraySize];
    int start = 0;
    
    for (int row = 0; row < arraySize; row++)
    {
        start = ((int)arraySize-1) * (int)arraySize + row;
        
        for (int column = 0; column < arraySize; column++)
        {
            int index = start - (column * (int)arraySize);
            
            [newArray addObject:[array objectAtIndex:index]];
        }
    }
    
    return newArray;
}

-(NSMutableArray *) rotateSequenceLeft: (NSMutableArray *) array withSize: (NSInteger) arraySize
{
    NSMutableArray *newArray;
    
    int sequenceLength = (int) [array count];
    
    newArray = [NSMutableArray arrayWithCapacity:sequenceLength];
    NSInteger startPosition = ((arraySize -1) *arraySize);
    
    for (int i = 0; i < sequenceLength; i++)
    {
        NSInteger row = [[array objectAtIndex:i] integerValue] / arraySize;
        NSInteger column = [[array objectAtIndex:i] integerValue] % arraySize;
        
        int newValue = ((int) startPosition + (int) row) - ((int) column * (int) arraySize);
        
        [newArray addObject:[NSNumber numberWithInt:newValue]];
        
    }
    
    
    return newArray;
    
}

-(NSMutableArray *) rotateSequenceRight: (NSMutableArray *) array withSize: (NSInteger) arraySize
{
    NSMutableArray *newArray;
    
    int sequenceLength = (int) [array count];
    
    newArray = [NSMutableArray arrayWithCapacity:sequenceLength];
    NSInteger startPosition = (arraySize -1);
    
    for (int i = 0; i < sequenceLength; i++)
    {
        NSInteger row = [[array objectAtIndex:i] integerValue] / arraySize;
        NSInteger column = [[array objectAtIndex:i] integerValue] % arraySize;
        
        
        int newValue = ((int) startPosition - (int) row) + ((int) column * (int) arraySize);
        
        [newArray addObject:[NSNumber numberWithInt:newValue]];
        
    }
    
    
    return newArray;
    
}




-(void) rotateLeft
{
    self.displayBoard = [self rotateArrayLeft:self.displayBoard withSize:self.columnCount];
    self.originalBoard = [self rotateArrayLeft:self.originalBoard withSize:self.columnCount];
    self.sequence = [self rotateSequenceLeft:self.sequence withSize:self.columnCount];
    self.userSequence = [self rotateSequenceLeft:self.userSequence withSize:self.columnCount];
    self.solutionTiles = [self rotateSequenceLeft:self.solutionTiles withSize:self.columnCount];
                       
}

-(void) rotateRight
{
    self.displayBoard = [self rotateArrayRight:self.displayBoard withSize:self.columnCount];
    self.originalBoard = [self rotateArrayRight:self.originalBoard withSize:self.columnCount];
    self.sequence = [self rotateSequenceRight:self.sequence withSize:self.columnCount];
    self.userSequence = [self rotateSequenceRight:self.userSequence withSize:self.columnCount];
    self.solutionTiles = [self rotateSequenceRight:self.solutionTiles withSize:self.columnCount];
    
}


// Creates the displayBoard Array - and initializes it to all OFF
-(void) createBoard
{
    self.displayBoard = [NSMutableArray arrayWithCapacity:self.columnCount * self.rowCount];
    
    //NSLog(@"In createBoard, %d x %d",self.columnCount, self.rowCount);
    for (int i = 0; i < self.rowCount; i++)
    {
        for (int j = 0; j < self.columnCount; j++)
        {
            [self.displayBoard addObject:[NSNumber numberWithBool:NO]];
        }
    }

}

-(void) scoreDeduction {
    self.score = self.score - ((int) self.rowCount * (int) self.rowCount);
}

-(void) generateBoard
{
    //NSLog(@"In generateBoard.");
    [self createBoard];

    // Let's start just by creating a random sequence.
    // Later on, I will add the ability to load in preset sequences.
    //NSLog(@"About to generate Random Sequence.");
    [self generateRandomSequence];
    //NSLog(@"FInished generating random sequence.");
    // at first, the solution tiles are the same as the sequence array.
    // But after the user starts touching tiles, then the solution tiles will change
    // to reflect what the 'current solution' is.
    
    self.solutionTiles = [NSMutableArray arrayWithArray:(NSMutableArray *)self.sequence];
    self.userSequence = nil;   // user hasn't hit any tiles yet
    self.moveCount = 0;
    self.score = 0;
    
    [self interpretSequence];
    
    self.originalBoard = [NSMutableArray arrayWithArray:self.displayBoard];
}

-(void) resetOriginalBoard
{
    self.displayBoard = [NSMutableArray arrayWithArray:self.originalBoard];
    self.solutionTiles = [NSMutableArray arrayWithArray:self.sequence];
    self.userSequence = nil;
    //self.moveCount = 0;
    self.score = 0;
}


-(BOOL) checkForWin
{
    BOOL win = YES;
    
    for (int i=0; i < self.tileCount; i++)
    {
        if ([[self.displayBoard objectAtIndex:i] integerValue] == 1)
            win = NO;
    }
    
    //NSLog(@"In checkForWin, tilecount = %d",self.tileCount);
    
    if (win)
    {
        self.score += (int) self.rowCount * (int) self.rowCount;
    }
    return win;
}


@end
