//
//  MYSabilityDetailTableViewCell.h
//  GDota
//
//  Created by lemon on 1/12/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYSabilityDetailTableViewCell : UITableViewCell

/**技能image*/
@property (nonatomic , strong) UIImageView *abilityImage;
/**技能名字*/
@property (nonatomic , strong) UILabel *dnameLabel;
/**技能效果*/
@property (nonatomic , strong) UILabel *descLabel;

@end
