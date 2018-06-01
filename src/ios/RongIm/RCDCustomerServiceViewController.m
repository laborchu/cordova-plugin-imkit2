#import "RCDCustomerServiceViewController.h"

@interface RCDCustomerServiceViewController ()

@end

@implementation RCDCustomerServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:@selector(backAction:)];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)backAction: (id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



@end