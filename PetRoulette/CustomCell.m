//
//  CustomCell.m
//  PetRoulette
//
//  Created by IGPROJ-MAC01 on 05/05/13.
//  Copyright (c) 2013 IGPROJ-MAC01. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect contentRect = self.contentView.bounds;
    CGFloat boundsX = contentRect.origin.x;
    CGRect frame;
    frame= CGRectMake(boundsX+10 ,0, 50, 50);
    self.myImageView.frame = frame;
    
    frame= CGRectMake(boundsX+70 ,5, 200, 25);
    self.primaryLabel.frame = frame;
    
    frame= CGRectMake(boundsX+70 ,30, 100, 15);
    self.secondaryLabel.frame = frame;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.primaryLabel.textAlignment = NSTextAlignmentLeft;
        self.primaryLabel.font = [UIFont systemFontOfSize:14];
        self.secondaryLabel.textAlignment = NSTextAlignmentLeft;
        self.secondaryLabel.font = [UIFont systemFontOfSize:8];
        //[self.contentView addSubview:_primaryLabel];
        //[self.contentView addSubview:_secondaryLabel];
        //[self.contentView addSubview:_myImageView];
        
    }
    return self;
}


@end
