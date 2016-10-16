//
//  MZViewController.m
//  MZFayeClient
//
//  Created by Michał Zaborowski on 12.12.2013.
//  Copyright (c) 2013 Michał Zaborowski. All rights reserved.
//

#import "MZViewController.h"
#import <MZFayeClient.h>

@interface MZViewController () <MZFayeClientDelegate>
@property (nonatomic, strong) MZFayeClient *client;
@end

@implementation MZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.client = [[MZFayeClient alloc] initWithURL:[NSURL URLWithString:@"ws://localhost:9292/faye"]];

    [self.client subscribeToChannel:@"/server" success:nil failure:nil receivedMessage:^(NSDictionary *message, NSDictionary *extension) {
        NSLog(@"Server message %@,\nextension: %@",message,extension);
    }];

//    [self.client subscribeToChannel:@"/browser" usingBlock:^(NSDictionary *message) {
//        NSLog(@"Browser %@",message);
//    }];


//    [self.client.extensions setObject:@"test" forKey:@"test"];
//    [self.client setExtension:@{@"auth_token": @"test"} forChannel:@"/browser"];

    self.client.delegate = self;


}

- (IBAction)connect:(id)sender {
    [self.client connect:nil failure:nil];
}

- (IBAction)disconnect:(id)sender {
    [self.client disconnect:nil failure:nil];
}

- (IBAction)send:(id)sender
{
    [self.client sendMessage:@{@"text": self.messageTextField.text} toChannel:@"/browser" success:nil failure:nil];
}

- (void)fayeClient:(MZFayeClient *)client didConnectToURL:(NSURL *)url extension:(NSDictionary *)extension
{
    NSLog(@"%@\n%@",url,extension);
}
- (void)fayeClient:(MZFayeClient *)client didDisconnectWithError:(NSError *)error
{
    NSLog(@"%@",error);
}
- (void)fayeClient:(MZFayeClient *)client didUnsubscribeFromChannel:(NSString *)channel extension:(NSDictionary *)extension
{
    NSLog(@"%@\n%@",channel,extension);
}
- (void)fayeClient:(MZFayeClient *)client didSubscribeToChannel:(NSString *)channel extension:(NSDictionary *)extension
{
    NSLog(@"%@\n%@",channel,extension);
}
- (void)fayeClient:(MZFayeClient *)client didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
}
- (void)fayeClient:(MZFayeClient *)client didFailDeserializeMessage:(NSDictionary *)message
         withError:(NSError *)error
{
    NSLog(@"%@",error);
}
- (void)fayeClient:(MZFayeClient *)client didReceiveMessage:(NSDictionary *)messageData fromChannel:(NSString *)channel extension:(NSDictionary *)extension
{
    NSLog(@"%@\n%@",channel,extension);
}


@end
