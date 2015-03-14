//
//  QuestionDetailController.m
//  StackSearch
//
//  Created by Pawel Scibek on 14/03/15.
//  Copyright (c) 2015 Pawel Scibek. All rights reserved.
//

#import "QuestionDetailController.h"
#import "SEQuestion.h"

@interface QuestionDetailController()
@property(nonatomic, weak, readonly) UIWebView *webView;
@property(nonatomic, strong) SEQuestion *question;
@end

@implementation QuestionDetailController

-(instancetype)initWithQuestion:(SEQuestion *)question{
    NSParameterAssert(question);
    self = [super init];
    if(self) {
        _question = question;
    }
    return self;
}

-(void)loadView{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    self.view = webView;
}

-(void)viewDidLoad{
    NSURL *url = [[NSURL alloc] initWithString:self.question.link];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:request];
}

-(UIWebView *)webView{
    return (UIWebView*) self.view;
}

@end
