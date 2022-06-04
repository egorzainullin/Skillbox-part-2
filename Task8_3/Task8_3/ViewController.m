//
//  ViewController.m
//  Task8_3
//
//  Created by Егор Зайнуллин on 04.06.2022.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

NSString* _previous;

- (IBAction)addNewText:(id)sender {
    _previous = [NSString stringWithFormat:@"%@ %@", _previous, _textField.text];
    _label.text = _previous;
    NSLog(@"%@", _label.text);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _previous = @"";
    // Do any additional setup after loading the view.
}


@end
