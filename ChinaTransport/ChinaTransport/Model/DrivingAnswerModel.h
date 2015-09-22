//
//  DrivingAnswerModel.h
//  ChinaTransport
//
//  Created by herr on 15/9/18.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, DrivingAnswerType){
    /**
     *  未作答
     */
    DrivingAnswerTypeNotChoose= 0,
    /**
     *  显示正确
     */
    DrivingAnswerTypeCorrect= 1,
    /**
     *  显示错误
     */
    DrivingAnswerTypeNotCorrect = 2,
};

@interface DrivingAnswerModel : NSObject

@property(nonatomic,copy) NSString * answerOrder;
@property(nonatomic,copy) NSString * answerContent;
@property(nonatomic,assign) DrivingAnswerType answerChooseType;


@end