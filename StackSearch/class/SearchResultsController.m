//
//  SearchResultsController.m
//  StackSearch
//
//  Created by Pawel Scibek on 12/03/15.
//  Copyright (c) 2015 Pawel Scibek. All rights reserved.
//

#import "SearchResultsController.h"

#import "SearchEngine.h"
#import "SearchEngineParametersBuilder.h"
#import "SEResponse.h"
#import "SESessionManager.h"
#import "SEQuestion.h"
#import "UIRefreshControl+AFNetworking.h"
#import "UIAlertView+AFNetworking.h"
#import "SubtitleStyleCell+SEQuestion.h"
#import "QuestionDetailController.h"

static NSString *const kTableViewCellReuseIdentifier = @"TableViewCellReuseIdentifier";

@interface SearchResultsController() <UISearchBarDelegate>
@property(nonatomic, strong) SEResponse *response;
@property(nonatomic, strong) UIButton *searchMoreButton;
@property(nonatomic, strong) UISearchController *searchController;
@property(nonatomic, strong) NSDictionary *lastSearchParameters;
@end

@implementation SearchResultsController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Search", @"Search");
    [self.tableView registerClass:[SubtitleStyleCell class] forCellReuseIdentifier:kTableViewCellReuseIdentifier];
    
    //refresh control
    self.refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectZero];
    [self.refreshControl addTarget:self action:@selector(tableViewDidPullDownToRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView.tableHeaderView addSubview:self.refreshControl];
    
    //search more button
    UIButton *searchMoreButton = [UIButton buttonWithType:UIButtonTypeSystem];
    NSString *getMoreButtonTitle = NSLocalizedString(@"Get more", @"Get more");
    [searchMoreButton setTitle:getMoreButtonTitle forState:UIControlStateNormal];
    [searchMoreButton sizeToFit];
    searchMoreButton.hidden = YES;
    [searchMoreButton addTarget:self action:@selector(searchMoreButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    self.searchMoreButton = searchMoreButton;
    self.tableView.tableFooterView = searchMoreButton;

    //search controller
    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    [searchController.searchBar sizeToFit];
    searchController.dimsBackgroundDuringPresentation = NO;
    searchController.searchBar.delegate = self;
    searchController.hidesNavigationBarDuringPresentation = NO;
    self.tableView.tableHeaderView = searchController.searchBar;
    self.searchController = searchController;
    
}

#pragma mark - Actions
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
   
    SearchEngineParametersBuilder *parametersBuilder = [[SearchEngineParametersBuilder alloc] init];
    parametersBuilder.searchPhrase = searchBar.text;
    NSDictionary *currentSearchParameters = [parametersBuilder build];
    
    NSURLSessionTask *searchTask = [self sendHTTPRequestWithParameters:currentSearchParameters completionBlock:^(SEResponse *response, NSError *error) {
        [self manageResponse:response];
    }];
    
    [self.refreshControl setRefreshingWithStateOfTask:searchTask];
    
    self.lastSearchParameters = currentSearchParameters;
}

-(void)tableViewDidPullDownToRefresh:(id)sender{

    NSURLSessionTask *searchTask = [self sendHTTPRequestWithParameters:self.lastSearchParameters completionBlock:^(SEResponse *response, NSError *error) {
        [self manageResponse:response];
    }];
    
    [self.refreshControl setRefreshingWithStateOfTask:searchTask];
}

-(void)searchMoreButtonDidTap:(UIButton *)sender{
   
    SearchEngineParametersBuilder *parametersBuilder = [[SearchEngineParametersBuilder alloc] init];
    NSDictionary *parameters = [parametersBuilder nextPageFromParameters:self.lastSearchParameters];
    
    [self sendHTTPRequestWithParameters:parameters completionBlock:^(SEResponse *response, NSError *error) {
        [response mergeWithItems:self.response.items];
        [self manageResponse:response];
    }];
    
    self.lastSearchParameters = parameters;
}

-(void)manageResponse:(SEResponse *)response{
    self.response = response;
    self.searchMoreButton.hidden = !response.has_more;
    
    NSLog(@"Quota remaining: %d/%d", (int)response.quota_remaining, (int)response.quota_max);
    
    [self.tableView reloadData];
}


-(NSURLSessionTask *)sendHTTPRequestWithParameters:(NSDictionary *)parameters completionBlock:(void (^)(SEResponse *response, NSError *error))completionBlock{
    SESessionManager *sessionManager = [SESessionManager sharedInstance];
    SearchEngine *searchEngine = [[SearchEngine alloc] initWithSessionManager:sessionManager];
    
    NSURLSessionTask *task = [searchEngine performSearchWithParameters:parameters completionBlock:^(SEResponse *response, NSError *error) {
        if(completionBlock){
            completionBlock(response, error);
        }
    }];

    [UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
    
    return task;
}

#pragma mark - table view
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SubtitleStyleCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCellReuseIdentifier];
    
    SEQuestion *question = self.response.items[indexPath.item];
    [cell setupCellWithQuestion:question];

    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.response.items.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    SEQuestion *selectedQuestion = self.response.items[indexPath.row];
    QuestionDetailController *questionViewController;
    
    if(self.splitViewController){
        UINavigationController *detailNavigationController = [self.splitViewController.viewControllers lastObject];
        questionViewController = (QuestionDetailController *)detailNavigationController.topViewController;
    } else {
        questionViewController = [[QuestionDetailController alloc] init];
        [self.navigationController pushViewController:questionViewController animated:YES];
    }
    
    [questionViewController loadUrl:[NSURL URLWithString:selectedQuestion.link]];
}

@end
