//
//  STFlexibleCellHeightViewController2.m
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


#import "STFlexibleCellHeightViewController2.h"
#import "STTableViewCell.h"
#import "STTweetRowData.h"
#import "STImageAndCaptionRowData.h"

@implementation STFlexibleCellHeightViewController2

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Tweets and Images";
        
        _rows = [NSMutableArray arrayWithCapacity:30];
        
        STTweetRowData *tweet;
        STImageAndCaptionRowData *imageAndCaption;
        NSDate *createdAt = [NSDate date];
        for (int i  = 0; i < 15; i++) {
            tweet = [[STTweetRowData alloc] init];
            tweet.username = @"stack3";
            tweet.status = @"We make iPhone and iPad apps for social networking and cloud services.\nCopyright stack3.net\nSince 2010.";
            tweet.createdAt = createdAt;
            [_rows addObject:tweet];
            
            imageAndCaption = [[STImageAndCaptionRowData alloc] init];
            imageAndCaption.caption = @"Ramen noodle";
            imageAndCaption.image = [UIImage imageNamed:@"ramen_noodle.jpg"];
            [_rows addObject:imageAndCaption];
            
            createdAt = [createdAt dateByAddingTimeInterval:-60];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView = tableView;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    _tweetCellForHeight = [[STTweetCell alloc] initWithFrame:CGRectZero];
    _imageAndCaptionCellForHeight = [[STImageAndCaptionCell alloc] initWithFrame:CGRectZero];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    STTableViewRowData *rowData = [_rows objectAtIndex:indexPath.row];
    
    NSString *cellIdentifier = [[rowData class] cellIdentifier];
    STTableViewCell *cell = (STTableViewCell *)[_tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        Class cellClass = [[rowData class] cellClass];
        cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    [cell setupRowData:rowData];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"tableView:heightForRowAtIndexPath indexPath.row:%d", indexPath.row);
    
    STTableViewRowData *row = [_rows objectAtIndex:indexPath.row];
    STTableViewCell *cellForHeight = nil;
    if ([row isKindOfClass:[STTweetRowData class]]) {
        cellForHeight = _tweetCellForHeight;
    } else if ([row isKindOfClass:[STImageAndCaptionRowData class]]) {
        cellForHeight = _imageAndCaptionCellForHeight;
    }
    [cellForHeight setupRowData:row];

    CGSize size;
    size.width = _tableView.frame.size.width;
    size.height = STMaxCellHeight;
    size = [cellForHeight sizeThatFits:size];
    return size.height;
    
}

@end
