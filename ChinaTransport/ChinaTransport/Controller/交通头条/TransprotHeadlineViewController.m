//
//  TransprotHeadlineControllerViewController.m
//  ChinaTransport
//
//  Created by 张鹤楠 on 15/9/6.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#import "TransprotHeadlineViewController.h"
#import "NewsTableViewController.h"
#import "SXTitleLable.h"
#import "PPRevealSideViewController.h"


#define TITLE_BUTTON_SPACE_BETWEEN wid/11

@interface TransprotHeadlineViewController () <UIScrollViewDelegate>
{
//    UIScrollView *TitleScrollView;
//    UIScrollView *bigScrollView;
    UIButton *titleButton;
    NSArray *titleArray;
}
/** 标题栏 */
@property (strong, nonatomic) UIScrollView *titleScrollView;

/** 下面的内容栏 */
@property (strong, nonatomic)  UIScrollView *bigScrollView;

/** 新闻接口的数组 */
@property(nonatomic,strong) NSArray *arrayLists;

@property(nonatomic,assign)BOOL update;


@end

@implementation TransprotHeadlineViewController

#pragma mark - ******************** 懒加载
- (NSArray *)arrayLists
{
    if (_arrayLists == nil) {
        _arrayLists = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"NewsURLs.plist" ofType:nil]];
//        NSLog(@"arrayLists:%@",_arrayLists);
    }
    return _arrayLists;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addTiTle:@"- 交 通 头 条 -"];
    [self creatScrollView];
    [self addController];
    [self addLable];
    
    // 添加默认控制器
    UIViewController *vc = [self.childViewControllers firstObject];
    vc.view.frame = self.bigScrollView.bounds;
    [self.bigScrollView addSubview:vc.view];
    SXTitleLable *lable = [self.titleScrollView.subviews firstObject];
    lable.scale = 1.0;
    
    CGFloat contentX = self.childViewControllers.count * [UIScreen mainScreen].bounds.size.width;
    _bigScrollView.contentSize = CGSizeMake(contentX, 0);
    _bigScrollView.pagingEnabled = YES;
    // Do any additional setup after loading the view.
}



- (void)addController
{
    for (int i=0 ; i<self.arrayLists.count ;i++){
        NewsTableViewController *vc1 = [[NewsTableViewController alloc] init];
        vc1.title = self.arrayLists[i][@"title"];
        vc1.urlString = self.arrayLists[i][@"urlString"];
        [self addChildViewController:vc1];
    }
}

- (void)addLable
{
    for (int i = 0; i < 6; i++) {
        CGFloat lblW = 70;
        CGFloat lblH = 40;
        CGFloat lblY = 0;
        CGFloat lblX = i * lblW;
        SXTitleLable *lbl1 = [[SXTitleLable alloc]init];
        UIViewController *vc = self.childViewControllers[i];
        lbl1.text =vc.title;
        lbl1.frame = CGRectMake(lblX, lblY, lblW, lblH);
        lbl1.font = [UIFont fontWithName:@"HYQiHei" size:19];
        [self.titleScrollView addSubview:lbl1];
        lbl1.tag = i;
        lbl1.userInteractionEnabled = YES;
        
        [lbl1 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lblClick:)]];
    }
    self.titleScrollView.contentSize = CGSizeMake(70 * 6, 0);
    
}


- (void)creatScrollView{
    _titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, wid, 35)];
    _titleScrollView.backgroundColor = [UIColor clearColor];
    _titleScrollView.userInteractionEnabled = YES;
    _titleScrollView.directionalLockEnabled = YES;
    _titleScrollView.showsHorizontalScrollIndicator = NO;
    _titleScrollView.showsVerticalScrollIndicator = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _bigScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 35, wid, heigh-64-35)];
    _bigScrollView.backgroundColor = [UIColor clearColor];
   
    _bigScrollView.delegate = self;
    UIViewController *vc = [self.childViewControllers firstObject];
    vc.view.frame = _bigScrollView.bounds;
    [_bigScrollView addSubview:vc.view];
    SXTitleLable *lable = [self.titleScrollView.subviews firstObject];
    lable.scale = 1.0;
    _bigScrollView.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:_bigScrollView];
    [self.view addSubview:_titleScrollView];

}

/** 标题栏label的点击事件 */
- (void)lblClick:(UITapGestureRecognizer *)recognizer
{
    SXTitleLable *titlelable = (SXTitleLable *)recognizer.view;
    
    CGFloat offsetX = titlelable.tag * _bigScrollView.frame.size.width;
    
    CGFloat offsetY = _bigScrollView.contentOffset.y;
    CGPoint offset = CGPointMake(offsetX, offsetY);
    
    [_bigScrollView setContentOffset:offset animated:YES];
    
    
}

#pragma mark - ******************** scrollView代理方法

/** 滚动结束后调用（代码导致） */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 获得索引
    NSUInteger index = scrollView.contentOffset.x / _bigScrollView.frame.size.width;
    
    // 滚动标题栏
    SXTitleLable *titleLable = (SXTitleLable *)self.titleScrollView.subviews[index];
    
    CGFloat offsetx = titleLable.center.x - self.titleScrollView.frame.size.width * 0.5;
    
    CGFloat offsetMax = self.titleScrollView.contentSize.width - self.titleScrollView.frame.size.width;
    if (offsetx < 0) {
        offsetx = 0;
    }else if (offsetx > offsetMax){
        offsetx = offsetMax;
    }
    
    CGPoint offset = CGPointMake(offsetx, self.titleScrollView.contentOffset.y);
    [self.titleScrollView setContentOffset:offset animated:YES];
    // 添加控制器
    NewsTableViewController *newsVc = self.childViewControllers[index];
    newsVc.index = index;
    
    [self.titleScrollView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx != index) {
            SXTitleLable *temlabel = self.titleScrollView.subviews[idx];
            temlabel.scale = 0.0;
        }
    }];
    
    if (newsVc.view.superview) return;
    
    newsVc.view.frame = scrollView.bounds;
    [_bigScrollView addSubview:newsVc.view];
}

/** 滚动结束（手势导致） */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

/** 正在滚动 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 取出绝对值 避免最左边往右拉时形变超过1
    CGFloat value = ABS(scrollView.contentOffset.x / scrollView.frame.size.width);
    NSUInteger leftIndex = (int)value;
    NSUInteger rightIndex = leftIndex + 1;
    CGFloat scaleRight = value - leftIndex;
    CGFloat scaleLeft = 1 - scaleRight;
    SXTitleLable *labelLeft = self.titleScrollView.subviews[leftIndex];
    labelLeft.scale = scaleLeft;
    // 考虑到最后一个板块，如果右边已经没有板块了 就不在下面赋值scale了
    if (rightIndex < self.titleScrollView.subviews.count) {
        SXTitleLable *labelRight = self.titleScrollView.subviews[rightIndex];
        labelRight.scale = scaleRight;
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
