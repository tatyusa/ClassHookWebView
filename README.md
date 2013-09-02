#ClassHookWebView

`ClassHookWebView` is a web view for iOS. The parent is UIWebView. It provides functionality for running a method in an iOS app by trigger on a web site. To use this functionality, you just add a class to DOMs in your web site.

ARC is required.

##Feature
* ClassHookWebView behaves as UIWebview
* You just add a class to DOMs in your web site for running a method in an app.
* You can add functionality to \<a\> tag in an app, while it behaves normally in Web Client (Safari, Chrome, etc…)

##Getting Started
First you get ClassHookWebView.

    $git clone git@github.com:tatyusa/ClassHookWebView.git
  
Add ClassHookWebView.h/ClassHookWebView.m to your project.
  
    ClassHookWebView/Vender/ClassHookWebView.h
    ClassHookWebView/Vender/ClassHookWebView.m
  
In the class you want to use ClassHookWebView in, import the `ClassHookWebView.h`.

    #import "ClassHookWebView.h"
  
Set the Protocol and make property.

    @interface ViewController: UIViewController<UIWebViewDelegate>
    @property (nonatomic,retain) ClassHookWebView *chWebView;

Synthesize it.

    @synthesize chWebView;

Initialize the chWebView.
  
    chWebView = [[ClassHookWebView alloc] initWithFrame:self.view.bounds];
    [chWebView setDelegate:self];
    [self.view addSubview:chWebView];

Add class hook actions to chWebView.

    [chWebView addTarget:self action:@selector(showAlert:) forClass:@"app-show-alert"];
    [chWebView addTarget:self action:@selector(startActivity) forClass:@"app-start-activity"];
    …
Last you add the class to DOMs in your web site

    <a class="app-show-alert" href="https://github.com/tatyusa/ClassHookWebView">Alert Show</a>
    <div class="class-hook-block app-show-alert" href="hahaha">Tap me!</div>

That's all.
    
##Example
You can see an example in `ClassHookWebView.xcodeproj`.
Let's clone.

## MIT License
Copyright (C) 2013 Tatsuya Hirose

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
