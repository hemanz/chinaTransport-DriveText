//
//  kuaidiCell.h
//  ChinaTransport
//
//  Created by WangPandeng on 15/9/11.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface kuaidiCell : UITableViewCell
{
    UIImageView *logoImageView;
    UILabel *nameLable;
}
-(void)config:(NSString *)logoImage andName:(NSString *)titleString;
@end
