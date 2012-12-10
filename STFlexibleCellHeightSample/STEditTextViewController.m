//
//  STEditTextViewController.m
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

#import "STEditTextViewController.h"

@implementation STEditTextViewController

- (id)initWithInitialText:(NSString *)initialText
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _text = initialText;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectZero];
    _textView = textView;
    _textView.font = [UIFont systemFontOfSize:16.0];
    _textView.text = _text;
    _textView.delegate = self;
    [self.view addSubview:_textView];
}

- (void)viewDidLayoutSubviews
{
    CGRect bounds = self.view.bounds;
    CGRect textViewFrame;
    textViewFrame.origin.x = 0;
    textViewFrame.origin.y = 0;
    textViewFrame.size.width = bounds.size.width;
    textViewFrame.size.height = 160;
    _textView.frame = textViewFrame;
}

- (void)willMoveToParentViewController:(UIViewController *)parent
{
    if (parent == nil) {
        // After dismissing by back button.
        [_delegate editTextViewController:self didEditText:_text];
    }
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
    _text = textView.text;
}

@end
