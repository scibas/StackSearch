//
//  QuestionDetailController.m
//  StackSearch
//
//  Created by Pawel Scibek on 14/03/15.
//  Copyright (c) 2015 Pawel Scibek. All rights reserved.
//

#import "QuestionDetailController.h"
#import "NSLayoutConstraint+DTOHelpers.h"
@import WebKit;

@interface QuestionDetailController() <WKNavigationDelegate>
@property(nonatomic, strong) UIActivityIndicatorView *loadingActivityIndicator;

@end

@implementation QuestionDetailController

-(void)loadView{
    //Web View
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectZero];
    webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    webView.navigationDelegate = self;
    
    //Activity Indicator
    UIActivityIndicatorView *loadingActivityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    loadingActivityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    loadingActivityIndicator.color = [UIColor grayColor];
    [webView addSubview:loadingActivityIndicator];
    self.loadingActivityIndicator = loadingActivityIndicator;
    
    //Activity Indicator constraints
    [webView addConstraint:[NSLayoutConstraint dto_verticalyCenterView:loadingActivityIndicator inSuperView:webView]];
    [webView addConstraint:[NSLayoutConstraint dto_horizontalyCenterView:loadingActivityIndicator inSuperView:webView]];

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

-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [self.loadingActivityIndicator startAnimating];
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [self.loadingActivityIndicator stopAnimating];
}

-(void)dealloc{
    [((UIWebView *)self.view) stopLoading];
}

@end
