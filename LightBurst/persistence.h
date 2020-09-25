//
//  Persistence.h
//  LightBurst
//
//  Created by Bart Dority on 9/21/20.
//

#ifndef Persistence_h
#define Persistence_h

@interface Persistence : NSObject

+ (void) saveObject: (NSObject*) thisObject withFileName: (NSString *) filename;
+ (id) loadObjectfromFileName: (NSString *) filename;


@end


#endif /* Persistence_h */
