//
//  DrivingModel.h
//  ChinaTransport
//
//  Created by herr on 15/9/18.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DrivingAnswerModel.h"
typedef NS_ENUM(NSInteger, DrivingTestType){
    /**
     *  顺序练习
     */
    DrivingTestTypeOrder= 0,
    /**
     *  随机练习
     */
    DrivingTestTypeRandom = 1,
    /**
     *  模拟练习
     */
    DrivingTestTypeExam = 2,
};

typedef NS_ENUM(NSInteger, DrivingExamType){
    /**
     *  科目一
     */
    DrivingExamTypeFirst= 0,
    /**
     *  科目四
     */
    DrivingExamTypeForth = 1,
};

typedef NS_ENUM(NSInteger, DrivingCarType){
    /**
     *  小车
     */
    DrivingCarTypeCar= 0,
    /**
     *  客车
     */
    DrivingCarTypeBus = 1,
    /**
     *  货车
     */
    DrivingCarTypeCargo = 2,
};


@interface DrivingModel : NSObject


@property(nonatomic,assign) DrivingTestType testType;
@property(nonatomic,assign) DrivingExamType examType;
@property(nonatomic,assign) DrivingCarType carType;
@property(nonatomic,assign) NSInteger drivingID;
@property(nonatomic,assign) NSInteger questionType;
@property(nonatomic,copy) NSString * intNumber;
@property(nonatomic,copy) NSString * strType;
@property(nonatomic,copy) NSString * strType_l;
@property(nonatomic,copy) NSString * question;
@property(nonatomic,copy) NSString * an1;
@property(nonatomic,copy) NSString * an2;
@property(nonatomic,copy) NSString * an3;
@property(nonatomic,copy) NSString * an4;
@property(nonatomic,copy) NSString * answerTrue;
@property(nonatomic,copy) NSString * answerChoose;
@property(nonatomic,copy) NSString * explains;
@property(nonatomic,assign) NSInteger chapterid;
@property(nonatomic,copy) NSString * imgPath;
@property(nonatomic,copy) NSString * videoPath;
@property(nonatomic,assign) NSInteger diffDegree;
@property(nonatomic,retain) NSMutableArray *drivingAnswerModelMArray;
@property(nonatomic,assign) NSInteger arrayIndex;

@end
