//
//  UIBarButtonItem+MMY_Extension.h
//  WeiBo_text_1
//
//  Created by Lemon on 17/9/19.
//  Copyright © 2017年 Lemon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (MMY_Extension)
//封装创建导航栏左右按钮，添加图片并添加按钮事件
+(UIBarButtonItem *)createItemWithTarget:(id) target image_name:(NSString *) image_name action:(SEL) action;

@end
