//
//  EmotionView.m
//  表情包的封装
//
//  Created by yh on 16/3/23.
//  Copyright © 2016年 yh. All rights reserved.
//

#import "EmotionView.h"
#import "EmotionCollectionViewCell.h"
#import "LDEmotionModel.h"
#import "MJExtension.h"
#import "LDEmotionPageView.h"

#define LDPath(resource) [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"EmotionIcons/%@/info.plist",resource] ofType:nil]

#define LDEmotionPath(name) [[NSBundle bundleWithPath:[[NSBundle mainBundle]pathForResource:name ofType:@"bundle"]]pathForResource:@"info" ofType:@"plist"]

#define YHCurrentEmotionPage [[[NSUserDefaults standardUserDefaults] objectForKey:@"currentEmotionPage"] integerValue]
// RGB颜色

#define YHColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
//纯色
#define YHColorZ(z) YHColor(z, z, z)
// 随机色
#define YHRandomColor YHColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

static int pageOfEmoji = 4;
static int pageOfQQ = 7;

@interface EmotionView()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>
{
    NSInteger _pageNumber;
}
/**默认表情的模型数组*/
@property(nonatomic, strong) NSArray  * defaultEmotions;
/**Emoji的模型数组*/
@property(nonatomic, strong) NSArray  * emojiEmotions;
/**浪小花表情的模型数组*/
@property(nonatomic, strong) NSArray  * lxhEmotions;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property (weak, nonatomic) IBOutlet UIButton *QQEmotionBtn;
@property (weak, nonatomic) IBOutlet UIButton *emojiEmotionBtn;
@property (weak, nonatomic) IBOutlet UIButton *SendBtn;
@end

@implementation EmotionView

#pragma mark - 懒加载控件
//懒加载emoji
-(NSArray *)emojiEmotions{
    if (_emojiEmotions == nil) {
        
       _emojiEmotions = [LDEmotionModel objectArrayWithFile:LDEmotionPath(@"emoji")];
        
    }
    
    return _emojiEmotions;
}
//懒加载defaultEmotions
-(NSArray *)defaultEmotions{
    if (_defaultEmotions == nil) {
        
        _defaultEmotions =[LDEmotionModel objectArrayWithFile: LDEmotionPath(@"EmoticonQQ")];
        
    }
    
    return _defaultEmotions;
}
//懒加载lxhEmotions
-(NSArray *)lxhEmotions{
    if (_lxhEmotions == nil) {
        
        _lxhEmotions =[LDEmotionModel objectArrayWithFile: LDEmotionPath(@"lxh")];
        
    }
    
    return _lxhEmotions;
}

+(instancetype)emotionView
{
    return [[[NSBundle mainBundle]loadNibNamed:@"EmotionView" owner:self options:nil]lastObject];
}

-(void)awakeFromNib
{
    [self.collectionView registerNib:[UINib nibWithNibName:kEmotionCollectionView bundle:nil] forCellWithReuseIdentifier:kEmotionCollectionView];
    self.SendBtn.layer.cornerRadius = 5;
    self.SendBtn.clipsToBounds = YES;
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    //设置cell的尺寸,和布局,这里拿的比较准，左右间距各19  19*2=38  上间距20 下间距70
    self.layout.itemSize = CGSizeMake(frame.size.width, frame.size.height - 90);
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EmotionCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kEmotionCollectionView forIndexPath:indexPath];
    NSArray * array;
    switch (indexPath.section) {
        case 1:
            switch (indexPath.row) {
                case 0:
                {
                    NSRange range = NSMakeRange(0, 20);
                    array = [self.emojiEmotions subarrayWithRange:range];
                    break;
                }
                case 1:
                {
                    NSRange range = NSMakeRange(20, 20);
                    array = [self.emojiEmotions subarrayWithRange:range];
                    break;
                }
                case 2:
                {
                    NSRange range = NSMakeRange(40, 20);
                    array = [self.emojiEmotions subarrayWithRange:range];
                    break;
                }
                case 3:
                {
                    NSRange range = NSMakeRange(60, 20);
                    array = [self.emojiEmotions subarrayWithRange:range];
                    break;
                }
                default:
                    break;
            }
            break;
        case 0:
            switch (indexPath.row) {
                case 0:
                {
                    NSRange range = NSMakeRange(0, 20);
                    array = [self.defaultEmotions subarrayWithRange:range];
                    break;
                }
                case 1:
                {
                    NSRange range = NSMakeRange(20, 20);
                    array = [self.defaultEmotions subarrayWithRange:range];
                    break;
                }
                case 2:
                {
                    NSRange range = NSMakeRange(40, 20);
                    array = [self.defaultEmotions subarrayWithRange:range];
                    break;
                }
                case 3:
                {
                    NSRange range = NSMakeRange(60, 20);
                    array = [self.defaultEmotions subarrayWithRange:range];
                    break;
                }
                case 4:
                {
                    NSRange range = NSMakeRange(80, 20);
                    array = [self.defaultEmotions subarrayWithRange:range];
                    break;
                }
                case 5:
                {
                    NSRange range = NSMakeRange(100, 20);
                    array = [self.defaultEmotions subarrayWithRange:range];
                    break;
                }
                case 6:
                {
                    NSRange range = NSMakeRange(120, 20);
                    array = [self.defaultEmotions subarrayWithRange:range];
                    break;
                }
                    
            }
            break;
        default:
            break;
    }
    cell.emotionArr = array;
    
    //事件传递
    __weak typeof(self) weakSelf = self;
    cell.emotionPageView.deleteClick = ^(LDEmotionModel * model){
        if ([weakSelf.delegate respondsToSelector:@selector(emotionViewDidClickDelete)]) {
            [weakSelf.delegate emotionViewDidClickDelete];
        }
    };
    cell.emotionPageView.seletedEmotion = ^(LDEmotionModel * model){
        if ([weakSelf.delegate respondsToSelector:@selector(emotionViewDidClickEmotion:)]) {
            [weakSelf.delegate emotionViewDidClickEmotion:model];
        }
    };
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    if (0 == section) {
        self.pageControl.numberOfPages = pageOfQQ;
        return pageOfQQ;
    }else if (1 == section){
        return pageOfEmoji;
    }
    return 0;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _pageNumber = (scrollView.contentOffset.x + 1)/self.layout.itemSize.width;
    if (_pageNumber <= pageOfQQ - 1) {
        self.pageControl.numberOfPages = pageOfQQ;
        self.pageControl.currentPage = _pageNumber;
        self.QQEmotionBtn.selected = YES;
        self.emojiEmotionBtn.selected = NO;
    }else if (_pageNumber >= pageOfQQ && _pageNumber <= pageOfQQ + pageOfEmoji - 1){
        self.pageControl.numberOfPages = pageOfEmoji;
        self.pageControl.currentPage = _pageNumber - pageOfQQ;
        self.emojiEmotionBtn.selected = YES;
        self.QQEmotionBtn.selected = NO;
    }
}
- (IBAction)QQEmotion:(UIButton *)sender
{
    if (sender.selected) {
        return;
    }
    self.QQEmotionBtn.selected = YES;
    self.emojiEmotionBtn.selected = NO;
    [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionLeft];
}
- (IBAction)EmojiEmotion:(UIButton *)sender
{
    if (sender.selected) {
        return;
    }
    self.QQEmotionBtn.selected = NO;
    self.emojiEmotionBtn.selected = YES;
    [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] animated:NO scrollPosition:UICollectionViewScrollPositionLeft];
}
- (IBAction)SendEmotion:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(emotionViewDidClickSend)]) {
        [self.delegate emotionViewDidClickSend];
    }
}

@end
