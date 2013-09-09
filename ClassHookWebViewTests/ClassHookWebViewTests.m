//
//  ClassHookWebViewTest.m
//  ClassHookWebViewTest
//
//  Created by Hirose Tatsuya on 2013/08/30.
//  Copyright (c) 2013年 Tatyusa. All rights reserved.
//

#import "ClassHookWebViewTests.h"
#import "ClassHookWebView.h"
#import "CHTestViewController.h"

@implementation ClassHookWebViewTests

#pragma mark ClassHookWebView Test

-(void)testOriginalDelegate
{
    ClassHookWebView *chWebView = [[ClassHookWebView alloc] init];
    CHTestViewController *viewController = [[CHTestViewController alloc] init];
    
    [chWebView setDelegate:viewController];

    STAssertEqualObjects(chWebView.originalDelegate, viewController, @"Delegate doesn't set correctly.");
}

-(void)testDelegateMethod
{
    ClassHookWebView *chWebView = [[ClassHookWebView alloc] init];
    CHTestViewController *viewController = [[CHTestViewController alloc] init];
    [chWebView setDelegate:viewController];
    
    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"test_index" ofType:@"html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
    
    [chWebView webView:chWebView shouldStartLoadWithRequest:request navigationType:UIWebViewNavigationTypeLinkClicked];
    STAssertTrue(viewController.stateWebViewShouldStartLoadWithRequest, @"Doesn't work webView:shouldStartLoadWithRequest:navigationType:");
    
    [chWebView webViewDidStartLoad:chWebView];
    STAssertTrue(viewController.stateWebViewDidStartLoad, @"Doesn't work webViewDidStartLoad:");
    
    [chWebView webViewDidFinishLoad:chWebView];
    STAssertTrue(viewController.stateWebViewDidFinishLoad, @"Doesn't work webViewDidFinishLoad:");
    
    [chWebView webView:chWebView didFailLoadWithError:nil];
    STAssertTrue(viewController.stateWebviewDidFailLoadWithError, @"Doesn't work webView:didFailLoadWithError:");
}


-(void)testAddTargetActionForClass
{
    ClassHookWebView *chWebView = [[ClassHookWebView alloc] init];
    CHTestViewController *viewController = [[CHTestViewController alloc] init];
    
    [chWebView addTarget:viewController action:@selector(method1:) forClass:@"app-method1"];
    [chWebView addTarget:viewController action:@selector(method2) forClass:@"app-method2"];
    [chWebView addTarget:viewController action:@selector(method3) forClass:@"app-method3"];
    
    /// Count Actions
    STAssertEquals((int)3, (int)[chWebView.actions count], @"Number of actions doesn't match");
    
    /// Check Action Name
    STAssertEqualObjects(@"method1:", [[chWebView.actions objectForKey:@"app-method1"] objectForKey:@"action"], @"Action Name does'nt match");
    STAssertEqualObjects(@"method2", [[chWebView.actions objectForKey:@"app-method2"] objectForKey:@"action"], @"Action Name does'nt match");
    STAssertEqualObjects(@"method3", [[chWebView.actions objectForKey:@"app-method3"] objectForKey:@"action"], @"Action Name does'nt match");
    
    /// Check Action Target
    STAssertEqualObjects(viewController, [[chWebView.actions objectForKey:@"app-method1"] objectForKey:@"target"], @"Action Name does'nt match");
    STAssertEqualObjects(viewController, [[chWebView.actions objectForKey:@"app-method2"] objectForKey:@"target"], @"Action Name does'nt match");
    STAssertEqualObjects(viewController, [[chWebView.actions objectForKey:@"app-method3"] objectForKey:@"target"], @"Action Name does'nt match");
}


-(void)testClassHookFunction
{
    ClassHookWebView *chWebView = [[ClassHookWebView alloc] init];
    CHTestViewController *viewController = [[CHTestViewController alloc] init];
    
    [chWebView setDelegate:viewController];
    
    [chWebView addTarget:viewController action:@selector(method1:) forClass:@"app-method1"];
    [chWebView addTarget:viewController action:@selector(method2) forClass:@"app-method2"];
    [chWebView addTarget:viewController action:@selector(method3) forClass:@"app-method3"];
    
    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"test_index" ofType:@"html"];
    [chWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
    do {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:.1]];
    } while (chWebView.loading);
    
    NSString *clickEvent = @"var e = document.createEvent(\"MouseEvents\");"
                            "e.initMouseEvent(\"click\", true, true, window, 0, 0, 0, 0, 0, false, false, false, false, 0, null);";
    
    [chWebView stringByEvaluatingJavaScriptFromString:clickEvent];
    
    [chWebView stringByEvaluatingJavaScriptFromString:@"document.getElementById('a1').dispatchEvent(e);"];
    do {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:.1]];
    } while (chWebView.loading);
    STAssertEqualObjects(@"http://google.co.jp", viewController.string, @"app-method1 can't hooked");
    
    [chWebView stringByEvaluatingJavaScriptFromString:@"document.getElementById('a2').dispatchEvent(e);"];
    do {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:.1]];
    } while (chWebView.loading);
    STAssertEqualObjects(@"method2", viewController.string, @"app-method2 can't hooked");
    
    [chWebView stringByEvaluatingJavaScriptFromString:@"document.getElementById('a3').dispatchEvent(e);"];
    do {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:.1]];
    } while (chWebView.loading);
    STAssertEqualObjects(@"method3", viewController.string, @"app-method3 can't hooked");
    
    [chWebView stringByEvaluatingJavaScriptFromString:@"document.getElementById('a4').dispatchEvent(e);"];
    do {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:.1]];
    } while (chWebView.loading);
    STAssertEqualObjects(@"hahaha", viewController.string, @"app-method1 can't hooked");
}

@end
