//
//  DBManager.h
//  ChinaTransport
//
//  Created by WangPandeng on 15/9/10.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "DrivingModel.h"

@interface DBManager : NSObject
{
    FMDatabase*fm;
    
}
+(id)shareRecordingDBManager;
//插入数据
//- (void)add_dic:(NSDictionary*)dic;
//////删除dic
//- (void)delete_dic :(NSDictionary*)dic;
//读取kuaidi数据
- (NSMutableArray*)loadkuaidiData;
//读取huoche数据
- (NSMutableArray*)loadtrainData;
//读取region数据
- (NSMutableArray*)loadregionData;
//读取weizhangCity数据
- (NSMutableArray*)loadweizhangCityData;

//根据考试类型，读取驾考数据
-(NSMutableArray *)loadDrivingData:(DrivingModel *)drivingModelType;

//修改驾考选择后存储作答数据
-(BOOL)updateDrivingChooseAnswer:(DrivingModel *)drivingModelType;
//重置驾考用户作答数据
-(BOOL)resetDrivingChooseAnswer;
//判断驾考用户是否有作答数据
-(NSInteger)queryDrivingChooseAnswerCount;

@end
