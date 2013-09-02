//
//  ClassHookWebView.h
//  ClassHookWebView
//
//  Created by Hirose Tatsuya on 2013/08/30.
//  Copyright (c) 2013年 Tatyusa. All rights reserved.
//
//  This class is inspired by http://d.hatena.ne.jp/ntaku/20111103/1320288456
//

#import <UIKit/UIKit.h>

@interface ClassHookWebView : UIWebView <UIWebViewDelegate>

@property (nonatomic,weak) id<UIWebViewDelegate> originalDelegate;
@property (nonatomic,retain) NSMutableDictionary *actions;

-(void)addTarget:(id)target action:(SEL)action forClass:(NSString *)className;

@end
