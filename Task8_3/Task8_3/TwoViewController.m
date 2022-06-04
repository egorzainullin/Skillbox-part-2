//
//  TwoViewController.m
//  Task8_3
//
//  Created by Егор Зайнуллин on 04.06.2022.
//

#import "TwoViewController.h"
#import "math.h"

@interface TwoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation TwoViewController

- (BOOL) isInt: (NSString *) str {
    if ([str isEqualToString:@"0"])
        return YES;
    return ([str intValue] != 0);
}

- (IBAction)printTwoDegree:(id)sender {
    NSString * str = _textField.text;
    if ([self isInt: str]) {
        int n = [str intValue];
        _label.text = [NSString stringWithFormat:@"%f",  pow(2.0, n)];
    }
    else {
        _label.text = @"Input integer number";
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
