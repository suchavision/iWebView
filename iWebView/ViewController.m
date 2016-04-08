#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.webView.delegate = self;
    self.indicator.hidden = YES;
}

- (IBAction)loadButtonAction:(id)sender {
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString: @"about:blank"] ];
    [self.webView loadRequest:request];
    
    NSURLRequest* urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString: self.urlTextField.text] ];
    [self.webView loadRequest:urlRequest];
}

#pragma mark - UIWebViewDelegate Methods


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.indicator startAnimating];
    self.indicator.hidden = NO;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.indicator stopAnimating];
    self.indicator.hidden = YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    NSLog(@"%@", error);
}

@end
