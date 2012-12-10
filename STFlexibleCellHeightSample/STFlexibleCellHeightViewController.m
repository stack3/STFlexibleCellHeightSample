//
//  STFlexibleCellHeightViewController.m
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


#import "STFlexibleCellHeightViewController.h"
#import "STTweetRowData.h"
#import "STTweetCell.h"
#import "STTableViewCell.h"

@implementation STFlexibleCellHeightViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Tweets";
        
        //
        // Initialize tweets to display on cells.
        // Add 30 tweets.
        //
        _tweets = [NSMutableArray arrayWithCapacity:100];
        
        STTweetRowData *tweet;
        NSDate *createdAt = [NSDate date];
        for (int i  = 0; i < 15; i++) {
            tweet = [[STTweetRowData alloc] init];
            tweet.username = @"stack3";
            tweet.status = @"We make iPhone and iPad apps for social networking and cloud services.\nCopyright stack3.net\nSince 2010.";
            tweet.createdAt = createdAt;
            [_tweets addObject:tweet];
            
            createdAt = [createdAt dateByAddingTimeInterval:-60];
            
            tweet = [[STTweetRowData alloc] init];
            tweet.username = @"passionz";
            tweet.status = @"You can browse tumblr on iPad. https://itunes.apple.com/jp/app/passionz-for-tumblr/id557879179?l=ja&ls=1&mt=8";
            tweet.createdAt = createdAt;
            [_tweets addObject:tweet];
            
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

    _cellForHeight = [[STTweetCell alloc] initWithFrame:CGRectZero];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    STTweetRowData *tweet = [_tweets objectAtIndex:indexPath.row];
    
    NSString *cellId = @"cellId";
    STTweetCell *cell = (STTweetCell *)[_tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[STTweetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    [cell setupRowData:tweet];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"tableView:heightForRowAtIndexPath indexPath.row:%d", indexPath.row);
    
    STTweetRowData *tweet = [_tweets objectAtIndex:indexPath.row];
    [_cellForHeight setupRowData:tweet];
    
    CGSize size;
    size.width = _tableView.frame.size.width;
    size.height = STMaxCellHeight;
    size = [_cellForHeight sizeThatFits:size];
    return size.height;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    STTweetRowData *tweet = [_tweets objectAtIndex:indexPath.row];
    STEditTextViewController *con = [[STEditTextViewController alloc] initWithInitialText:tweet.status];
    con.title = @"Edit Status";
    con.delegate = self;
    [self.navigationController pushViewController:con animated:YES];
}

#pragma mark - STEditTextViewControllerDelegate

- (void)editTextViewController:(STEditTextViewController *)sender didEditText:(NSString *)text
{
    NSArray *selectedIndexPaths = [_tableView indexPathsForSelectedRows];
    if (selectedIndexPaths.count > 0) {
        NSIndexPath *indexPath = [selectedIndexPaths objectAtIndex:0];
        STTweetRowData *tweet = [_tweets objectAtIndex:indexPath.row];
        tweet.status = text;
        
        if (YES) {
            [_tableView reloadData];
        } else {
            // Notice. Return nil if the cell was not visible.
            STTweetCell *cell = (STTweetCell *)[_tableView cellForRowAtIndexPath:indexPath];
            if (cell) {
                [cell setupRowData:tweet];
                [_tableView beginUpdates];
                [_tableView endUpdates];
            }
        }
    }
}

@end
