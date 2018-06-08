//
//  MYS_searchBar.h
//  GDota
//
//  Created by lemon on 7/11/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYS_searchBar : UISearchBar
/**自定义搜索框*/
+(UITextField *)createBarWithPlaceholder:(NSString *) placeholder Frame:(CGRect)frame;


@end
