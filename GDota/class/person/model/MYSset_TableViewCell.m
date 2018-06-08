//
//  MYSset_TableViewCell.m
//  GDota
//
//  Created by lemon on 1/11/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import "MYSset_TableViewCell.h"

@implementation MYSset_TableViewCell

//重写覆盖初始化方法
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    //调用父类的初始化方法
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        //创建对象并添加到容器
        UILabel *titleLabel=[[UILabel alloc]init];
        [titleLabel setFont:[UIFont boldSystemFontOfSize:15.0f]];
        [self .contentView addSubview:titleLabel];
       

        //小标题
        UILabel *detaiLabel=[[UILabel alloc]init];
        [detaiLabel setFont:[UIFont boldSystemFontOfSize:12.0f]];
        [self .contentView addSubview:detaiLabel];
        
        //退出lable
        UILabel *exitLable=[[UILabel alloc]init];
        [exitLable setFont:[UIFont boldSystemFontOfSize:18.0f]];
        [exitLable setTextColor:[UIColor redColor]];
        exitLable.textAlignment = NSTextAlignmentCenter;
        [self .contentView addSubview:exitLable];
        //背景颜色
        // self.backgroundColor=[UIColor grayColor];
        //赋值
        _titleLabel=titleLabel;
        _detaiLabel = detaiLabel;
        _exitLabel=exitLable;

    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat cellW = self.size.width;
     CGFloat cellH = self.size.height;
    //位置大小
    _titleLabel.frame=CGRectMake(20,cellH/2-40,100, 80);
    
     _detaiLabel.frame=CGRectMake(cellW-100,cellH/2-25,100, 50);

    _exitLabel.frame=CGRectMake(cellW/2-50, cellH/2-30,100,60);
    
}

@end
