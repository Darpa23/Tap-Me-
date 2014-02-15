//
//  ViewController.m
//  Tap Me!
//
//  Created by Mac 2 on 13/02/14.
//  Copyright (c) 2014 Intuzion. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize scoreLabel=scoreLabel;
@synthesize timeLabel=timeLabel;
@synthesize seconds=seconds;
@synthesize count=count;
@synthesize timer=timer;
@synthesize buttonBeep=buttonBeep;
@synthesize secondBeep=secondBeep;
@synthesize backgroundMusic=backgroundMusic;



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_tile.png"]];
    scoreLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"field_score.png"]];
    timeLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"field_time.png"]];
    buttonBeep = [self setupAudioPlayerWithFile:@"ButtonTap" type:@"wav"];
    secondBeep = [self setupAudioPlayerWithFile:@"SecondBeep" type:@"wav"];
    backgroundMusic = [self setupAudioPlayerWithFile:@"HallOfTheMountainKing" type:@"mp3"];

    [self setupGame];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapButton
{
    count++;
    if(count==1)
    {
        //The next 2 lines are written because 30 persists for 2 seconds rather than 1 sec.
        //To avoid that timer is set to 29 when the tap button is clicked.
        seconds=9;
        timeLabel.text=[NSString stringWithFormat:@"Time: %lu", seconds];
        
        timer=[NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(decrementTime) userInfo:nil repeats:YES];
    }
    scoreLabel.text=[NSString stringWithFormat:@"Score\n%lu", count];
    [buttonBeep setVolume:0.1];
    [buttonBeep play];
}

- (void)setupGame
{
    seconds=10;
    count=0;
    timeLabel.text=[NSString stringWithFormat:@"Time: %lu", seconds];
    scoreLabel.text=[NSString stringWithFormat:@"Score\n%lu",count];
    [backgroundMusic setVolume:0.01];
    [backgroundMusic play];
}

- (void)decrementTime
{
    seconds--;
    timeLabel.text=[NSString stringWithFormat:@"Time: %lu", seconds];
    [secondBeep play];
    if(seconds==0)
    {
        [timer invalidate];
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Time Up!" message:[NSString stringWithFormat:@"Your score is %lu.",count] delegate:self cancelButtonTitle:@"Play Again" otherButtonTitles:nil];
        [alert setTintColor:[UIColor yellowColor]];
        [alert setBackgroundColor:[UIColor blueColor]];
        
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self setupGame];
}

- (IBAction)resetButton
{
    [timer invalidate];
    [self setupGame];
}

- (AVAudioPlayer *)setupAudioPlayerWithFile:(NSString *)file type:(NSString *)type
{
    // 1
    NSString *path = [[NSBundle mainBundle] pathForResource:file ofType:type];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    // 2
    NSError *error;
    
    // 3
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    // 4
    if (!audioPlayer) {
        NSLog(@"%@",[error description]);
    }
    
    // 5
    return audioPlayer;
}


@end
