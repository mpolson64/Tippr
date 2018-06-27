//
//  ViewController.m
//  Tippr
//
//  Created by Miles Olson on 6/26/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *inputView;
@property (weak, nonatomic) IBOutlet UIView *outputView;
@property (weak, nonatomic) IBOutlet UILabel *promptLabel;

@property (weak, nonatomic) IBOutlet UITextField *billField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
@property (weak, nonatomic) IBOutlet UISlider *customTipSlider;

@property (weak, nonatomic) IBOutlet UILabel *pay1;
@property (weak, nonatomic) IBOutlet UILabel *pay2;
@property (weak, nonatomic) IBOutlet UILabel *pay3;
@property (weak, nonatomic) IBOutlet UILabel *pay4;

@end

@implementation ViewController
bool firstEdit;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    firstEdit = true;
    
    self.outputView.alpha = 0;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)onEdit:(id)sender {
    if(firstEdit){
        [UIView animateWithDuration:0.2 animations:^{
            int slideUpDistance = 175;
            
            self.promptLabel.frame = CGRectMake(self.promptLabel.frame.origin.x, self.promptLabel.frame.origin.y - slideUpDistance, self.promptLabel.frame.size.width, self.promptLabel.frame.size.height);
            
            self.inputView.frame = CGRectMake(self.inputView.frame.origin.x, self.inputView.frame.origin.y - slideUpDistance, self.inputView.frame.size.width, self.inputView.frame.size.height);
            
            self.outputView.alpha = 1;
            self.outputView.frame = CGRectMake(self.outputView.frame.origin.x, self.outputView.frame.origin.y - slideUpDistance, self.outputView.frame.size.width, self.outputView.frame.size.height);
            
        }];
        
        firstEdit = false;
    }
    
    NSArray *percentages = @[@(0.15), @(0.18), @(0.2), @(self.customTipSlider.value * 0.4 + 0.1)];
    
    NSString *customTipTitle = [NSString stringWithFormat:@"%.0f%%", [percentages[3] floatValue] * 100];
    [self.tipControl setTitle:customTipTitle forSegmentAtIndex:3];
    
    double total = [self.billField.text doubleValue] * (1 + [percentages[self.tipControl.selectedSegmentIndex] doubleValue]);
    
    self.pay1.text = [NSString stringWithFormat:@"$%.2f", total];
    self.pay2.text = [NSString stringWithFormat:@"$%.2f", total / 2];
    self.pay3.text = [NSString stringWithFormat:@"$%.2f", total / 3];
    self.pay4.text = [NSString stringWithFormat:@"$%.2f", total / 4];
}

@end
