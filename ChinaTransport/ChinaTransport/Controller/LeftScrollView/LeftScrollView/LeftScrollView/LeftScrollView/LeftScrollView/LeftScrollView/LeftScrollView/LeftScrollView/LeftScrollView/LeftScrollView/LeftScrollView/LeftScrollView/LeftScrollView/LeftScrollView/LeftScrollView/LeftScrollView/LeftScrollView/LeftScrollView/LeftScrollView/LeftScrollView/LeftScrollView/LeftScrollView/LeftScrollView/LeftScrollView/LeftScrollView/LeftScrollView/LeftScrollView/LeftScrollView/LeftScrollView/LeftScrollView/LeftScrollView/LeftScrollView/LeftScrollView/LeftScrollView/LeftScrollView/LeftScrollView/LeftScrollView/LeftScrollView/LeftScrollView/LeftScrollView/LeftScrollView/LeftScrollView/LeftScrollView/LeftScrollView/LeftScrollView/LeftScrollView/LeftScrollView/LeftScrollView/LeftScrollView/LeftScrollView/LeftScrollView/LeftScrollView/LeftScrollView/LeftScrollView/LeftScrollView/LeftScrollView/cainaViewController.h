//
//  cainaViewController.h
//  RadioPlayReal
//
//  Created by shuainan on 15/9/18.
//  Copyright (c) 2015年 shuainan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
//#import "WXApi.h"
//#import "WXApiObject.h"

@interface cainaViewController : RootViewController<UITableViewDataSource,UITableViewDelegate>{
    
    UITableView *dataTableView; //tabelView的显示
}

@property (nonatomic, strong) NSMutableArray *dataSource;


@end
