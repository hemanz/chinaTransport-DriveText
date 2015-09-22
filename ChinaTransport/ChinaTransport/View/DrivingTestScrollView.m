//
//  DrivingTestScrollView.m
//  ChinaTransport
//
//  Created by herr on 15/9/18.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "DrivingTestScrollView.h"
#import "DrivingAnswerTableViewCell.h"
#import "DrivingModel.h"
#import "DrivingAnswerModel.h"
#import "DBManager.h"
#import "DrivingQuestionModel.h"

#define SIZE self.frame.size
@interface DrivingTestScrollView()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>{
    
}
@end

@implementation DrivingTestScrollView{
    UIScrollView *_scrollView;
    UITableView *_leftTableView;
    UITableView *_centerTableView;
    UITableView *_rightTableView;
    NSMutableArray *_dataArray;
}

-(instancetype)initWithFrame:(CGRect)frame withDrivingDataArray:(NSArray *)array{
    self = [super initWithFrame:frame];
    if (self) {
        _currentPage = 0;
        _dataArray = [NSMutableArray arrayWithArray:array];
        _scrollView = [[UIScrollView alloc]initWithFrame:frame];
        _scrollView.delegate = self;
        _leftTableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
        _centerTableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
        _rightTableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
        
        _leftTableView.delegate = self;
        _centerTableView.delegate = self;
        _rightTableView.delegate = self;
        
        _leftTableView.dataSource = self;
        _centerTableView.dataSource = self;
        _rightTableView.dataSource = self;
        
        
        _leftTableView.scrollEnabled = YES;
        _centerTableView.scrollEnabled = YES;
        _rightTableView.scrollEnabled = YES;
        
        
        //设置分页
        _scrollView.pagingEnabled = YES;
        //默认为YES，用来设置scrollView的弹簧效果
        _scrollView.bounces = NO;
        if (_dataArray.count>1) {    //超过一题需要滑动
            _scrollView.contentSize = CGSizeMake(SIZE.width*2, 0);
        }
        [self createView];
        
    }
    return self;
    
}

- (void)createView{
    _leftTableView.frame = CGRectMake(0, 0, SIZE.width, SIZE.height);
    _centerTableView.frame = CGRectMake(SIZE.width, 0, SIZE.width, SIZE.height);
    _rightTableView.frame = CGRectMake(SIZE.width*2, 0, SIZE.width, SIZE.height);
    _leftTableView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgColor"]];
    _centerTableView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgColor"]];
    _rightTableView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgColor"]];
    _leftTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _centerTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _rightTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [_scrollView addSubview:_leftTableView];
    [_scrollView addSubview:_centerTableView];
    [_scrollView addSubview:_rightTableView];
    [self addSubview:_scrollView];
}

#pragma mark 实现table的代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    DrivingModel *model = [self getAnswerModel:tableView];
    if (model.questionType==1) {
        return 2;
    }
    return 4;
}
/**
 *
 *  自动头部高度
 *
 *  @param tableView
 *  @param section
 *
 *  @return
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    DrivingQuestionModel * drivingQuestionModel=[self getHeaderModelInSection:tableView];
    return drivingQuestionModel.questionContentHeight+drivingQuestionModel.questionImgSize.height+20;
}
/**
 *
 *  头部 题目问题
 *
 *  @param tableView
 *  @param section
 *
 *  @return
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    DrivingQuestionModel * drivingQuestionModel=[self getHeaderModelInSection:tableView];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE.width, drivingQuestionModel.questionContentHeight+drivingQuestionModel.questionImgSize.height+20)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, tableView.frame.size.width-20, drivingQuestionModel.questionContentHeight)];
    label.text = [NSString stringWithFormat:@"%d、%@",[self getPageInt:tableView andCurrentPage:_currentPage],drivingQuestionModel.questionContent];
    label.font = [UIFont systemFontOfSize:16];
    label.numberOfLines = 0;
    [view addSubview:label];
    
    if (drivingQuestionModel.questionHasImg) {
        UIImageView *questionImageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:drivingQuestionModel.questionImgPath]];
        [view addSubview:questionImageView];
        [questionImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(drivingQuestionModel.questionImgSize);
            make.centerX.equalTo(label);
            make.top.equalTo(label.mas_bottom).with.offset(10);
        }];
    }
    if ((tableView==_leftTableView && _currentPage==0) ||(tableView==_centerTableView && _currentPage!=0)) {
    
        if(drivingQuestionModel.questionHasVideo){
            if (self.player) {
                [self.player stop];
            }
            NSString *path = [[NSBundle mainBundle] pathForResource:[drivingQuestionModel.questionVideoPath substringToIndex:6] ofType:@"mp4"];
            //视频URL
            NSURL *url = [NSURL fileURLWithPath:path];
            //视频播放对象
            
            self.player = [[MPMoviePlayerController alloc] initWithContentURL:url];
            self.player.controlStyle = MPMovieControlStyleNone;
            self.player.repeatMode=MPMovieRepeatModeOne;
            self.player.initialPlaybackTime = -1;
            
            [view addSubview:self.player.view];
            [self.player.view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(drivingQuestionModel.questionImgSize);
                make.centerX.equalTo(label);
                make.top.equalTo(label.mas_bottom).with.offset(10);
            }];
            
            [self.player play];
        }
        
    }

    return view;
}

/**
 *
 *  底部高度
 *
 *  @param tableView
 *  @param section
 *
 *  @return
 */
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    DrivingModel *model = [self getAnswerModel:tableView];
    UIFont *font = [UIFont systemFontOfSize:(CGFloat)14];
    CGFloat height = [self getSizeWithString:model.explains withFont:font withSize:CGSizeMake(tableView.frame.size.width-20, 0)].height+60;
    
    return height;
}

/**
 *
 *  底部view
 *
 *  @param tableView
 *  @param section
 *
 *  @return
 */

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    DrivingModel *model = [self getAnswerModel:tableView];
    UIFont *font = [UIFont systemFontOfSize:(CGFloat)14];
    CGFloat height = [self getSizeWithString:model.explains withFont:font withSize:CGSizeMake(tableView.frame.size.width-20, 0)].height+60;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE.width, height)];
    if (![@"" isEqualToString: model.answerChoose]) {
        
        UIImageView *explainImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"最佳解释"]];
        explainImageView.frame=CGRectMake(20, 10, 21, 24);
        UILabel *explainLabel=[[UILabel alloc]initWithFrame:CGRectMake(50, 10, 100, 24)];
        explainLabel.text=@"最佳解释";
        explainLabel.textColor=RGBCOLOR(15, 141, 156);
        explainLabel.font=[UIFont boldSystemFontOfSize:14];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, tableView.frame.size.width-20, height-20)];
        label.text =[model.explains stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"] ;
        label.font = [UIFont systemFontOfSize:16];
        label.numberOfLines = 0;
        view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgColor"]];
        [view addSubview:label];
        [view addSubview:explainImageView];
        [view addSubview:explainLabel];
    }
    return view;
}

/**
 *
 *  table 的cell
 *
 *  @param tableView
 *  @param indexPath
 *
 *  @return
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier=@"AnswerTableViewCell";
    DrivingAnswerTableViewCell *cell;
    cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil){
        cell = [[DrivingAnswerTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        
        cell.backgroundColor=[UIColor clearColor];
    }
    DrivingModel *model = [self getAnswerModel:tableView];
    DrivingAnswerModel *drivingAnswerModel=[model.drivingAnswerModelMArray objectAtIndex:indexPath.row];
    
    if (![@"" isEqualToString:model.answerChoose]) {
        //选对的情况下
        if (model.answerChoose==model.answerTrue) {
            if ([model.answerChoose integerValue]==indexPath.row+1) {
                drivingAnswerModel.answerChooseType=DrivingAnswerTypeCorrect;
            }
        //选错的情况下
        }else{
            if ([model.answerChoose integerValue]==indexPath.row+1) {
                drivingAnswerModel.answerChooseType=DrivingAnswerTypeNotCorrect;
            }
            if ([model.answerTrue integerValue]==indexPath.row+1) {
                drivingAnswerModel.answerChooseType=DrivingAnswerTypeCorrect;
            }
        }
    }
    
    cell.drivingAnswerModel=drivingAnswerModel;
    return cell;
}

/**
 *
 *  滚动结束,不停的往后添加tableView
 *
 *  @param scrollView
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    //判断，是为了防止tableview上下滑动触发该事件
    if (scrollView.contentOffset.x >0){
    
        CGPoint currentOffset = scrollView.contentOffset;
        int page = (int)currentOffset.x/SIZE.width;//滑动到了第几页
        if (page<_dataArray.count - 1&&page>0) {
            _scrollView.contentSize = CGSizeMake(currentOffset.x+SIZE.width*2, 0);
            _centerTableView.frame = CGRectMake(currentOffset.x, 0, SIZE.width, SIZE.height);
            _leftTableView.frame = CGRectMake(currentOffset.x - SIZE.width, 0, SIZE.width, SIZE.height);
            _rightTableView.frame = CGRectMake(currentOffset.x + SIZE.width, 0, SIZE.width, SIZE.height);
        }
        _currentPage = page;
        [self reloadData];   //重新加载数据
    }
}

/**
 *
 *  刷新tableview
 */
-(void)reloadData{
    [_leftTableView reloadData];
    [_centerTableView reloadData];
    [_rightTableView reloadData];
}


/**
 *
 *  获取合适的model，当前页为centerTableView，左右两侧加减1，currentPage，根据scrollview偏移值计算
 *
 *  @param tableView
 *
 *  @return
 */
- (DrivingModel *)getAnswerModel:(UITableView*) tableView{
    DrivingModel *model= [[DrivingModel alloc]init];
    if (tableView==_leftTableView&&_currentPage==0) { //第一页
        model = _dataArray[_currentPage];
        model.arrayIndex=_currentPage;
    }else if(tableView==_leftTableView&&_currentPage>0){
        model = _dataArray[_currentPage-1];
        model.arrayIndex=_currentPage-1;
    }else if (tableView==_centerTableView&&_currentPage==0) {
        model = _dataArray[_currentPage+1];
        model.arrayIndex=_currentPage+1;
    }else if(tableView==_centerTableView&&_currentPage>0&&_currentPage<_dataArray.count-1){
        model = _dataArray[_currentPage];
        model.arrayIndex=_currentPage;
    }else if (tableView==_centerTableView&&_currentPage==_dataArray.count-1) {
        model = _dataArray[_currentPage-1];
        model.arrayIndex=_currentPage-1;
    }else if(tableView==_rightTableView&&_currentPage==_dataArray.count-1){
        model = _dataArray[_currentPage];
        model.arrayIndex=_currentPage;
    }else if(tableView==_rightTableView&&_currentPage<_dataArray.count-1){
        model = _dataArray[_currentPage+1];
        model.arrayIndex=_currentPage+1;
    }
    model.drivingAnswerModelMArray=[self getAnswerArray:model];
    return model;
    
}

-(NSMutableArray *)getAnswerArray:(DrivingModel *)drivingModel{
    NSMutableArray *array=[[NSMutableArray alloc]initWithCapacity:0];
    if (drivingModel.questionType==1) {
        DrivingAnswerModel *drivingAnswerModelA=[[DrivingAnswerModel alloc]init];
        drivingAnswerModelA.answerOrder=@"A";
        drivingAnswerModelA.answerContent=@"正确";
        [array addObject:drivingAnswerModelA];
        DrivingAnswerModel *drivingAnswerModelB=[[DrivingAnswerModel alloc]init];
        drivingAnswerModelB.answerOrder=@"B";
        drivingAnswerModelB.answerContent=@"错误";
        [array addObject:drivingAnswerModelB];
    }else{
        DrivingAnswerModel *drivingAnswerModelA=[[DrivingAnswerModel alloc]init];
        drivingAnswerModelA.answerOrder=@"A";
        drivingAnswerModelA.answerContent=drivingModel.an1;
        [array addObject:drivingAnswerModelA];
        DrivingAnswerModel *drivingAnswerModelB=[[DrivingAnswerModel alloc]init];
        drivingAnswerModelB.answerOrder=@"B";
        drivingAnswerModelB.answerContent=drivingModel.an2;
        [array addObject:drivingAnswerModelB];
        DrivingAnswerModel *drivingAnswerModelC=[[DrivingAnswerModel alloc]init];
        drivingAnswerModelC.answerOrder=@"C";
        drivingAnswerModelC.answerContent=drivingModel.an3;
        [array addObject:drivingAnswerModelC];
        DrivingAnswerModel *drivingAnswerModelD=[[DrivingAnswerModel alloc]init];
        drivingAnswerModelD.answerOrder=@"D";
        drivingAnswerModelD.answerContent=drivingModel.an4;
        [array addObject:drivingAnswerModelD];
    }
    return array;
}


- (int)getPageInt:(UITableView *)tableView andCurrentPage:(int)page{
    if (tableView==_leftTableView&&page==0) { //第一页
        return 1;
    }else if(tableView==_leftTableView&&page>0){
        return page;
        
    }else if (tableView==_centerTableView&&page==0) {
        return 2;
        
    }else if(tableView==_centerTableView&&page>0&&page<_dataArray.count-1){
        return page+1;
        
    }else if (tableView==_centerTableView&&page==_dataArray.count-1) {
        return page;
    }else if(tableView==_rightTableView&&page==_dataArray.count-1){
        return page+2;
        
    }else if(tableView==_rightTableView&&page<_dataArray.count-1){
        return page+1;
    }
    
    return 0;
    
}

/**
 *
 *  根据 text 获取label的高度
 *
 *  @param tableView
 *
 *  @return
 */
-(DrivingQuestionModel *)getHeaderModelInSection:(UITableView*)tableView{
    DrivingModel *model = [self getAnswerModel:tableView];
    UIFont *font = [UIFont systemFontOfSize:(CGFloat)16];
    DrivingQuestionModel *drivingQuestionModel=[[DrivingQuestionModel alloc]init];
    drivingQuestionModel.questionContent = model.question;
    
    CGFloat height = [self getSizeWithString:drivingQuestionModel.questionContent withFont:font withSize:CGSizeMake(tableView.frame.size.width-20, 400)].height+20;
//    if (height<60) {
//        height = 60;
//    }
    drivingQuestionModel.questionContentHeight = height;
    
    if (model.imgPath) {
        drivingQuestionModel.questionHasImg=YES;
        drivingQuestionModel.questionImgPath=model.imgPath;
        
        UIImage *questionImg=[UIImage imageNamed:model.imgPath];
        //imageview的大小为图片的1/2
        drivingQuestionModel.questionImgSize=CGSizeMake(questionImg.size.width/2, questionImg.size.height/2);
    }
    if (model.videoPath) {
        drivingQuestionModel.questionHasVideo=YES;
        drivingQuestionModel.questionVideoPath=model.videoPath;
        drivingQuestionModel.questionImgSize=CGSizeMake(250,110);
    }
    
    return drivingQuestionModel;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DrivingModel *drivingModel = [self getAnswerModel:tableView];
    if ([@"" isEqualToString:drivingModel.answerChoose]) {
        drivingModel.answerChoose=[NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
        [_dataArray replaceObjectAtIndex:drivingModel.arrayIndex withObject:drivingModel];
        [self updateExamData:drivingModel];
        [tableView reloadData];
    }else{
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }

}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    DrivingModel *drivingModel = [self getAnswerModel:tableView];
//    
//    DrivingAnswerModel *drivingAnswerModel=[drivingModel.drivingAnswerModelMArray objectAtIndex:indexPath.row];
//    
//    UIFont *font = [UIFont systemFontOfSize:(CGFloat)14];
//    
//    CGFloat height = [self getSizeWithString:drivingAnswerModel.answerContent withFont:font withSize:CGSizeMake(250,0)].height;
//    
//    return 60;
//}

-(BOOL)updateExamData:(DrivingModel *)drivingModel{
    DBManager *dbmanager =[DBManager shareRecordingDBManager];
    return [dbmanager updateDrivingChooseAnswer:drivingModel];
}

/**
 *
 *  //根据要显示的text计算label高度
 *
 *  @param str
 *  @param font
 *  @param size
 *
 *  @return
 */
- (CGSize)getSizeWithString:(NSString *)str withFont:(UIFont *)font withSize:(CGSize)size{
    CGSize newsize ;
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)//IOS 7.0 以上
//    {
        NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
        newsize =[str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
//    }
//    else
//    {
//        //ios7以上已经摒弃的这个方法
//        newsize = [str sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
//    }
    return newsize;
}

@end
