//
//  MYSheroAbility.h
//  GDota
//
//  Created by lemon on 1/12/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYSheroAbility : NSObject

/**技能效果*/
@property (nonatomic , copy) NSString *desc;
/**技能名*/
@property (nonatomic , copy) NSString *dname;
/**所属英雄名*/
@property (nonatomic , copy) NSString *hurl;

-(instancetype)heroAbilityWithDict:(NSDictionary *)dict;
+(instancetype)heroAbilityWithDict:(NSDictionary *)dict;


@end
