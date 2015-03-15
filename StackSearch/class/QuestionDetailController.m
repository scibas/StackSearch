//
//  QuestionDetailController.m
//  StackSearch
//
//  Created by Pawel Scibek on 14/03/15.
//  Copyright (c) 2015 Pawel Scibek. All rights reserved.
//

#import "QuestionDetailController.h"
@import WebKit;

@implementation QuestionDetailController

-(void)loadView{
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectZero];
    webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    self.view = webView;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Question", @"Question");
    
    self.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
    self.navigationItem.leftItemsSupplementBackButton = YES;
}

-(void)loadUrl:(NSURL *)url{
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [(UIWebView *)self.view loadRequest:request];
}

-(void)dealloc{
    NSLog(@"DEALOC DETAIS VC");
}

@end
