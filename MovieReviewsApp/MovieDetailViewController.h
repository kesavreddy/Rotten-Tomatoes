//
//  MovieDetailViewController.h
//  MovieReviewsApp
//
//  Created by Venkata Reddy on 9/16/14.
//  Copyright (c) 2014 Venkata Reddy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieDetailViewController : UIViewController

@property (nonatomic) NSString *movieTitle;
@property (nonatomic) NSString *moviePoster;
@property (nonatomic) NSString *movieDescription;
@property (nonatomic) NSString *movieBgThumbnailImageUrl;
@property (nonatomic) NSString *movieBgDetailedImageUrl;

@end
