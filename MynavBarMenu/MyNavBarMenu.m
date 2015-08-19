//
//  MyNavBarMenu.m
//  MyNavigationAdding
//
//  Created by liqunfei on 15/8/19.
//  Copyright (c) 2015年 chuchengpeng. All rights reserved.
//

#import "MyNavBarMenu.h"

@implementation UITouchGestureRecognizer

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    self.state = UIGestureRecognizerStateRecognized;
}

@end

@implementation MyNavBarItem

- (instancetype)initWithTitle:(NSString *)title icon:(UIImage *)iconImage {
    self = [super init];
    if (!self) {
        return nil;
    }
    _title = title;
    _icon = iconImage;
    return self;
}

+ (MyNavBarItem *)ItemWithTitle:(NSString *)title icon:(UIImage *)iconImage {
    return [[self alloc] initWithTitle:title icon:iconImage];
}

@end

static NSInteger rowHeight = 100;
static CGFloat titleFontSize = 15.0;
@interface MyNavBarMenu ()

@property (strong,nonatomic) UIView *background;
@property (assign,nonatomic) CGRect beforeAnimationFrame;
@property (assign,nonatomic) CGRect afterAnimationFrame;
@property (assign,nonatomic) NSInteger numberOfRow;

@end

@implementation MyNavBarMenu

- (instancetype)initWithItems:(NSArray *)items width:(CGFloat)width maximumNumberInRow:(NSInteger)max {
    self = [super initWithFrame:CGRectMake(0, 0, width, 0)];
    if (self) {
        _items = items;
        _open = NO;
        _maximumNumberInRow = max;
        _numberOfRow = (_items.count-1)/_maximumNumberInRow + 1;
        self.dop_height = (_numberOfRow +1)*rowHeight;
        self.dop_y = -self.dop_height;
        _beforeAnimationFrame = self.frame;
        _afterAnimationFrame = self.frame;
        self.backgroundColor = [UIColor clearColor];
        _background = [[UIView alloc] initWithFrame:CGRectZero];
        UITouchGestureRecognizer *touchgesture = [[UITouchGestureRecognizer alloc] initWithTarget:self action:@selector(dismissMenu)];
        [_background addGestureRecognizer:touchgesture];
        _textColor = [UIColor whiteColor];
        _separatarColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat buttonWidth = self.dop_height/self.maximumNumberInRow;
    CGFloat buttonHeight = rowHeight;
    [self.items enumerateObjectsUsingBlock:^(MyNavBarItem *obj, NSUInteger idx, BOOL *stop) {
        CGFloat buttonX = (idx % self.maximumNumberInRow) * buttonWidth;
        CGFloat buttonY = ((idx / self.maximumNumberInRow) +1 ) * buttonHeight;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight);
        button.tag = idx;
        [self addSubview:button];
        [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *icon = [[UIImageView alloc] initWithImage:obj.icon];
        icon.center = CGPointMake(buttonWidth/2, buttonHeight/2-15);
        [button addSubview:icon];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, buttonHeight-35, buttonWidth, 20)];
        label.text = obj.title;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = self.textColor;
        label.font = [UIFont systemFontOfSize:titleFontSize];
        [button addSubview:label];
        if ( (idx +1 )%self.maximumNumberInRow != 0) {
            UIView *separatar = [[UIView alloc] initWithFrame:CGRectMake(buttonWidth - 0.5, 0, 0.5, buttonHeight)];
            separatar.backgroundColor = self.separatarColor;
            [button addSubview:separatar];
        }
    }];
}

- (void)showInNavigationController:(UINavigationController *)navc {
    [navc.view insertSubview:self aboveSubview:navc.navigationBar];
    if (CGRectEqualToRect(self.beforeAnimationFrame, self.afterAnimationFrame)) {
        CGRect tmp = self.afterAnimationFrame;
        tmp.origin.y += ([UIApplication sharedApplication].statusBarFrame.size.height+navc.navigationBar.dop_height + rowHeight * self.numberOfRow);
        self.afterAnimationFrame = tmp;
    }
    self.background.frame = navc.view.frame;
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut animations:^{
        self.dop_y = self.afterAnimationFrame.origin.y;
    } completion:^(BOOL finished) {
        if (self.delegate) {
            [self.delegate didShowMenu:self];
        }
        self.open = YES;
    }];
}

- (void)dismissWithAnimation:(BOOL)animation {
    void (^completion)(void) = ^void(void) {
        [self removeFromSuperview];
        [self.background removeFromSuperview];
        if (self.delegate) {
            [self.delegate didDimissMenu:self];
        }
        self.open = NO;
    };
    if (animation) {
        [UIView animateWithDuration:0.2 animations:^{
            self.dop_y += 20;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                 self.dop_y = self.beforeAnimationFrame.origin.y;
            } completion:^(BOOL finished) {
                completion();
            }];
        }];
    }
    else {
        self.dop_y = self.beforeAnimationFrame.origin.y;
        completion();
    }
}
- (void)drawRect:(CGRect)rect {
    // Drawing code
}

- (void)dismissMenu {
    [self dismissWithAnimation:YES];
}

- (void)buttonTapped:(UIButton *)button {
    if (self.delegate) {
        [self.delegate didSelectedMenu:self atIndex:button.tag];
    }
    [self dismissMenu];
}

@end
