//
//  ViewController.h
//  Tap Me!
//
//  Created by Mac 2 on 13/02/14.
//  Copyright (c) 2014 Intuzion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@interface ViewController : UIViewController <UIAlertViewDelegate>

@property IBOutlet UILabel *timeLabel;
@property IBOutlet UILabel *scoreLabel;

@property NSInteger count;
@property NSInteger seconds;
@property NSTimer *timer;

@property AVAudioPlayer *backgroundMusic;
@property AVAudioPlayer *buttonBeep;
@property AVAudioPlayer *secondBeep;

-(IBAction)tapButton;
-(IBAction)resetButton;
-(void) setupGame;
-(void) decrementTime;

@end
