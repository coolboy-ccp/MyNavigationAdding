//
//  UIView+MyExtension.m
//  MyNavigationAdding
//
//  Created by liqunfei on 15/8/19.
//  Copyright (c) 2015年 chuchengpeng. All rights reserved.
//

#import "UIView+MyExtension.h"

@implementation UIView (MyExtension)

- (void)setDop_x:(CGFloat)dop_x {
    CGRect frame = self.frame;
    frame.origin.x = dop_x;
    self.frame = frame;
}

- (CGFloat)dop_x {
    return self.frame.origin.x;
}

- (void)setDop_y:(CGFloat)dop_y {
    CGRect frame = self.frame;
    frame.origin.y = dop_y;
    self.frame = frame;
}

- (CGFloat)dop_y {
    return self.frame.origin.y;
}

- (void)setDop_width:(CGFloat)dop_width {
    CGRect frame = self.frame;
    frame.size.width = dop_width;
    self.frame = frame;
}

- (CGFloat)dop_width {
    return self.frame.size.width;
}

- (void)setDop_height:(CGFloat)dop_height {
    CGRect frame = self.frame;
    frame.size.height = dop_height;
    self.frame = frame;
}

- (CGFloat)dop_height {
    return self.frame.size.height;
}

- (void)setDop_size:(CGSize)dop_size {
    CGRect frame = self.frame;
    frame.size = dop_size;
    self.frame = frame;
}

- (CGSize)dop_size {
    return self.frame.size;
}

- (void)setDop_origin:(CGPoint)dop_origin {
    CGRect frame = self.frame;
    frame.origin = dop_origin;
    self.frame = frame;
}

- (CGPoint)dop_origin {
    return self.frame.origin;
}
@end
