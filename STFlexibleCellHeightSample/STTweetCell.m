//
//  STTweetCell.m
//  STFlexibleCellHeightSample
//
//  Copyright (c) 2012 stack3.net (http://stack3.net/)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//


#import "STTweetCell.h"

@implementation STTweetCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _userIconView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_userIconView];
        
        _usernameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _usernameLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        [self.contentView addSubview:_usernameLabel];
        
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _statusLabel.font = [UIFont systemFontOfSize:16.0f];
        _statusLabel.numberOfLines = 0;
        _statusLabel.lineBreakMode = NSLineBreakByWordWrapping; // UILineBreakModeWordWrap is deprecated
        [self.contentView addSubview:_statusLabel];
        
        _createdAtLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _createdAtLabel.font = [UIFont systemFontOfSize:14.0f];
        _createdAtLabel.lineBreakMode = NSLineBreakByWordWrapping; // UILineBreakModeWordWrap is deprecated
        _createdAtLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_createdAtLabel];
    }
    return self;
}

- (void)setupRowData:(STTableViewRowData *)rowData
{
    if (![rowData isKindOfClass:[STTweetRowData class]]) {
        return;
    }
    
    STTweetRowData *tweet = (STTweetRowData *)rowData;
    _userIconView.image = [UIImage imageNamed:tweet.username];
    _usernameLabel.text = tweet.username;
    _statusLabel.text = tweet.status;
    _createdAtLabel.text = tweet.createdAt.description;
}

/**
 * Override UIView method
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect bounds = self.bounds;
    [self sizeThatFits:bounds.size withLayout:YES];
}

/**
 * Override UIView method
 */
- (CGSize)sizeThatFits:(CGSize)size
{
    return [self sizeThatFits:size withLayout:NO];
}

/**
 * @param size Bounds size
 * @param withLayout YES if set frame of subviews.
 */
- (CGSize)sizeThatFits:(CGSize)size withLayout:(BOOL)withLayout
{
    CGRect userIconViewFrame;
    userIconViewFrame.origin.x = STMargin;
    userIconViewFrame.origin.y = STMargin;
    userIconViewFrame.size.width = STUserIconSize;
    userIconViewFrame.size.height = STUserIconSize;
    if (withLayout) {
        _userIconView.frame = userIconViewFrame;
    }
    CGFloat minHeight = userIconViewFrame.origin.y + userIconViewFrame.size.height + STMargin;
    
    CGRect usernameLabelFrame;
    usernameLabelFrame.origin.x = userIconViewFrame.origin.x + userIconViewFrame.size.width + STMargin;
    usernameLabelFrame.origin.y = STMargin;
    usernameLabelFrame.size.width = size.width - usernameLabelFrame.origin.x - STMargin;
    usernameLabelFrame.size.height = size.height - usernameLabelFrame.origin.y;
    usernameLabelFrame.size = [_usernameLabel sizeThatFits:usernameLabelFrame.size];
    if (withLayout) {
        _usernameLabel.frame = usernameLabelFrame;
    }
    
    CGRect statusLabelFrame;
    statusLabelFrame.origin.x = usernameLabelFrame.origin.x;
    statusLabelFrame.origin.y = usernameLabelFrame.origin.y + usernameLabelFrame.size.height;
    statusLabelFrame.size.width = size.width - statusLabelFrame.origin.x - STMargin;
    statusLabelFrame.size.height = size.height - statusLabelFrame.origin.y;
    statusLabelFrame.size = [_statusLabel sizeThatFits:statusLabelFrame.size];
    if (withLayout) {
        _statusLabel.frame = statusLabelFrame;
    }
    
    CGRect createdAtLabelFrame;
    createdAtLabelFrame.origin.x = statusLabelFrame.origin.x;
    createdAtLabelFrame.origin.y = statusLabelFrame.origin.y + statusLabelFrame.size.height;
    createdAtLabelFrame.size.width = size.width - createdAtLabelFrame.origin.x  - STMargin;
    createdAtLabelFrame.size.height = size.height - createdAtLabelFrame.origin.y;
    createdAtLabelFrame.size = [_createdAtLabel sizeThatFits:createdAtLabelFrame.size];
    if (withLayout) {
        _createdAtLabel.frame = createdAtLabelFrame;
    }
 
    size.height = createdAtLabelFrame.origin.y + createdAtLabelFrame.size.height + STMargin;
    if (size.height < minHeight) {
        size.height = minHeight;
    }

    return size;
}

@end
