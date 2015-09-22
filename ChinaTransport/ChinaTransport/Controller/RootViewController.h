//
//  RootViewController.h
//  ChinaTransport
//
//  Created by 王攀登 on 15/9/1.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController

-(void)addTiTle:(NSString *)title;
-(void)addimage:(UIImage *)image title:(NSString *)title selector:(SEL)selector location:(BOOL)isLeft;
-(void)alertView:(NSString *)message cancle:(NSString *)cancleMessage;
-(NSString *)judgeArrayEmpty:(NSString *)str;
-(NSString *)judgeDicEmpty:(NSDictionary *)dic str:(NSString *)str;
- (BOOL) isBlankString:(NSString *)string;
@end
