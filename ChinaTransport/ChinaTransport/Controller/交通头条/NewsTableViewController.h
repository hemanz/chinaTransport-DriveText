//
//  NewsTableViewController.h
//  ChinaTransport
//
//  Created by 张鹤楠 on 15/9/8.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CycleScrollView.h"

@interface NewsTableViewController : UITableViewController

/**
 *  url端口
 */
@property(nonatomic,copy) NSString *urlString;

@property (nonatomic,assign) NSInteger index;

@property (nonatomic , retain) CycleScrollView *mainScorllView;

@end
