//
//  MYSletfMenu_TableViewCell.h
//  GDota
//
//  Created by lemon on 7/11/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYSletfMenu_TableViewCell : UITableViewCell
/**内容label*/
@property (nonatomic,strong) UILabel *contentLable;
/**加粗汉堡菜单label*/
@property (nonatomic,strong) UILabel *letfMenuLabel;
/**用户名label*/
@property (nonatomic,strong) UILabel *userLabel;
/**图标image*/
@property (nonatomic , strong) UIImageView *iconImage;
/**头像image*/
@property (nonatomic , strong) UIImageView *hearImage;

@end
