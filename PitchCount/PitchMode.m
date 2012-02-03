//
//  PitchMode.m
//  
//
//  Created by Claude Keswani on 1/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PitchMode.h"

@implementation PitchMode
@synthesize pitcherInningsField;


#pragma mark navigation

-(IBAction)showGuidelines{
    [self.view removeFromSuperview];
    [appDelegate.viewController ShowGuidline];
}

-(IBAction)showStatistics{
    [self.view removeFromSuperview];
    [appDelegate.viewController ShowStats];
}

-(IBAction)showHome{
    [self.view removeFromSuperview];
    [appDelegate.viewController ShowHome];
}

#pragma mark -
#pragma mark alerts
-(void)addNewPitcherAlert{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Do you want to add another pitcher ?" message:@"\n\n\n" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    alert.tag = 2;
    [alert show];
    [alert release];
}

-(void)savePitcherAlert{
    NSString *message = [NSString stringWithFormat:@"How many innings did %@ pitch ?",appDelegate.pInfo.p_name];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:message message:@"\n\n\n"
                                                   delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",nil) otherButtonTitles:NSLocalizedString(@"Save",nil), nil];
    alert.tag = 1;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12,40,260,25)];
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.shadowColor = [UIColor blackColor];
    label.shadowOffset = CGSizeMake(0,-1);
    label.textAlignment = UITextAlignmentCenter;
    [alert addSubview:label];
    
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"passwordfield" ofType:@"png"]]];
    image.frame = CGRectMake(11,79,262,31);
    [alert addSubview:image];
    
    UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(16,83,252,25)];
    field.font = [UIFont systemFontOfSize:18];
    field.backgroundColor = [UIColor whiteColor];
    field.keyboardType = UIKeyboardTypeNumberPad;
    
    field.textAlignment = UITextAlignmentCenter;
    
    self.pitcherInningsField = field;
    
    [field becomeFirstResponder];
    [alert addSubview:field];
    
    [alert setTransform:CGAffineTransformMakeTranslation(0,-30)];
    [alert show];
    [alert release];
    [field release];
    [image release];
    [label release];
}

#pragma mark -
#pragma mark stike and ball count
-(void)strikePlus{
    strikes++;
    
    pitchCount = strikes+balls;
    if(weekltLimit-pitchCount<=15){
        alertLabel.alpha=1;
        alertImage.alpha=1;
    }else{
        alertLabel.alpha=0;
        alertImage.alpha=0;
    }
    pitchCountLabel.text=[NSString stringWithFormat:@"%d",pitchCount];
    float percent = ((float)strikes/(float)pitchCount)*100;
    strikesLabel.text = [NSString stringWithFormat:@"%d (%.2f%%)",strikes,percent]; 
    ballsLabel.text=[NSString stringWithFormat:@"%d",balls]; 
    
    int limit = weekltLimit - pitchCount;
    NSString *limitString = [NSString stringWithFormat:@"%d Pitches away from recommended maximum",limit];
    alertLabel.text = limitString;
    
}

-(IBAction)strikeMinus{
    if(strikes==0){
        alertLabel.alpha=0;
        alertImage.alpha=0;
        return;
    }
    
    strikes--;
    pitchCount = strikes+balls;
    if(weekltLimit-pitchCount<=15){
        alertLabel.alpha=1;
        alertImage.alpha=1;
    }else{
        alertLabel.alpha=0;
        alertImage.alpha=0;
    }
    pitchCountLabel.text=[NSString stringWithFormat:@"%d",pitchCount];
    float percent = ((float)strikes/(float)pitchCount)*100;
    strikesLabel.text = [NSString stringWithFormat:@"%d (%.2f%%)",strikes,percent]; 
    ballsLabel.text=[NSString stringWithFormat:@"%d",balls]; 
    
    int limit = weekltLimit - pitchCount;
    NSString *limitString = [NSString stringWithFormat:@"%d Pitches away from recommended maximum",limit];
    alertLabel.text = limitString;
}



-(IBAction)ballPlus{
    balls++;
    
    pitchCount = strikes+balls;
    if(weekltLimit-pitchCount<=15){
        alertLabel.alpha=1;
        alertImage.alpha=1;
    }else{
        alertLabel.alpha=0;
        alertImage.alpha=0;
    }
    pitchCountLabel.text=[NSString stringWithFormat:@"%d",pitchCount]; 
    float percent = ((float)strikes/(float)pitchCount)*100;
    strikesLabel.text = [NSString stringWithFormat:@"%d (%.2f%%)",strikes,percent]; 
    ballsLabel.text=[NSString stringWithFormat:@"%d",balls]; 
    
    int limit = weekltLimit - pitchCount;
    NSString *limitString = [NSString stringWithFormat:@"%d Pitches away from recommended maximum",limit];
    alertLabel.text = limitString;
}
-(IBAction)ballMinus{
    if(balls==0){
        alertLabel.alpha=0;
        alertImage.alpha=0; 
        return;
    }
    
    balls--;
    pitchCount = strikes+balls;
    if(weekltLimit-pitchCount<=15){
        alertLabel.alpha=1;
        alertImage.alpha=1;
    }else{
        alertLabel.alpha=0;
        alertImage.alpha=0;
    }
    pitchCountLabel.text=[NSString stringWithFormat:@"%d",pitchCount];
    float percent = ((float)strikes/(float)pitchCount)*100;
    strikesLabel.text = [NSString stringWithFormat:@"%d (%.2f%%)",strikes,percent]; 
    ballsLabel.text=[NSString stringWithFormat:@"%d",balls];
    
    int limit = weekltLimit - pitchCount;
    NSString *limitString = [NSString stringWithFormat:@"%d Pitches away from recommended maximum",limit];
    alertLabel.text = limitString;
}

-(IBAction)done{
    [self savePitcherAlert];
}
-(IBAction)reset{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"All your unsaved data \n will be lost !" message:@"Are you sure ?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    alert.tag = 3;
    
    [alert show];
    [alert release];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    NSLog(@"alertView=%d",alertView.tag);
    if (alertView.tag == 1) {
        //Add innings alert
        if( buttonIndex == 1){
            //Save Button Click
            
            appDelegate.pInfo.p_strikes = [NSNumber numberWithInteger:[[[strikesLabel.text componentsSeparatedByString:@"("] objectAtIndex:0] integerValue]];
            appDelegate.pInfo.p_balls = [NSNumber numberWithInteger:[ballsLabel.text integerValue]];
            appDelegate.pInfo.p_innings = [NSNumber numberWithInteger:[self.pitcherInningsField.text integerValue]];
            
            int pitchCount1 = [strikesLabel.text intValue]+[ballsLabel.text intValue];
            float percent = ((float)[strikesLabel.text intValue]/(float)pitchCount1)*100;
            appDelegate.pInfo.p_percent = [NSNumber numberWithFloat:percent];            
            [self addNewPitcherAlert];
            
        }
    }else if (alertView.tag == 2) {
        //Add another pitcher alert
        [[appDelegate allPitchersInfo] addObject:appDelegate.pInfo];
        [appDelegate save];
        appDelegate.pInfo = [appDelegate getNewPitcher];
        //
        nameLabel.text=@"";
        pitchCountLabel.text=@"0";
        strikesLabel.text=@"0";
        ballsLabel.text=@"0";
        alertLabel.text=@"";
        alertImage.alpha=0;
        //
        pitchCount=0;
        strikes=0;
        balls=0;
        
        if( buttonIndex == 1){
            //NO Button Click
            NSLog(@"ShowStats view");
            [self.view removeFromSuperview];
            [[appDelegate viewController] showStatistics];
            
        }else{
            //YES Button Click
            NSLog(@"ShowHome view");
            [self.view removeFromSuperview];
            [[appDelegate viewController] showHome];
            [[[appDelegate viewController] objHome] createNewPitcher];
            
        }
    }else if (alertView.tag == 3) {
        //Reset alert
        if( buttonIndex != 1){
            //YES Button Click
            pitchCountLabel.text=@"0";
            strikesLabel.text=@"0";
            ballsLabel.text=@"0";
            alertLabel.text=@"";
            alertImage.alpha=0;
            pitchCount=0;
            strikes=0;
            balls=0;
        }
    }
    
}

@end
