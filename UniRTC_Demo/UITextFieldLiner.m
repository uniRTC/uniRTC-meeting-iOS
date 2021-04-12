//
//  UITextFileLiner.m
//  ULink
//
//  Created by lhy on 2020/3/7.
//  Copyright © 2020 lhy. All rights reserved.
//

#import "UITextFieldLiner.h"
@implementation UITextFieldLiner

-(void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:162/255.0 green:162/255.0 blue:162/255.0 alpha:1.0].CGColor);
    CGContextFillRect(context, CGRectMake(0, CGRectGetHeight(self.frame)-1, CGRectGetWidth(self.frame), 1));
}
@end
