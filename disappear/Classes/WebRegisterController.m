//
//  WebRegisterController.m
//  disappear
//
//  Created by CpyShine on 13-6-20.
//  Copyright (c) 2013年 CpyShine. All rights reserved.
//

#import "WebRegisterController.h"
#import "DeviveMD5/UIDevice+IdentifierAddition.h"

@interface WebRegisterController ()

@end

@implementation WebRegisterController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIWebView * webView = [[[UIWebView alloc]init]autorelease];
    [webView setBackgroundColor:[UIColor grayColor]];
    webView.scalesPageToFit = false;
    webView.delegate = self;
    self.view = nil;
    self.view = webView;
    
    NSString * urls = [[UIDevice currentDevice]uniqueGlobalDeviceIdentifier];
//    NSString * urls = @"sssss";
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"NULL",urls]];
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url];
    [req setTimeoutInterval:30.0];
    [webView loadRequest:req];
    
    
//    m_alertView  = [[UIAlertView alloc]initWithTitle:nil message:@"please wait!" delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
//    
//    
////    CGRect frame = CGRectMake(10, 14, 40, 40);
//    
//    UIActivityIndicatorView * progressInd = [[[UIActivityIndicatorView alloc] init] autorelease];
//    progressInd.center = m_alertView.center;
//    progressInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
//    [m_alertView addSubview:progressInd];
//    [progressInd startAnimating];
//    
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeRoundedRect]; //创建圆角矩形button
	[leftButton setFrame:CGRectMake(10, 430, 70, 35)]; //设置button的frame
	[leftButton setTitle:@"<< back" forState:UIControlStateNormal]; //设置button的标题
	[leftButton addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside]; //定义点击时的响应函数
	[self.view addSubview:leftButton]; //添加到view上
}

-(void) buttonPress:(id)sender{
    [self.navigationController popViewControllerAnimated:true];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
//    [m_alertView show];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
//    [m_alertView release];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
//    [m_alertView release];
    
    UIAlertView *alterview = [[UIAlertView alloc] initWithTitle:@"Error Message!"message:[error localizedDescription]  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alterview show];
    [alterview release];
//    [self.navigationController popViewControllerAnimated:true];
}
//
//-(void)willPresentAlertView:(UIAlertView *)alertView{
//    [alertView setBackgroundColor:[UIColor blackColor]];
//    [alertView setFrame:CGRectMake(0, 0, 100, 60)];
//    
//}

@end
