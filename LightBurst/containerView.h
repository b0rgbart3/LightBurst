//
//  containerView.h
//  LightBurst
//
//  Created by Bart Dority on 9/21/20.
//

#ifndef containerView_h
#define containerView_h

#import <UIKit/UIKit.h>
#import "StandardButton.h"

@interface containerView : UIView

@property StandardButton *myButton;

- (id)initWithLeft:(CGFloat)left top:(CGFloat) top size:(CGFloat) size image:(NSString *) image label:(NSString *) label andHue: (CGFloat) hue;


@end

#endif /* containerView_h */
