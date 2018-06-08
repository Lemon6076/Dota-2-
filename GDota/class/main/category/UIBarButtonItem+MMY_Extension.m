//
//  UIBarButtonItem+MMY_Extension.m
//  WeiBo_text_1
//
//  Created by Lemon on 17/9/19.
//  Copyright © 2017年 Lemon. All rights reserved.
//


@implementation UIBarButtonItem (MMY_Extension)
/**
 *  导航栏按钮
 *
 *  @param target     目标对象
 *  @param image_name 图标名字
 *  @param action     执行动作
 *
 *  @return 按钮对象
 */
+(UIBarButtonItem *)createItemWithTarget:(id) target image_name:(NSString *) image_name action:(SEL) action
{
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:image_name] forState:UIControlStateNormal];
    //按钮按下的图片样式
    NSString *seleteImage_name = [image_name stringByAppendingString:@"_highlighted"];
    [btn setImage:[UIImage imageNamed:seleteImage_name] forState:UIControlStateHighlighted];
    //设置按钮frame
    btn.frame = CGRectMake(2, 2, 22, 22);
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    //添加按钮事件
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return item;
}

@end
