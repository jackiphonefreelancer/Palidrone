//
//  ViewController.m
//  Palidrone
//
//  Created by Teerapat on 7/23/2558 BE.
//  Copyright (c) 2558 Teerapat. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end

NSString *stringInput;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressCalculate:(id)sender {
    
    NSString *result = [self findLongestPalindrone:_inputTextField.text];
    [_resultLabel setText:result];
}

/* ===================================
 
 Func findLongestPalindrone
 To find palidrone
 
 =================================== */

-(NSString*)findLongestPalindrone:(NSString*)inputString
{
    // Case : Good input string
    if(inputString != NULL && inputString.length > 0)
    {
        //Here is the solution to find Palindrone
        
        NSString *result;
        
        int temp[inputString.length];
        int centerIndex = 0, row = 0; // Center and row
        int idx1 = 0, idx2 = 0; // Comapare 2 elements is the same value
        
        for (int i = 1; i<inputString.length; i++)
        {
            if (i>row) {
                temp[i] = 0; idx1 = i-1; idx2 = i+1;
            } else {
                int i2 = centerIndex*2-i;
                if (temp[i2]<(row-i)) {
                    temp[i] = temp[i2];
                    idx1 = -1; // Skip while loop
                } else {
                    temp[i] = row-i;
                    idx2 = row+1; idx1 = i*2-idx2;
                }
            }
            
            while (idx1>=0 && idx2<inputString.length && [inputString UTF8String][idx1]==[inputString UTF8String][idx2])
            {
                temp[i]++;
                idx1--;
                idx2++;
            }
            if ((i+temp[i])>row) {
                centerIndex = i;
                row = i+temp[i];
            }
        }
        
        int len = 0; centerIndex = 0;
        for (int i = 1; i<inputString.length; i++)
        {
            if (len<temp[i]) {
                len = temp[i];
                centerIndex = i;
            }
        }
        
        result = [inputString substringWithRange:NSMakeRange(centerIndex-len, len*2+1)];
        
        // Finally Checking
        // result length must be > 1 , so say something if not
        if(result.length <= 1)
            result = @"No palidrone in this sentence !!";
        
        return result;
    }
    else // Case : No inout string
    {
        return @"No input string, we cannot find Palindrone !!";
    }
}


@end
