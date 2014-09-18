//
//  MovieViewController.h
//  MovieReviewsApp
//
//  Created by Venkata Reddy on 9/14/14.
//  Copyright (c) 2014 Venkata Reddy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property (atomic,strong)NSString *viewName;
@property (atomic,strong)NSString *url;

@end
