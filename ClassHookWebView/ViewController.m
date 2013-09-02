//
//  ViewController.m
//  ClassHookWebView
//
//  Created by Hirose Tatsuya on 2013/08/30.
//  Copyright (c) 2013年 Tatyusa. All rights reserved.
//

#import "ViewController.h"
#import "ClassHookWebView.h"

@implementation ViewController
@synthesize chWebView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    chWebView = [[ClassHookWebView alloc] initWithFrame:self.view.bounds];
    [chWebView setDelegate:self];
    [self.view addSubview:chWebView];
    
    [chWebView addTarget:self action:@selector(showAlert:) forClass:@"app-show-alert"];
    [chWebView addTarget:self action:@selector(startActivity) forClass:@"app-start-activity"];
    [chWebView addTarget:self action:@selector(stopActivity) forClass:@"app-stop-activity"];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    [chWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
}

-(void)showAlert:(NSString *)href
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ClassHook!!" message:href delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [chWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:href]]];
    [alert show];
}
-(void)startActivity
{
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:YES];
}

-(void)stopActivity
{
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:NO];
}

#pragma mark UIWebViewDelegate Methods

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"Finish load");
}

@end
