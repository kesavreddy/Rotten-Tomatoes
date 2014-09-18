//
//  MovieCell.h
//  MovieReviewsApp
//
//  Created by Venkata Reddy on 9/14/14.
//  Copyright (c) 2014 Venkata Reddy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *sysnopissLabel;

@end
