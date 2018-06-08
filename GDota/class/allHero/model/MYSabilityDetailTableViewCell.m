//
//  MYSabilityDetailTableViewCell.m
//  GDota
//
//  Created by lemon on 1/12/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import "MYSabilityDetailTableViewCell.h"

@implementation MYSabilityDetailTableViewCell

//重写覆盖初始化方法
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    //调用父类的初始化方法
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        
        /**技能image*/
        UIImageView *abilityImage = [[UIImageView alloc]init];
        [self.contentView addSubview:abilityImage];
        [abilityImage setContentMode:UIViewContentModeScaleAspectFit];
        /**技能名字*/
        UILabel *dnameLabel = [[UILabel alloc]init];
        [dnameLabel setTextColor:[UIColor blackColor]];
        [dnameLabel setFont:[UIFont boldSystemFontOfSize:17.0f]];
        //herolabel.textAlignment = NSTextAlignmentCenter;
        [self .contentView addSubview:dnameLabel];
        /**技能效果*/
        UILabel *descLabel = [[UILabel alloc]init];
        [descLabel setTextColor:[UIColor blackColor]];
        [descLabel setFont:[UIFont boldSystemFontOfSize:11.0f]];
        //herolabel.textAlignment = NSTextAlignmentCenter;
        [self .contentView addSubview:descLabel];
        
        
        
        _abilityImage  = abilityImage;
        _dnameLabel = dnameLabel;
        _descLabel = descLabel;
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat cellW = self.size.width;
    CGFloat cellH = self.size.height;
    
    CGFloat imageWH = 90;
    CGFloat dnameLabelH = 15;
    
    _abilityImage.frame = CGRectMake(5, cellH/2-imageWH/2, imageWH, imageWH);
    _dnameLabel.frame = CGRectMake(imageWH+10, 5, MYSScreenW-imageWH, dnameLabelH);
    
    _descLabel.frame = CGRectMake(imageWH+10, dnameLabelH+4, MYSScreenW-imageWH-15, cellH-dnameLabelH);
    _descLabel.numberOfLines = 0;
    

}




@end
