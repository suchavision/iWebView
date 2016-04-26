#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.webView.delegate = self;
    self.indicator.hidden = YES;
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
}

- (void)tapAction: (id)sender
{
    // resign first responder
    [self.urlTextField becomeFirstResponder];
    [self.urlTextField resignFirstResponder];
}

- (IBAction)loadButtonAction:(id)sender {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"] ];
    [self.webView loadRequest:request];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlTextField.text] ];
    [self.webView loadRequest:urlRequest];
}

- (IBAction)reloadButtonAction:(id)sender {
    [self.webView reload];
}

- (IBAction)backButtonAction:(id)sender {
    if([self.webView canGoBack]) {
        [self.webView goBack];
    }
}

- (IBAction)forwardButtonAction:(id)sender {
    if ([self.webView canGoForward]) {
        [self.webView goForward];
    }
}

- (IBAction)stopButtonAction:(id)sender {
    [self.webView stopLoading];
    [self.indicator stopAnimating];
    self.indicator.hidden = YES;
}

#pragma mark - UIWebViewDelegate Methods


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"shouldStartLoadWithRequest : %@", request);
    self.redirectURLTextField.text = [request.URL absoluteString];
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidStartLoad");
    [self.indicator startAnimating];
    self.indicator.hidden = NO;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidFinishLoad");
    [self.indicator stopAnimating];
    self.indicator.hidden = YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    NSLog(@"didFailLoadWithError : %@", error);
}

@end
