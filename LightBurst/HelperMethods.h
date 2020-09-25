//
//  HelperMethods.h
//  LightBurst
//
//  Created by Bart Dority on 9/21/20.
//

#ifndef HelperMethods_h
#define HelperMethods_h


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define ROUNDED_CORNER_SIZE 10
#define STANDARD_BUTTON_WIDTH = 300;
#define STANDARD_BUTTON_HEIGHT = 80;


@interface HelperMethods : NSObject


+(void) drawBoxWithColor: (UIColor*) color
                     stroke:(UIColor*) stroke
                     bounds: (CGRect) bounds;


//+(void) changeTextColorOfButton: (UIButton *) thisButton to:(UIColor*) newColor forState: (UIControlState) state;

+(UIButton *) createAButton: (NSString *) string at:(float) left and:(float) top ofWidth:(float) width andHeight: (float) height;

//+(UIView *) createAnIconButton: (NSString *) string at:(float) left and:(float) top ofSize:(float) size withImage:(NSString *) image withColor: (UIColor *) color;

+(UILabel *) createALabel: (NSString *) string ofSize: (float) labelSize withFrame:(CGRect)labelFrame;



@end


#endif /* HelperMethods_h */
