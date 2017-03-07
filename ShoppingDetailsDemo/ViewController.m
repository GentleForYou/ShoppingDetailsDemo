//
//  ViewController.m
//  ShoppingDetailsDemo
//
//  Created by edz on 2017/3/7.
//  Copyright © 2017年 chushenruhua. All rights reserved.
//

#import "ViewController.h"
#import "MJDIYHeader.h"
#import "MJDIYAutoFooter.h"
#import "MJDIYHeader.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScaleSize [UIScreen mainScreen].bounds.size.width/414

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _insideViewHeight.constant = (ScreenHeight-64)*2;
    _tableViewHeight.constant = ScreenHeight-64;
    _parameterTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _parameterTableView.tableFooterView = [UITableView new];
    
    _headerView.frame = CGRectMake(0, 0, ScreenWidth, 200*ScaleSize);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [UITableView new];
    _tableView.tableHeaderView = _headerView;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    [_webView1 loadRequest:request];
    NSURLRequest *request1 = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    [_webView2 loadRequest:request1];

    MJDIYAutoFooter *footer = [MJDIYAutoFooter footerWithRefreshingBlock:^{
        [UIView animateWithDuration:0.25 animations:^{
            _scrollView.contentOffset = CGPointMake(0, ScreenHeight-64);
        }];
        [_tableView.mj_footer endRefreshing];
    }];
    self.tableView.mj_footer = footer;
    
    MJDIYHeader *header = [MJDIYHeader headerWithRefreshingBlock:^{
        [UIView animateWithDuration:0.25 animations:^{
            _scrollView.contentOffset = CGPointMake(0, 0);
        }];
    
        [_parameterTableView.mj_header endRefreshing];
    }];
    _parameterTableView.mj_header = header;
    
    MJDIYHeader *header1 = [MJDIYHeader headerWithRefreshingBlock:^{
        [UIView animateWithDuration:0.25 animations:^{
            _scrollView.contentOffset = CGPointMake(0, 0);
        }];
        
        [_webView1.scrollView.mj_header endRefreshing];
    }];
    _webView1.scrollView.mj_header = header1;
    
    MJDIYHeader *header2 = [MJDIYHeader headerWithRefreshingBlock:^{
        [UIView animateWithDuration:0.25 animations:^{
            _scrollView.contentOffset = CGPointMake(0, 0);
        }];
        
        [_webView2.scrollView.mj_header endRefreshing];
    }];
    _webView2.scrollView.mj_header = header2;
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _parameterTableView) {
        return  10;
    }
    return 15;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行",indexPath.row];
    return cell;
}


//商品参数
- (IBAction)goodsParameterButton:(id)sender {
    
    [_goodsParameterButton setTitleColor:UIColorFromRGB(0xff4b4b) forState:UIControlStateNormal];
    [_afterSalesButton setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    [_FAQButton setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    
    _parameterTableView.hidden = NO;
    _webView1.hidden = YES;
    _webView2.hidden = YES;
    
}
//售后服务
- (IBAction)afterSalesButton:(id)sender {
    
    [_goodsParameterButton setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    [_afterSalesButton setTitleColor:UIColorFromRGB(0xff4b4b) forState:UIControlStateNormal];
    [_FAQButton setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    
    _parameterTableView.hidden = YES;
    _webView1.hidden = NO;
    _webView2.hidden = YES;
    
}
//常见问题
- (IBAction)FAQButton:(id)sender {
    
    [_goodsParameterButton setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    [_afterSalesButton setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    [_FAQButton setTitleColor:UIColorFromRGB(0xff4b4b) forState:UIControlStateNormal];
    
    _parameterTableView.hidden = YES;
    _webView1.hidden = YES;
    _webView2.hidden = NO;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
