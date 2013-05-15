//
//  CustomCell.h
//  PetRoulette
//
//  Created by IGPROJ-MAC01 on 05/05/13.
//  Copyright (c) 2013 IGPROJ-MAC01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UILabel *primaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondaryLabel;




- (void)layoutSubviews;
- (void)setSelected:(BOOL)selected animated:(BOOL)animated;


@end
