//
//  ClassHookWebView.m
//  ClassHookWebView
//
//  Created by Hirose Tatsuya on 2013/08/30.
//  Copyright (c) 2013年 Tatyusa. All rights reserved.
//

#import "ClassHookWebView.h"

@implementation ClassHookWebView

-(void)setDelegate:(id<UIWebViewDelegate>)delegate
{
    [super setDelegate:self];
    self.originalDelegate = delegate;
}

-(void)addTarget:(id)target action:(SEL)action forClass:(NSString *)className
{
    if(self.actions==nil) self.actions = [[NSMutableDictionary alloc] init];
    [self.actions setObject:@{@"target":target,@"action":NSStringFromSelector(action)} forKey:className];
}

-(void)execAppAPI:(NSString *)className href:(NSString *)href
{
    NSObject *target = self.actions[className][@"target"];
    SEL action = NSSelectorFromString(self.actions[className][@"action"]);
    if ([target respondsToSelector:action])
    {
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [target performSelector:action withObject:href];
        #pragma clang diagnostic pop
    }
}

#pragma mark UIWebViewDelegate Methods

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    for(NSString *className in [self.actions allKeys]){
        NSString *js = [NSString stringWithFormat:@""
                         "var list = document.getElementsByClassName('%@'); "
                         "for(var i=0;i<list.length;i++){ "
                         "  var e = list[i]; "
                         "  var href = e.getAttribute('href'); "
                         "  e.setAttribute('href','javascript:void(0)'); "
                         "  e.setAttribute('data-href',href); "
                         "  e.addEventListener('click',function(){ "
                         "    document.location='app-api://%@({\"href\":\"'+this.getAttribute('data-href')+'\"})'; "
                         "  }); "
                         "} "
                         ,className,className];
        [self stringByEvaluatingJavaScriptFromString:js];
    }
    
    if(self.originalDelegate!=nil&&[self.originalDelegate respondsToSelector:@selector(webViewDidFinishLoad:)])
    {
        [self.originalDelegate webViewDidFinishLoad:webView];
    }
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *requestString = [[request URL] absoluteString];
    if ([requestString rangeOfString:@"app-api://"].location == NSNotFound) return YES;
    
    NSError *error = nil;
    NSString *pattern = [NSString stringWithFormat:@"app-api://(.+)\\((.+)\\)"];
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    if(error != nil) return NO;
    
    NSTextCheckingResult *match = [reg firstMatchInString:requestString options:0 range:NSMakeRange(0, requestString.length)];
    if(match.numberOfRanges == 0) return NO;
    
    NSString *className = [[requestString substringWithRange:[match rangeAtIndex:1]] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *json = [[requestString substringWithRange:[match rangeAtIndex:2]] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    NSString *href = dict[@"href"];
    
    [self execAppAPI:className href:href];
    
    if(self.originalDelegate!=nil&&[self.originalDelegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)])
    {
        return [self.originalDelegate webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    if(self.originalDelegate!=nil&&[self.originalDelegate respondsToSelector:@selector(webViewDidStartLoad:)])
    {
        [self.originalDelegate webViewDidStartLoad:webView];
    }
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if(self.originalDelegate!=nil&&[self.originalDelegate respondsToSelector:@selector(webView:didFailLoadWithError:)])
    {
        [self.originalDelegate webViewDidStartLoad:webView];
    }
}
@end
