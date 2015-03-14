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
#import "SubtitleStyleCell+SEQuestion.h"

static NSString *const kTableViewCellReuseIdentifier = @"TableViewCellReuseIdentifier";

@interface SearchResultsController() <UISearchBarDelegate, UISearchControllerDelegate>
@property(nonatomic, strong) SEResponse *response;
@property(nonatomic, strong) UIButton *searchMoreButton;
@property(nonatomic, strong) UISearchController *searchController;
@property(nonatomic, strong) NSDictionary *lastSearchParameters;
@end

@implementation SearchResultsController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"StackSearch", @"StackSearch");
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
    searchController.searchBar.showsCancelButton = YES;
    searchController.dimsBackgroundDuringPresentation = NO;
    searchController.searchBar.delegate = self;
    searchController.delegate = self;
    self.tableView.tableHeaderView = searchController.searchBar;
    self.searchController = searchController;
    
}

#pragma mark - Actions
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
   
    SearchEngineParametersBuilder *parametersBuilder = [[SearchEngineParametersBuilder alloc] init];
    parametersBuilder.searchPhrase = searchBar.text;
    NSDictionary *currentSearchParameters = [parametersBuilder build];
    
    NSURLSessionTask *searchTask = [self responseForParameters:currentSearchParameters completionBlock:^(SEResponse *response, NSError *error) {
        [self manageResponse:response];
    }];
    
    [self.refreshControl setRefreshingWithStateOfTask:searchTask];
    
    self.lastSearchParameters = currentSearchParameters;
}

-(void)tableViewDidPullDownToRefresh:(id)sender{

    NSURLSessionTask *searchTask = [self responseForParameters:self.lastSearchParameters completionBlock:^(SEResponse *response, NSError *error) {
        [self manageResponse:response];
    }];
    
    [self.refreshControl setRefreshingWithStateOfTask:searchTask];
}

-(void)searchMoreButtonDidTap:(UIButton *)sender{
   
    SearchEngineParametersBuilder *parametersBuilder = [[SearchEngineParametersBuilder alloc] init];
    NSDictionary *parameters = [parametersBuilder nextPageFromParameters:self.lastSearchParameters];
    
    [self responseForParameters:parameters completionBlock:^(SEResponse *response, NSError *error) {
        [response mergeWithItems:self.response.items];
        [self manageResponse:response];
    }];
}

-(void)manageResponse:(SEResponse *)response{
    self.response = response;
    self.searchMoreButton.hidden = !response.has_more;
    
    NSLog(@"Quota remaining: %d/%d", (int)response.quota_remaining, (int)response.quota_max);
    
    [self.tableView reloadData];
}


-(NSURLSessionTask *)responseForParameters:(NSDictionary *)parameters completionBlock:(void (^)(SEResponse *response, NSError *error))completionBlock{
    SESessionManager *sessionManager = [SESessionManager sharedInstance];
    SearchEngine *searchEngine = [[SearchEngine alloc] initWithSessionManager:sessionManager];
    
    NSURLSessionTask *task = [searchEngine performSearchWithParameters:parameters completionBlock:^(SEResponse *response, NSError *error) {
        if(completionBlock){
            completionBlock(response, error);
        }
    }];

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

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    DTOSEQuestion *selectedQuestion;
//    DTOQuestionDetailsController *questionDitailsController = [[DTOQuestionDetailsController alloc] initWithQuestion:selectedQuestion];
//    
//    [self.navigationController pushViewController:questionDitailsController animated:YES];
    
}


@end
