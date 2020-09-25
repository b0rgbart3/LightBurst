//
//  panelBox.h
//  LightBurst
//
//  Created by Bart Dority on 9/21/20.
//

#ifndef panelBox_h
#define panelBox_h
#import <UIKit/UIKit.h>

@interface panelBox : UIView

@property BOOL special;
@property UIColor *smallBoxColor;


- (id)initWithFrame:(CGRect)frame andColor:(UIColor*)smallBoxColor;
-(void) turnOnSmallBox;


@end


#endif /* panelBox_h */
