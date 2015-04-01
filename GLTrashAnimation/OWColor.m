//
//  OWColor.m
//  OWUIKit
//
//  Created by  grenlight on 11-9-3.
//  Copyright (c) 2011年 grenlight. All rights reserved.
//

#import "OWColor.h"

@implementation OWColor

+ (UIColor*) colorWithHex:(long)hexColor;
{
    return [OWColor colorWithHex:hexColor alpha:1.];    
}

+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity
{
    float red = ((float)((hexColor & 0xFF0000) >> 16))/255.0;
    float green = ((float)((hexColor & 0xFF00) >> 8))/255.0;
    float blue = ((float)(hexColor & 0xFF))/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:opacity];  
}

+ (UIColor *)colorWithRgb:(NSString *)rgbStri
{
    NSArray *rgb = [rgbStri componentsSeparatedByString:@","];
    return [UIColor colorWithRed:[(NSNumber *)rgb[0] intValue]/255.0f
                           green:[(NSNumber *)rgb[1] intValue]/255.0f
                            blue:[(NSNumber *)rgb[2] intValue]/255.0f
                           alpha:(rgb.count == 4) ? [(NSNumber *)rgb[3] intValue]/255.0f : 1.0f];
}

+ (UIColor *) colorWithHexString: (NSString *) hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
            red   = [self colorComponentFrom: colorString start: 1 length: 1];
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
            red   = [self colorComponentFrom: colorString start: 2 length: 2];
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            NSLog(@"不合规范的颜色值:%@",hexString);
            return [UIColor clearColor];
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

+ (NSArray *) gradientColorWithHexString:(NSString *)hexString
{
    NSArray *colors = [hexString componentsSeparatedByString:@","];
    NSString *color1 = [[colors[0] stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    NSString *color2 = [[colors[(colors.count > 1) ? 1 :0] stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    float alpha, red, green, blue, alpha2, red2, green2, blue2;
    
    switch ([color1 length]) {
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom: color1 start: 0 length: 2];
            green = [self colorComponentFrom: color1 start: 2 length: 2];
            blue  = [self colorComponentFrom: color1 start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: color1 start: 0 length: 2];
            red   = [self colorComponentFrom: color1 start: 2 length: 2];
            green = [self colorComponentFrom: color1 start: 4 length: 2];
            blue  = [self colorComponentFrom: color1 start: 6 length: 2];
            break;
        default:
            NSLog(@"不合规范的颜色值:%@",hexString);
            alpha = red = green = blue = 0;

            break;
    }
    
    switch ([color2 length]) {
        case 6: // #RRGGBB
            alpha2 = 1.0f;
            red2   = [self colorComponentFrom: color2 start: 0 length: 2];
            green2 = [self colorComponentFrom: color2 start: 2 length: 2];
            blue2  = [self colorComponentFrom: color2 start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha2 = [self colorComponentFrom: color2 start: 0 length: 2];
            red2   = [self colorComponentFrom: color2 start: 2 length: 2];
            green2 = [self colorComponentFrom: color2 start: 4 length: 2];
            blue2  = [self colorComponentFrom: color2 start: 6 length: 2];
            break;
        default:
            NSLog(@"不合规范的颜色值:%@",hexString);
            alpha2 = red2 = green2 = blue2 = 0;
            break;
    }
    NSArray *arr = [NSArray arrayWithObjects:[NSNumber numberWithFloat:red],
                    [NSNumber numberWithFloat:green], [NSNumber numberWithFloat:blue],
                    [NSNumber numberWithFloat:alpha], [NSNumber numberWithFloat:red2],
                    [NSNumber numberWithFloat:green2],[NSNumber numberWithFloat:blue2],
                    [NSNumber numberWithFloat:alpha2],nil];
    return arr;
}

+ (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

@end
