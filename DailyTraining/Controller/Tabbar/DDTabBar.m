//
//  Daodao
//
//  Created by 郝凡宁 on 15/11/25.
//  Copyright © 2015年 东道道. All rights reserved.
//

#import "DDTabBar.h"

@interface DDTabBar ()

@end

@implementation DDTabBar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self = [self sharedInit];
    }
    return self;
}

- (instancetype)initWithCoder: (NSCoder *)aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {
        self = [self sharedInit];
    }
    return self;
}

- (instancetype)sharedInit {
    [self setBackgroundImage:[self imageWithColor:[UIColor whiteColor]]];
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    UIView *topGrayLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 0.5)];
    topGrayLine.backgroundColor = [UIColor hexStringToColor:@"#cccccc"];
    [self addSubview:topGrayLine];
}

/*
 *
 Capturing touches on a subview outside the frame of its superview
 *
 */
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (!self.clipsToBounds && !self.hidden && self.alpha > 0) {
        for (UIView *subview in self.subviews.reverseObjectEnumerator) {
            CGPoint subPoint = [subview convertPoint:point fromView:self];
            UIView *result = [subview hitTest:subPoint withEvent:event];
            if (result != nil) {
                return result;
            }
        }
    }
    return nil;
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    NSParameterAssert(color != nil);
    
    CGRect rect = CGRectMake(0, 0, 1, 1);
    // Create a 1 by 1 pixel context
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);   // Fill it with your color
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    
}

@end
