//
//  ALTableViewCell.m
//  ALLibrary-iOS
//
//  Created by Allen on 14-10-16.
//  Copyright (c) 2014年 zlycare. All rights reserved.
//

#import "ALTableViewCell.h"

@implementation ALTableViewCell
@synthesize m_companyLbl, m_passWordLbl, m_userNameLbl;

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.m_userNameLbl =
        [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
        self.m_passWordLbl =
        [[UILabel alloc] initWithFrame:CGRectMake(0, 35, 320, 30)];
        self.m_companyLbl =
        [[UILabel alloc] initWithFrame:CGRectMake(0, 70, 320, 30)];
        
        [self addSubview:self.m_userNameLbl];
        [self addSubview:self.m_passWordLbl];
        [self addSubview:self.m_companyLbl];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
