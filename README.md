MZFayeClient
===========

Faye Client for iOS. 
This project is an rewritten version of the Library made by pcrawfor there: <https://github.com/pcrawfor/FayeObjC>
Improved capture errors, added subscription blocks, ability to set the extension for channel.
Added auto connection reconnect, and many more...

## How To Use

``` objective-c
self.client = [[MZFayeClient alloc] initWithURL:[NSURL URLWithString:@"ws://localhost:9292/faye"]];

    [self.client subscribeToChannel:@"/server" usingBlock:^(NSDictionary *message) {
        NSLog(@"Server %@",message);
    }];

    [self.client subscribeToChannel:@"/browser" usingBlock:^(NSDictionary *message) {
        NSLog(@"Browser %@",message);
    }];
    
    [self.client connect];
```

## Delagate

```
@protocol MZFayeClientDelegate <NSObject>
@optional

- (void)fayeClient:(MZFayeClient *)client didConnectToURL:(NSURL *)url;
- (void)fayeClient:(MZFayeClient *)client didDisconnectWithError:(NSError *)error;
- (void)fayeClient:(MZFayeClient *)client didUnsubscribeFromChannel:(NSString *)channel;
- (void)fayeClient:(MZFayeClient *)client didSubscribeToChannel:(NSString *)channel;
- (void)fayeClient:(MZFayeClient *)client didFailWithError:(NSError *)error;
- (void)fayeClient:(MZFayeClient *)client didFailDeserializeMessage:(NSDictionary *)message
         withError:(NSError *)error;
- (void)fayeClient:(MZFayeClient *)client didReceiveMessage:(NSDictionary *)messageData fromChannel:(NSString *)channel;

@end
```

## Faye Server
If you can to run a Faye server to test the client, you can find all the information you need there: <http://faye.jcoglan.com/>
You can also run the `faye.rb` file under the `Server` directory:

```
gem install faye thin eventmachine

rackup faye.ru -s thin -E production
```

```
curl http://localhost:9292/faye -d 'message={"channel":"/server", "data":"hello"}'
```

##Dependencies
#### SocketRocket
A conforming WebSocket (RFC 6455) client library maintained by Square, 
<https://github.com/square/SocketRocket>

#### Base64
Objective-C Base64 Additions for NSData and NSString
<https://github.com/ekscrypto/Base64>

## Requirements

MZFayeClient requires either iOS 6.x and above.

## ARC

MZFayeClient uses ARC.

## Contact

[Michal Zaborowski](http://github.com/m1entus)

[Twitter](https://twitter.com/iMientus) 

