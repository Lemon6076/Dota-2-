//
//  MYSplayer.h
//  GDota
//
//  Created by lemon on 9/11/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYSplayer : NSObject
/**头像地址*/
@property (nonatomic , copy) NSString *avatarfull;
/**头像地址*/
@property (nonatomic , copy) NSString *avatar;
/**用户名*/
@property (nonatomic , copy) NSString *personaname;
/**用地区*/
@property (nonatomic , copy) NSString *loccountrycode;
/**真实姓名*/
@property (nonatomic , copy) NSString *realname;
/**个人主页*/
@property (nonatomic , copy) NSString *profileurl;
/**steamID*/
@property (nonatomic , copy) NSString *steamid;
/**用户状态*/
@property (nonatomic , assign) NSNumber *personastate;
/**上次登录时间*/
@property (nonatomic , assign) NSNumber *lastlogoff;

-(instancetype)userWithDict:(NSDictionary *)dict;
+(instancetype)userWithDict:(NSDictionary *)dict;

@end
