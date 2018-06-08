//
//  MYShistory_ViewController.h
//  GDota
//
//  Created by lemon on 27/10/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYShistory_ViewController : UIViewController<UITableViewDelegate , UITableViewDataSource>
//战绩ID
@property (nonatomic , copy) NSString *match_id;

@end
