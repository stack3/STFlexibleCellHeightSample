//
//  STImageAndCaptionCell.m
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

#import "STImageAndCaptionCell.h"

@implementation STImageAndCaptionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)setupRowData:(STTableViewRowData *)rowData
{
    if (![rowData isKindOfClass:[STImageAndCaptionRowData class]]) {
        return;
    }
    
    STImageAndCaptionRowData *imageAndCaption = (STImageAndCaptionRowData *)rowData;
    self.imageView.image = imageAndCaption.image;
    self.textLabel.text = imageAndCaption.caption;
    self.textLabel.font = [UIFont boldSystemFontOfSize:16.0f];
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
    CGRect imageViewFrame;
    imageViewFrame.origin.x = STMargin;
    imageViewFrame.origin.y = STMargin;
    imageViewFrame.size.width = size.width - STMargin*2;
    imageViewFrame.size.height = self.imageView.image.size.height * imageViewFrame.size.width / self.imageView.image.size.width;
    if (withLayout) {
        self.imageView.frame = imageViewFrame;
    }
    
    CGRect captionLabelFrame;
    captionLabelFrame.origin.x = STMargin;
    captionLabelFrame.origin.y = imageViewFrame.origin.y + imageViewFrame.size.height;
    captionLabelFrame.size.width = size.width - STMargin*2;
    captionLabelFrame.size.height = size.height;
    captionLabelFrame.size = [self.textLabel sizeThatFits:captionLabelFrame.size];
    if (withLayout) {
        self.textLabel.frame = captionLabelFrame;
    }
    
    size.height = captionLabelFrame.origin.y + captionLabelFrame.size.height + STMargin;
    return size;
}

@end
