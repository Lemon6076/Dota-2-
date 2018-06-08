//
//  MYSfriends.h
//  GDota
//
//  Created by lemon on 9/11/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYSfriends : NSObject

/**steamID*/
@property (nonatomic , copy) NSString *steamid;

-(instancetype)friendWithDict:(NSDictionary *)dict;
+(instancetype)friendWithDict:(NSDictionary *)dict;

@end
