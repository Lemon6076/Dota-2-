//
//  MYSmatch_TableViewCell.h
//  GDota
//
//  Created by lemon on 12/11/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYSmatch_TableViewCell : UITableViewCell

/**匹配类型label*/
@property (nonatomic,strong) UILabel *lobbyLable;
/**天辉label*/
@property (nonatomic,strong) UILabel *slot1Label;
/**夜魇label*/
@property (nonatomic,strong) UILabel *slotaLabel;
/**比赛IDlabel*/
@property (nonatomic,strong) UILabel *matchIDLabel;
/**比赛时间label*/
@property (nonatomic,strong) UILabel *startTimeLabel;
/**比赛结果 胜 label*/
@property (nonatomic,strong) UILabel *winLabel;
/**登录玩家所在的阵营下标*/
@property (nonatomic , strong)UIImageView *indexView_1;
@property (nonatomic , strong)UIImageView *indexView_a;


//天辉
/**英雄头像image*/
@property (nonatomic , strong) UIImageView *heroImage0;
/**英雄头像image*/
@property (nonatomic , strong) UIImageView *heroImage1;
/**英雄头像image*/
@property (nonatomic , strong) UIImageView *heroImage2;
/**英雄头像image*/
@property (nonatomic , strong) UIImageView *heroImage3;
/**英雄头像image*/
@property (nonatomic , strong) UIImageView *heroImage4;
//夜魇
/**英雄头像image*/
@property (nonatomic , strong) UIImageView *heroImagea;
/**英雄头像image*/
@property (nonatomic , strong) UIImageView *heroImageb;
/**英雄头像image*/
@property (nonatomic , strong) UIImageView *heroImagec;
/**英雄头像image*/
@property (nonatomic , strong) UIImageView *heroImaged;
/**英雄头像image*/
@property (nonatomic , strong) UIImageView *heroImagee;




@end
