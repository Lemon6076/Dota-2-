//
//  MYSheros_TableViewCell.h
//  GDota
//
//  Created by lemon on 7/11/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYSheros_TableViewCell : UITableViewCell
/**英雄image*/
@property (nonatomic , strong) UIImageView *heroImage;
/**英雄名字*/
@property (nonatomic , strong) UILabel *heroLabel;
/**战斗类型*/
@property (nonatomic , strong) UILabel *atkLabel;
/**英雄定位*/
@property (nonatomic , strong) UILabel *rolesLabel;
@end
