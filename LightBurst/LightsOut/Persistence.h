//
//  Persistence.h
//  LightsOut
//
//  Created by Bart Dority on 5/11/13.
//  Copyright (c) 2013 Bart Dority. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Persistence : NSObject

+ (void) saveObject: (NSObject*) thisObject withFileName: (NSString *) filename;
+ (id) loadObjectfromFileName: (NSString *) filename;


@end
