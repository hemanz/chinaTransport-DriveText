//
//  NewsWebView.h
//  ChinaTransport
//
//  Created by 张鹤楠 on 15/9/15.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import "NJKWebViewProgress.h"


@interface NewsWebView : RootViewController <UIWebViewDelegate,NJKWebViewProgressDelegate>

@property (nonatomic, copy)NSString *url;
@end
