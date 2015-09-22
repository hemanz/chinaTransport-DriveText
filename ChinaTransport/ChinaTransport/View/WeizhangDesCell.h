//
//  WeizhangDesCell.h
//  ChinaTransport
//
//  Created by WangPandeng on 15/9/19.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeizhangDesModel.h"

@interface WeizhangDesCell : UITableViewCell
{
     UIImageView *bgImgView;
     UILabel *timeLabel;
     UILabel *jifenLabel;
     UILabel *jifenNumLabel;
     UILabel *fakuanLabel;
     UILabel *fakuanNumLabel;
     UILabel *jiaoKuanStatus;
     UILabel *cjjgLabel;
     UILabel *cjjgDesLabel;
     UILabel *wfdzLabel;
     UILabel *wfdzDesLabel;
     UILabel *wfxwLabel;
     UILabel *wfxwDesLabel;
    
}

@property (nonatomic,retain)WeizhangDesModel *weizhangDesModel;
@end
