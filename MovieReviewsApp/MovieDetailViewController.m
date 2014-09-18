//
//  MovieDetailViewController.m
//  MovieReviewsApp
//
//  Created by Venkata Reddy on 9/16/14.
//  Copyright (c) 2014 Venkata Reddy. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "UIImageView+AFNetworking.h"

@interface MovieDetailViewController ()
@property (strong, nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (strong, nonatomic) UILabel *movieTitleLabel;
@property (strong, nonatomic) UILabel *movieSynopsisLabel;
@property (strong, nonatomic) UIView *movieContentView;

@end

@implementation MovieDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        self.view.backgroundColor = [UIColor blackColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.movieTitle;
    
    // set thumbnail for faster download
    NSString *imageURL = self.movieBgThumbnailImageUrl;
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
    self.posterView.image = [UIImage imageWithData:imageData];
    
    // load high res image
    NSURL *detailUrl = [NSURL URLWithString:self.movieBgDetailedImageUrl];
    NSLog(@"URL:%@", detailUrl);
   [self.posterView setImageWithURL:detailUrl];
    
    // setup movie title
    self.movieTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 300, 50)];
    self.movieTitleLabel.text = self.movieTitle;
    self.movieTitleLabel.textColor = [UIColor grayColor];
    self.movieTitleLabel.backgroundColor = [UIColor clearColor];
    self.movieTitleLabel.numberOfLines = 1;
    [self.movieTitleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    
    CGRect moviewTitleFrame = self.movieTitleLabel.frame;
    CGFloat movieTitleX = CGRectGetMinX(moviewTitleFrame);
    CGFloat movieTitleHeight = CGRectGetHeight(moviewTitleFrame);
    
    // setup movie synopsis
    self.movieSynopsisLabel = [[UILabel alloc] initWithFrame:CGRectMake(movieTitleX, movieTitleHeight + 5., 300, 320)];
    self.movieSynopsisLabel.text = self.movieDescription;
    self.movieSynopsisLabel.textColor = [UIColor lightGrayColor];
    self.movieSynopsisLabel.backgroundColor = [UIColor clearColor];
    self.movieSynopsisLabel.numberOfLines = 0;
    [self.movieSynopsisLabel setFont:[UIFont systemFontOfSize:13]];
    [self.movieSynopsisLabel sizeToFit];
    
    CGRect movieSynopsisFrame = self.movieSynopsisLabel.frame;
    CGFloat movieSynopsisHeight = CGRectGetHeight(movieSynopsisFrame);
    
    float totalHeight = movieTitleHeight + movieSynopsisHeight + 400.;
    
    // setup movie content view
    self.movieContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 300, 320, totalHeight)];
    [self.movieContentView addSubview:self.movieTitleLabel];
    [self.movieContentView addSubview:self.movieSynopsisLabel];
    self.movieContentView.backgroundColor = [UIColor blackColor];
    self.movieContentView.alpha = 0.75;
    
    
    CGRect movieContentFrame = self.movieContentView.frame;
    
    
    // setup scrollview
    CGRect fullScreenRect=[[UIScreen mainScreen] applicationFrame];
    self.scrollView = [[UIScrollView alloc]initWithFrame:fullScreenRect];
    [self.scrollView addSubview:self.movieContentView];
    [self.scrollView setContentSize: movieContentFrame.size];
    
    
    
    // add scrollview to view
    [self.view addSubview:self.scrollView];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
