//
//  BaseStatistictsDetailViewController.m
//  
//
//  Created by Claude Keswani on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BaseStatistictsDetailViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation BaseStatistictsDetailViewController

@synthesize dataSource;

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    NSArray *niblets = [[NSBundle mainBundle] loadNibNamed:@"PitcherStatsFooter" owner:self options:NULL];
    UIView *theView = (UIView *)[niblets objectAtIndex:0];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:theView.bounds 
                                                   byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight
                                                         cornerRadii:CGSizeMake(10.0, 10.0)];
    

    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = theView.bounds;
    maskLayer.path = maskPath.CGPath;
    theView.layer.mask = maskLayer;
    
    UILabel *ipTotalLabel = (UILabel *)[theView viewWithTag:2];
    UILabel *totalTotalLabel = (UILabel *)[theView viewWithTag:3];
    UILabel *strikesTotalLabel = (UILabel *)[theView viewWithTag:4];
    UILabel *percentTotal =(UILabel *)[theView viewWithTag:5];
    
    NSNumber *totalInnings = [dataSource valueForKeyPath:@"@sum.innings"];
    NSNumber *totalStrikes = [dataSource valueForKeyPath:@"@sum.strikes"];
    NSNumber *totalBalls = [dataSource valueForKeyPath:@"@sum.balls"];
    NSNumber *avgStrikes = [dataSource valueForKeyPath:@"@avg.strikes"];
    NSNumber *avgBalls = [dataSource valueForKeyPath:@"@avg.balls"];
    
    ipTotalLabel.text = [totalInnings description];
    totalTotalLabel.text = [NSString stringWithFormat:@"%i", [totalStrikes intValue] + [totalBalls intValue]];
    strikesTotalLabel.text = [totalStrikes description];
    
    NSNumberFormatter *number = [[NSNumberFormatter alloc]init];
    [number setNumberStyle:NSNumberFormatterPercentStyle];
    float perc = avgStrikes.floatValue/(avgStrikes.floatValue + avgBalls.floatValue);
    percentTotal.text = [number stringFromNumber:[NSNumber numberWithFloat:perc]];    
    return theView;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * theView;
    if (section == 0) {
        NSArray *niblets = [[NSBundle mainBundle] loadNibNamed:@"PitcherStatsHeader" owner:self options:NULL];
        theView = (UIView *)[niblets objectAtIndex:0];
        UIView *pitcherName = [theView viewWithTag:1];
        // Create the path (with only the top-left corner rounded)
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:pitcherName.bounds 
                                                       byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight
                                                             cornerRadii:CGSizeMake(10.0, 10.0)];
        
        // Create the shape layer and set its path
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.frame = pitcherName.bounds;
        maskLayer.path = maskPath.CGPath;
        
        // Set the newly created shape layer as the mask for the image view's layer
        pitcherName.layer.mask = maskLayer;
        
        UITapGestureRecognizer *tp = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerTapped)];
        [theView addGestureRecognizer:tp];
        
    }
    return theView;
}

-(void) headerTapped {
    [self dismissModalViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 30;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 145;
}


@end
