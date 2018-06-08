//
//  MYSfriendData_ViewController.h
//  GDota
//
//  Created by lemon on 12/11/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYSfriendData_ViewController : UIViewController
//创建头像
-(void)createHeadImageWithImageUrl:(NSString *)imageUrl;
//赋值对应信息
-(void)createDetailsWithDetails:(NSMutableArray *)details;
//赋值主页url
@property (nonatomic , copy)NSString *homePageUrl;

@end
