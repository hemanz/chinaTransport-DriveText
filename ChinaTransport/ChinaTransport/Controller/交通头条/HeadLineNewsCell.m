//
//  HeadLineNewsCell.m
//  ChinaTransport
//
//  Created by 张鹤楠 on 15/9/10.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "HeadLineNewsCell.h"
#import "UIImageView+WebCache.h"

@interface HeadLineNewsCell()
//@property (weak, nonatomic) IBOutlet UILabel *title;
@end
@implementation HeadLineNewsCell

- (void)awakeFromNib {
    // Initialization code
}


+ (NSInteger)idForRow:(THeadLineNewsModel *)model{
    if ([model.litpic count]>1) {
        return 2;
    }else if ([model.litpic count]==1) {
        return 0;
    }else{
        return 1;
    }
}

+ (CGFloat)heighForRow:(THeadLineNewsModel *)model{
    if ([model.litpic count]>1) {
        return 100;
    }else if ([model.litpic count]==1) {
        return 70;
    }else{
        return 60;
    }
}

- (void)setNewsModel:(THeadLineNewsModel *)newsModel{
    _newsModel = newsModel;
    
    _title.text = newsModel.title;
    if (newsModel.litpic.count) {
        NSString *picUrl = newsModel.litpic[0];
        [_pic sd_setImageWithURL:[NSURL URLWithString:picUrl]placeholderImage:[UIImage imageNamed:@"definePicture2"]];

    }
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"] ];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* inputDate = [inputFormatter dateFromString:newsModel.time];
    NSString *time = [self compareCurrentTime:inputDate];
    NSString *souceAndTime = [NSString stringWithFormat:@"%@  %@",newsModel.source,time];
    self.souce.text = souceAndTime;
}

-(NSString *) compareCurrentTime:(NSDate*) compareDate
//
{
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
}

@end
