//
//  CHTestViewController.m
//  ClassHookWebView
//
//  Created by Hirose Tatsuya on 2013/09/04.
//  Copyright (c) 2013年 Tatyusa. All rights reserved.
//

#import "CHTestViewController.h"

@implementation CHTestViewController

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

@end
