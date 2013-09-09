//
//  CHTestViewController.m
//  ClassHookWebView
//
//  Created by Hirose Tatsuya on 2013/09/04.
//  Copyright (c) 2013年 Tatyusa. All rights reserved.
//

#import "CHTestViewController.h"

@implementation CHTestViewController

-(id)init
{
    self = [super init];
    if(self){
        self.stateWebviewDidFailLoadWithError = NO;
        self.stateWebViewDidFinishLoad = NO;
        self.stateWebViewDidStartLoad = NO;
        self.stateWebViewShouldStartLoadWithRequest = NO;
    }
    return self;
}

-(void)method1:(NSString *)href
{
    self.string = href;
}

-(void)method2
{
    self.string = @"method2";
}

-(void)method3
{
    self.string = @"method3";
}

#pragma mark UIWebViewDelegate Methods

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    self.stateWebViewShouldStartLoadWithRequest = YES;
    return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    self.stateWebViewDidStartLoad = YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.stateWebViewDidFinishLoad = YES;
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    self.stateWebviewDidFailLoadWithError = YES;
}

@end