//
//  DBManager.m
//  ChinaTransport
//
//  Created by WangPandeng on 15/9/10.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "DBManager.h"
static DBManager*manager;
@implementation DBManager
+ (id)shareRecordingDBManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DBManager alloc]init];
    });
    return manager;
}
- (instancetype)init
{
    if (self = [super init])
    {
        NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        NSString *documentFolderPath = [searchPaths objectAtIndex: 0];
        //查看文件目录
        NSLog(@"%@",documentFolderPath);
        NSString*path =[documentFolderPath stringByAppendingPathComponent:@"chinatransport.db"];
        
        fm=[[FMDatabase alloc]initWithPath:path];
        if ([fm open]) {
            NSLog(@"成功打开数据库");
        }

    }
    return self;
}

//      kuaidi
-(NSMutableArray *)loadkuaidiData{
    FMResultSet *result=[fm executeQuery:@"select * from kuaidi"];
    NSMutableArray *dataArray=[NSMutableArray arrayWithCapacity:0];
    while ([result next]) {
        NSString *idxchar=[result stringForColumn:@"idxChar"];
        NSString *name=[result stringForColumn:@"name"];
        NSString *contact=[result stringForColumn:@"contact"];
        NSString *number = [result stringForColumn:@"number"];
        //  NSArray *temp=@[videoName,videoUniqueId,userUniqueID];
         NSString *topIdx = [result stringForColumn:@"topIdx"];
        NSDictionary*dic = @{@"idxChar":idxchar,@"name":name,@"contact":contact,@"number":number,@"topIdx":topIdx};
        [dataArray addObject:dic];
    }
    return dataArray;
}
-(NSMutableArray *)loadtrainData{
    FMResultSet *result=[fm executeQuery:@"select * from train_station"];
    NSMutableArray *dataArray=[NSMutableArray arrayWithCapacity:0];
    while ([result next]) {
        NSString *sta_name=[result stringForColumn:@"sta_name"];
        NSString *sta_code=[result stringForColumn:@"sta_code"];
        NSString *sta_code_first=[result stringForColumn:@"sta_code_first"];
        NSDictionary*dic = @{@"sta_name":sta_name,@"sta_code":sta_code,@"sta_code_first":sta_code_first};
        [dataArray addObject:dic];
    }
    return dataArray;
}
-(NSMutableArray *)loadregionData{
    FMResultSet *result=[fm executeQuery:@"select * from region"];
    NSMutableArray *dataArray=[NSMutableArray arrayWithCapacity:0];
    while ([result next]) {
        NSString *name=[result stringForColumn:@"name"];
        NSString *level=[result stringForColumn:@"level"];
        NSString *number=[result stringForColumn:@"number"];
        NSDictionary*dic = @{@"name":name,@"level":level,@"number":number};
        [dataArray addObject:dic];
    }
    return dataArray;

}
-(NSMutableArray *)loadweizhangCityData{
    FMResultSet *result=[fm executeQuery:@"select * from weizhangcity"];
    NSMutableArray *dataArray=[NSMutableArray arrayWithCapacity:0];
    while ([result next]) {
        NSString *name=[result stringForColumn:@"name"];
        NSString *level=[result stringForColumn:@"level"];
        NSString *number=[result stringForColumn:@"number"];
        NSDictionary*dic = @{@"name":name,@"level":level,@"number":number};
        [dataArray addObject:dic];
    }
    return dataArray;

}

-(NSMutableArray *)loadDrivingData:(DrivingModel *)drivingModelType{
    NSString * sql=@"select * from drivingexam where 1=1 ";
    switch (drivingModelType.carType) {
        case DrivingCarTypeCar:
            sql=[sql stringByAppendingString:@" and licenseType like '%C1C2%'"];
            break;
        case DrivingCarTypeBus:
            sql=[sql stringByAppendingString:@" and licenseType like '%A1%B1%'"];
            break;
        case DrivingCarTypeCargo:
            sql=[sql stringByAppendingString:@" and licenseType like '%A2%B2%'"];
            break;
            
        default:
            break;
    }
    switch (drivingModelType.examType) {
        case DrivingExamTypeFirst:
            sql=[sql stringByAppendingString:@" and kemu=1"];
            break;
        case DrivingExamTypeForth:
            sql=[sql stringByAppendingString:@" and kemu=4"];
            break;
        default:
            break;
    }
    switch (drivingModelType.testType) {
        case DrivingTestTypeOrder:
            sql=[sql stringByAppendingString:@" order by id"];
            break;
        case DrivingTestTypeRandom:
            sql=[sql stringByAppendingString:@" order by random()"];
            break;
        case DrivingTestTypeExam:
            sql=[sql stringByAppendingString:@" order by random() limit 100"];
            break;
        default:
            break;
    }
    
    //根据驾考类型，随机去取数
    FMResultSet *result=[fm executeQuery:sql];
    NSMutableArray *dataArray=[NSMutableArray arrayWithCapacity:0];
    while ([result next]) {
        
        DrivingModel *drivingModel=[[DrivingModel alloc]init];
        drivingModel.drivingID=[result intForColumn:@"id"];
        drivingModel.questionType=[result intForColumn:@"type"];
        drivingModel.intNumber=[result stringForColumn:@"intNumber"];
        drivingModel.strType=[result stringForColumn:@"strType"];
        drivingModel.strType_l=[result stringForColumn:@"strType_l"];
        drivingModel.question=[result stringForColumn:@"question"];
        drivingModel.an1=[result stringForColumn:@"an1"];
        drivingModel.an2=[result stringForColumn:@"an2"];
        drivingModel.an3=[result stringForColumn:@"an3"];
        drivingModel.an4=[result stringForColumn:@"an4"];
        drivingModel.answerTrue=[result stringForColumn:@"answerTrue"];
        drivingModel.explains=[result stringForColumn:@"explains"];
        drivingModel.chapterid=[result intForColumn:@"chapterid"];
        drivingModel.imgPath=[result stringForColumn:@"imgPath"];
        drivingModel.videoPath=[result stringForColumn:@"videoPath"];
        drivingModel.chapterid=[result intForColumn:@"diffDegree"];
        drivingModel.answerChoose=[result stringForColumn:@"answerChoose"];
        [dataArray addObject:drivingModel];
    }
    return dataArray;
    
}

-(BOOL)updateDrivingChooseAnswer:(DrivingModel *)drivingModelType{
    
    BOOL isSucceed=[fm executeUpdate:@"update drivingexam set answerChoose=? where id= ?",drivingModelType.answerChoose,[NSString stringWithFormat:@"%ld",(long)drivingModelType.drivingID]];
    return isSucceed;
}

-(BOOL)resetDrivingChooseAnswer{
    
    BOOL isSucceed=[fm executeUpdate:@"update drivingexam set answerChoose=''"];
    return isSucceed;
}

-(NSInteger)queryDrivingChooseAnswerCount{
    
    FMResultSet *result=[fm executeQuery:@"select count(*) from drivingexam where answerChoose<>''"];
    while ([result next]) {
        NSInteger i=[result intForColumnIndex:0];
        return i;
    }
    return 0;
}

@end
