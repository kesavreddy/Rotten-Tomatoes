//
//  MovieViewController.m
//  MovieReviewsApp
//
//  Created by Venkata Reddy on 9/14/14.
//  Copyright (c) 2014 Venkata Reddy. All rights reserved.
//

#import "MovieViewController.h"
#import "UIImageView+AFNetworking.h"
#import "MovieDetailViewController.h"
#import "MovieCell.h"

@interface MovieViewController (){
    UIRefreshControl *refreshControl;
    BOOL isSearch;
    NSString *apiUrl;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (atomic,strong)NSArray *movies;
@property (nonatomic, strong) NSMutableArray *searchResult;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

@end

@implementation MovieViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        self.view.backgroundColor = [UIColor blackColor];

        NSLog(@" Nib view loaded");
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.viewName;
    // Do any additional setup after loading the view from its nib.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 100;
    self.errorLabel.hidden = YES;
    // Get data
    [self fetchData];
    
    // Add refresh control
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(onRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    
    // Add searchbox
    self.searchBar.delegate = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil]forCellReuseIdentifier:@"MovieCell"];
    
    // TODO implement error message from BE timeout or return error
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:tableView numberOfRowsInSection:(NSInteger)section{
    if (isSearch){
    return self.searchResult.count;
    } else{
    return self.movies.count;
    }
}

- (UITableViewCell *)tableView:tableview cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MovieCell *cell = [tableview dequeueReusableCellWithIdentifier:@"MovieCell"];
    
    NSDictionary *movie;
    if (isSearch) {
        if (self.searchResult.count > indexPath.row) {
            movie = self.searchResult[indexPath.row];
        }
    } else {
        movie = self.movies[indexPath.row];
    }
    
    cell.titleLabel.text = movie[@"title"];
    cell.sysnopissLabel.text = movie[@"synopsis"];
    NSString *posterUrl = movie[@"posters"][@"original"];
    [cell.posterView setImageWithURL:[NSURL URLWithString:posterUrl]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    MovieCell *movieCell = (MovieCell *)[tableView cellForRowAtIndexPath:indexPath];
    NSDictionary *movie = self.movies[indexPath.row];
    
    MovieDetailViewController *movieDetailViewController = [[MovieDetailViewController alloc] init];
    movieDetailViewController.movieTitle = movieCell.titleLabel.text;
    movieDetailViewController.movieDescription = movieCell.sysnopissLabel.text;
    movieDetailViewController.movieBgThumbnailImageUrl = movie[@"posters"][@"thumbnail"];

    NSString *orgImageUrl =movie[@"posters"][@"original"];
    
    orgImageUrl = [orgImageUrl stringByReplacingOccurrencesOfString:@"_tmb"
                                                         withString:@"_ori"];
    
    movieDetailViewController.movieBgDetailedImageUrl = orgImageUrl;
    
    [self.navigationController pushViewController:movieDetailViewController animated:YES];
}

/*
 * Get latest data and update the view
 */
- (void)fetchData {
    NSLog(@" Url %@",self.url);
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        NSLog(@" connectionError %@",connectionError);
        if (connectionError == nil) {
            self.errorLabel.hidden = YES;
            self.searchBar.hidden = NO;
            NSDictionary *object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.movies = object[@"movies"];
            [self.tableView reloadData];
        } else {
            self.errorLabel.hidden = NO;
            self.searchBar.hidden = YES;
        }
    }];

}

/*
 * When user pull down, refresh the data
 */
- (void)onRefresh:(id)sender {
    [self fetchData];
    [(UIRefreshControl *)sender endRefreshing];
}

/*
 * When user start searching
 */
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if([searchText isEqualToString:@""] || searchText==nil) {
        isSearch = NO;
        [self.tableView reloadData];
        return;
    }
    isSearch = YES;
    [self.searchResult removeAllObjects];
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"title contains[c] %@", searchText];
    
    self.searchResult = [NSMutableArray arrayWithArray: [self.movies filteredArrayUsingPredicate:resultPredicate]];
    [self.tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
}


@end
