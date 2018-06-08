//
//  MYS_searchBar.m
//  GDota
//
//  Created by lemon on 7/11/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import "MYS_searchBar.h"

@implementation MYS_searchBar

/**
 *  自定义搜索栏
 *
 *  @param image       搜索图标
 *  @param placeholder 占位
 *  @param frame       frame设置
 *
 *  @return 返回一个textField
 */
+(UITextField *)createBarWithPlaceholder:(NSString *) placeholder Frame:(CGRect)frame{
    //自定义搜索栏
    UITextField *textfield = [[UITextField alloc]init];
    textfield.frame = frame;
    textfield.borderStyle = UITextBorderStyleRoundedRect;
    //创建一个UIImageView对象并添加图片
   // UIImageView *searchIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:image]];
    //searchIcon.frame = CGRectMake(0, 0, 22, 22);
    textfield.textAlignment = NSTextAlignmentCenter;
    //占位
    textfield.placeholder = placeholder;
    //设置clearButton
    textfield.clearsOnBeginEditing = YES;
    textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    //设置文本框左部视图并添加到搜索框
    textfield.leftViewMode = UITextFieldViewModeAlways;
    return textfield;
}

@end
