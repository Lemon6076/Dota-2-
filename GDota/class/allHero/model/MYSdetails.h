//
//  MYSdetails.h
//  GDota
//
//  Created by lemon on 7/11/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYSdetails : NSObject
/**战斗类型*/
@property (nonatomic , copy) NSString *atk_l;
/**英雄来历*/
@property (nonatomic , copy) NSString *bio;
/**英雄名字*/
@property (nonatomic , copy) NSString *name;
/**英雄职业定位*/
@property (nonatomic , strong)NSArray *roles_l;

-(instancetype)detailsWithDict:(NSDictionary *)dict;
+(instancetype)detailsWithDict:(NSDictionary *)dict;

@end
