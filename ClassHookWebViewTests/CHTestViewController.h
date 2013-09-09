//
//  CHTestViewController.h
//  ClassHookWebView
//
//  Created by Hirose Tatsuya on 2013/09/04.
//  Copyright (c) 2013年 Tatyusa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHTestViewController : UIViewController
<UIWebViewDelegate>
@property (nonatomic) BOOL stateWebViewShouldStartLoadWithRequest;
@property (nonatomic) BOOL stateWebViewDidStartLoad;
@property (nonatomic) BOOL stateWebViewDidFinishLoad;
@property (nonatomic) BOOL stateWebviewDidFailLoadWithError;
@property (nonatomic,retain) NSString *string;

-(void)method1:(NSString *)href;
-(void)method2;
-(void)method3;
@end
