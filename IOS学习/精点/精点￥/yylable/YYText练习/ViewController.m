//
//  ViewController.m
//  YYText练习
//
//  Created by Kingpoint on 16/1/13.
//  Copyright © 2016年 kingpoint. All rights reserved.
//

#import "ViewController.h"
#import "FluenceTableViewCell.h"
#import "YYText.h"
#import "YYImage.h"
#import "NSBundle+YYAdd.h"
#import "UIView+YYAdd.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"FluenceTableViewCell" bundle:nil]forCellReuseIdentifier:@"cell"];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * ID = @"cell";
    if (indexPath.section == 0) {
        FluenceTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
        NSString *str = [NSString stringWithFormat:@" Async Display Test ✺◟(∗❛ัᴗ❛ั∗)◞✺ ✺◟(∗❛ัᴗ❛ั∗)◞✺ 😀😖😐😣😡🚖🚌🚋🎊💖💗💛💙🏨🏦🏫 Async Display Test ✺◟(∗❛ัᴗ❛ั∗)◞✺ ✺◟(∗❛ัᴗ❛ั∗)◞✺ 😀😖😐😣😡🚖🚌🚋🎊💖💗💛💙🏨🏦🏫"];
        
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:str];
        //式排布更紧密
        text.yy_font = [UIFont systemFontOfSize:10];
        text.yy_lineSpacing = 0;
        text.yy_strokeWidth = @(-3);
        text.yy_strokeColor = [UIColor redColor];
        text.yy_lineHeightMultiple = 1;
        text.yy_maximumLineHeight = 12;
        text.yy_minimumLineHeight = 12;
        
        // it better to do layout in background queue...
        YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 44)];
        YYTextLayout *layout = [YYTextLayout layoutWithContainer:container text:text];
        
        //这句话不加好像也没有重用问题
        cell.yyText.attributedText = nil;
        
        cell.yyText.textLayout = layout;
        return cell;
 
    }else{
        
        FluenceTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        NSMutableAttributedString *text = [NSMutableAttributedString new];
        UIFont *font = [UIFont systemFontOfSize:16];
        
        {
            NSString *title = @"This is UIImage attachment:";
            [text appendAttributedString:[[NSAttributedString alloc] initWithString:title attributes:nil]];
            
            UIImage *image = [UIImage imageNamed:@"dribbble64_imageio"];
            image = [UIImage imageWithCGImage:image.CGImage scale:2 orientation:UIImageOrientationUp];
            
            NSMutableAttributedString *attachText = [NSMutableAttributedString yy_attachmentStringWithContent:image contentMode:UIViewContentModeCenter attachmentSize:image.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
            [text appendAttributedString:attachText];
            [text appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n" attributes:nil]];
        }
        
        {
            NSString *title = @"This is UIView attachment: ";
            [text appendAttributedString:[[NSAttributedString alloc] initWithString:title attributes:nil]];
            
            UISwitch *switcher = [UISwitch new];
            [switcher sizeToFit];
            NSMutableAttributedString * attachText = [NSMutableAttributedString yy_attachmentStringWithContent:switcher contentMode:UIViewContentModeCenter attachmentSize:switcher.bounds.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
            [text appendAttributedString:attachText];
            [text appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n" attributes:nil]];
        }
        
        {
            NSString *title = @"This is Animated Image attachment:";
            [text appendAttributedString:[[NSAttributedString alloc] initWithString:title attributes:nil]];
            
            NSArray *names = @[@"001", @"022", @"019",@"056",@"085"];
            for (NSString *name in names) {
                NSString *path = [[NSBundle mainBundle] pathForScaledResource:name ofType:@"gif" inDirectory:@"EmoticonQQ.bundle"];
                NSData *data = [NSData dataWithContentsOfFile:path];
                YYImage *image = [YYImage imageWithData:data scale:2];
                image.preloadAllAnimatedImageFrames = YES;
                YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:image];
                
                NSMutableAttributedString *attachText = [NSMutableAttributedString yy_attachmentStringWithContent:imageView contentMode:UIViewContentModeCenter attachmentSize:imageView.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
                [text appendAttributedString:attachText];
            }
            
            YYImage *image = [YYImage imageNamed:@"pia"];
            image.preloadAllAnimatedImageFrames = YES;
            YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:image];
            imageView.autoPlayAnimatedImage = NO;
            [imageView startAnimating];
            
            NSMutableAttributedString *attachText = [NSMutableAttributedString yy_attachmentStringWithContent:imageView contentMode:UIViewContentModeCenter attachmentSize:imageView.bounds.size alignToFont:font alignment:YYTextVerticalAlignmentBottom];
            [text appendAttributedString:attachText];
            
            [text appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n" attributes:nil]];
        }
  
        text.yy_font = font;
        cell.yyText.userInteractionEnabled = YES;
        cell.yyText.numberOfLines = 0;
        cell.yyText.size = CGSizeMake(260, 210);
        cell.yyText.center = CGPointMake(self.view.width / 2, self.view.height / 2);
        
        //这句话不加好像也没有重用问题
        cell.textLayout = nil;
        
        cell.yyText.attributedText = text;
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return 210;
    }
    return 44;
}
@end
