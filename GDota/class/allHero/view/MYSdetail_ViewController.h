//
//  MYSdetail_ViewController.h
//  GDota
//
//  Created by lemon on 7/11/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYSdetail_ViewController : UIViewController <UITableViewDelegate , UITableViewDataSource>

/**英雄英文*/
@property (nonatomic , copy)NSString *heroName_en; 
/**创建来历调用*/
-(void)bioWithtext:(NSString *)text;
/**创建退出按钮调用*/
-(void) setUpExitButtonWithName:(NSString *)name;
/**创建背景图调用*/
-(void)backgroundImageWithImageUrl:(NSString *)Url;

@end
