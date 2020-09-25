//
//  Persistence.m
//  LightsOut
//
//  Created by Bart Dority on 5/11/13.
//  Copyright (c) 2013 Bart Dority. All rights reserved.
//

#import "Persistance.h"

@implementation Persistence


+ (void) saveArrayToFile: (NSArray*) array withFileName: (NSString *) filename {
    
    
   NSString *nameWithExtension = [NSString stringWithFormat: @"%@.plist", filename];
    
//    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *path = [documentsDirectory stringByAppendingPathComponent: nameWithExtension];
//
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [path objectAtIndex:0];
    NSString *finalFilename = [documentsDirectory stringByAppendingPathComponent: nameWithExtension];
    
    [array writeToFile:finalFilename atomically: YES];
    
    
//    NSMutableArray* arrayToSave = [NSMutableArray arrayWithCapacity:array.count];
//    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        NSDictionary* exportDict = [NSDictionary dictionaryWithObjectsAndKeys:
//                                    [obj objectForKey:@"username"], @"username",
//                                    [obj objectForKey:@"title"], @"title", nil];
//        [arrayToSave addObject:exportDict];
//    }];

   // [arrayToSave writeToFile:filename atomically:YES];
    
    
    
}

+ (void) saveObject: (NSObject*) thisObject withFileName: (NSString *) filename {
//    NSString *nameWithExtension = [NSString stringWithFormat: @"%@.plist", filename];
//    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *path = [documentsDirectory stringByAppendingPathComponent: nameWithExtension];
//
//
//    BOOL success = [NSKeyedArchiver archiveRootObject:thisObject toFile:path];
//    if (success)
//    {
//        //NSLog(@"Success");
//    }
    
    NSError *error = nil;

    NSString *docsDir;
    NSArray *dirPaths;

    //Get the device's data directory:
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    NSString *databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent:@"appData.data"]];

    //Archive using iOS 12 compliant coding:
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:@"foo" requiringSecureCoding:NO error:&error];
    [data writeToFile:databasePath options:NSDataWritingAtomic error:&error];
    NSLog(@"Write returned error: %@", [error localizedDescription]);


    
    
}

+ (id) loadObjectfromFileName: (NSString *) filename {
   
//    NSString *nameWithExtension = [NSString stringWithFormat: @"%@.plist", filename];
//    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *path = [documentsDirectory stringByAppendingPathComponent: nameWithExtension];
//    NSObject *reconstitutedObject = nil;
//
//    @try {reconstitutedObject = [NSKeyedUnarchiver unarchiveObjectWithFile:path];}
//    @catch (NSException *error)
//    {
//        reconstitutedObject = nil;
//    }
//
//    return reconstitutedObject;
    
    NSError *error = nil;

    NSString *docsDir;
    NSArray *dirPaths;

    //Get the device's data directory:
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    
    NSString *databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent:@"appData.data"]];
    
    //Unarchive the data:
    NSData *newData = [NSData dataWithContentsOfFile:databasePath];
    NSString *fooString = [NSKeyedUnarchiver unarchivedObjectOfClass:[NSString class] fromData:newData error:&error];
    
    return fooString;
    
}

@end


