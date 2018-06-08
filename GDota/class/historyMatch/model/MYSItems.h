//
//  MYSItems.h
//  GDota
//
//  Created by lemon on 21/11/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYSItems : NSObject

/**物品ID*/
@property (nonatomic , assign) NSNumber *ID;
/**物品名称*/
@property (nonatomic , copy) NSString *name;

-(instancetype)itemWithDict:(NSDictionary *)dict;
+(instancetype)itemWithDict:(NSDictionary *)dict;
@end
