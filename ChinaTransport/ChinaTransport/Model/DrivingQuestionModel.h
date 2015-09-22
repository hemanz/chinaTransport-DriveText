//
//  DrivingQuestionModel.h
//  ChinaTransport
//
//  Created by herr on 15/9/19.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DrivingQuestionModel : NSObject

@property(nonatomic,copy) NSString * questionType;
@property(nonatomic,copy) NSString * questionContent;
@property(nonatomic,assign) BOOL questionHasImg;
@property(nonatomic,copy) NSString *questionImgPath;
@property(nonatomic,assign) BOOL questionHasVideo;
@property(nonatomic,copy) NSString *questionVideoPath;
@property(nonatomic,assign) CGFloat questionContentHeight;
@property(nonatomic,assign) CGSize questionImgSize;

@end
