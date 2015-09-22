//
//  DrivingTestScrollView.h
//  ChinaTransport
//
//  Created by herr on 15/9/18.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MediaPlayer/MediaPlayer.h>

@interface DrivingTestScrollView : UIView

-(instancetype)initWithFrame:(CGRect)frame withDrivingDataArray:(NSArray*)array;

@property (nonatomic,assign,readonly) int currentPage;


@property(nonatomic,strong) MPMoviePlayerController *player;

@end
