//
//  trainCell.h
//  ChinaTransport
//
//  Created by WangPandeng on 15/9/12.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface trainCell : UITableViewCell
{
    UILabel *titleLabel;
    UILabel *textLabel;
}
-(void)config:(NSString *)title andName:(NSString *)text;
@end
