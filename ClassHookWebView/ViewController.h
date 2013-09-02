//
//  ViewController.h
//  ClassHookWebView
//
//  Created by Hirose Tatsuya on 2013/08/30.
//  Copyright (c) 2013年 Tatyusa. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ClassHookWebView;

@interface ViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic,retain) ClassHookWebView *chWebView;

@end
