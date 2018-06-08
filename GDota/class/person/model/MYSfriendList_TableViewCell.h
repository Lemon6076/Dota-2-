//
//  MYSfriendList_TableViewCell.h
//  GDota
//
//  Created by lemon on 12/11/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYSfriendList_TableViewCell : UITableViewCell

/**名字label*/
@property (nonatomic,strong) UILabel *nameLabel;
/**状态label*/
@property (nonatomic,strong) UILabel *stateLabel;
/**上次上线时间label*/
@property (nonatomic,strong) UILabel *timeLabel;

@end
