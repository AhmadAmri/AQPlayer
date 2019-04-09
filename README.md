# AQPlayer

iOS Audio player :speaker: uses *AVQueuePlayer* 

![AQPlayer](https://raw.githubusercontent.com/AhmadAmri/AQPlayer/master/screenshots/screenshot_1.png)
![command center skip mode](https://raw.githubusercontent.com/AhmadAmri/AQPlayer/master/screenshots/screenshot_2.png)
![command center next previous mode](https://raw.githubusercontent.com/AhmadAmri/AQPlayer/master/screenshots/screenshot_3.png)

- play background audio and handle **MPRemoteCommandCenter** actions.
- next track, previous track, go to specific track, skip interval (forward/backward), change playback rate, ...

## Usage: 

```swift 
let playerManager = AQPlayerManager.shared
```

**Initialize player items and setup the player manager**

```swift 
var playeritems: [AQPlayerItemInfo] = []

// for each audio file 
let item = AQPlayerItemInfo(id: fileId,
                            url: audioUrl,
                            title: "part_title",
                            albumTitle: "albumTitle",
                            coverImage: nil,
                            startAt: 0)
playeritems.append(item)
```

```swift
playerManager.setup(with: playeritems, startFrom: 0, playAfterSetup: false)
```

**Command Center Art work image can be set during initilization of the item using (URL or UIImage), or through the delegate method _getCoverImage_**

##Insatll
### CocoaPods

To install using [CocoaPods](https://cocoapods.org/pods/AQPlayer), add the following to your Podfile:

```
pod 'AQPlayer'
```


## Example
**Check the Example in the project for full fuctioning demo**

clone the repo, and run `pod install` from the Example directory first.


## Requirements
- swift 4.2
- iOS 11.0+


## License

AQPlayer is available under the MIT license. See the LICENSE file for more info.
