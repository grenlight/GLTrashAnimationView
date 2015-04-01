//
//  OWColor.h
//  OWUIKit
//
//  Created by  grenlight on 11-9-3.
//  Copyright (c) 2011年 grenlight. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OWColor : NSObject

+ (UIColor *)colorWithHex:(long)hexColor;

+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity;

+ (UIColor *)colorWithHexString: (NSString *) hexString;

//@"33,255,255"
+ (UIColor *)colorWithRgb:(NSString *)rgb;

//@"#ff0000,#ff3333"
+ (NSArray *)gradientColorWithHexString: (NSString *)hexString;

@end
