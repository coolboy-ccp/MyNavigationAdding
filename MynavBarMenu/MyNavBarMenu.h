//
//  MyNavBarMenu.h
//  MyNavigationAdding
//
//  Created by liqunfei on 15/8/19.
//  Copyright (c) 2015年 chuchengpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIGestureRecognizerSubclass.h>
#import "UIView+MyExtension.h"

@interface UITouchGestureRecognizer : UIGestureRecognizer

@end

@interface MyNavBarItem : NSObject
@property (copy,nonatomic,readonly) NSString *title;
@property (strong,nonatomic,readonly) UIImage *icon;

- (instancetype)initWithTitle:(NSString *)title icon:(UIImage *)iconImage;
+ (MyNavBarItem *)ItemWithTitle:(NSString *)title icon:(UIImage *)iconImage;

@end

@class MyNavBarMenu;
@protocol MyNavBarMenuDelegate <NSObject>

- (void)didShowMenu:(MyNavBarMenu *)menu;
- (void)didDimissMenu:(MyNavBarMenu *)menu;
- (void)didSelectedMenu:(MyNavBarMenu *)menu atIndex:(NSInteger)index;
@end

@interface MyNavBarMenu : UIView
@property (copy,nonatomic,readonly) NSArray *items;
@property (assign,nonatomic,readonly) NSInteger maximumNumberInRow;
@property (assign,nonatomic,getter=isOpen) BOOL open;
@property (weak,nonatomic) id <MyNavBarMenuDelegate> delegate;
@property (strong,nonatomic) UIColor *textColor;
@property (strong,nonatomic) UIColor *separatarColor;

- (instancetype)initWithItems:(NSArray *)items width:(CGFloat)width maximumNumberInRow:(NSInteger)max;
- (void)showInNavigationController:(UINavigationController *)navc;
- (void)dismissWithAnimation:(BOOL)animation;
@end
