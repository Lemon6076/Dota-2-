//
//  MYSfriendList_TableViewCell.m
//  GDota
//
//  Created by lemon on 12/11/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import "MYSfriendList_TableViewCell.h"

@implementation MYSfriendList_TableViewCell

//重写覆盖初始化方法
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    //调用父类的初始化方法
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        //创建对象并添加到容器
        //名字label
        UILabel *nameLabel=[[UILabel alloc]init];
        [nameLabel setFont:[UIFont boldSystemFontOfSize:15.0f]];
        [self .contentView addSubview:nameLabel];
        
        
        //状态label
        UILabel *stateLabel=[[UILabel alloc]init];
        [stateLabel setFont:[UIFont boldSystemFontOfSize:12.0f]];
        [stateLabel setTextColor:[UIColor grayColor]];
         stateLabel.textAlignment = NSTextAlignmentRight;
        [self .contentView addSubview:stateLabel];
        
        //时间label
        UILabel *timeLable=[[UILabel alloc]init];
        [timeLable setFont:[UIFont boldSystemFontOfSize:10.0f]];
        [timeLable setTextColor:[UIColor grayColor]];
        timeLable.textAlignment = NSTextAlignmentRight;
        [self .contentView addSubview:timeLable];

        //赋值
        _nameLabel=nameLabel;
        _stateLabel = stateLabel;
        _timeLabel=timeLable;
        
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat cellW = self.size.width;
    CGFloat cellH = self.size.height;
    //位置大小
    _nameLabel.frame=CGRectMake(80,-17,150, 50);
    
    _stateLabel.frame=CGRectMake(cellW-90,-17,80, 50);
    
    _timeLabel.frame=CGRectMake(cellW-210, cellH-30,200,30);
    
}


@end
