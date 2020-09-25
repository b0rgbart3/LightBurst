//
//  Persistence.m
//  LightsOut
//
//  Created by Bart Dority on 5/11/13.
//  Copyright (c) 2013 Bart Dority. All rights reserved.
//

#import "Persistence.h"

@implementation Persistence


+ (void) saveArrayToFile: (NSArray*) array withFileName: (NSString *) filename {
    NSString *nameWithExtension = [NSString stringWithFormat: @"%@.plist", filename];
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documentsDirectory stringByAppendingPathComponent: nameWithExtension];
    
    [array writeToFile: path atomically: YES];
    
}

+ (void) saveObject: (NSObject*) thisObject withFileName: (NSString *) filename {
    NSString *nameWithExtension = [NSString stringWithFormat: @"%@.plist", filename];
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documentsDirectory stringByAppendingPathComponent: nameWithExtension];
    
   
    BOOL success = [NSKeyedArchiver archiveRootObject:thisObject toFile:path];
    if (success)
    {
        //NSLog(@"Success");
    }
    
}

+ (id) loadObjectfromFileName: (NSString *) filename {
   
    NSString *nameWithExtension = [NSString stringWithFormat: @"%@.plist", filename];
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documentsDirectory stringByAppendingPathComponent: nameWithExtension];
    NSObject *reconstitutedObject = nil;
    
    @try {reconstitutedObject = [NSKeyedUnarchiver unarchiveObjectWithFile:path];}
    @catch (NSException *error)
    {
        reconstitutedObject = nil;
    }
    
    return reconstitutedObject;
    
}

@end


