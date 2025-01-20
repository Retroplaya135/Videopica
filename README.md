# Videopica

# iOS Video Manager Toolkit

An Open-source, free to use iOS native application toolkit built in Swift to manage folders, create and delete videos, and play videos either in a loop or sequentially. The app provides functionalities for seamless video playback using AVFoundation. Serves as an starting point of media applications. Designed to easily adapt for different UIs, providing basic functoinality of playback framework. 

---

## Features

1. **Folder Management**:
   - Create, delete, and edit folders.

2. **Video Management**:
   - Create and delete videos within folders.

3. **Video Playback**:
   - Play a single video in a loop.
   - Play multiple videos sequentially or in a loop.

---

## Getting Started

### Prerequisites

Ensure you have the following:
- An Apple device running macOS. 
- macOS with Xcode installed.
- iOS device or simulator.
- Basic familiarity with Swift and iOS development.


### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your-repo/ios-video-manager-toolkit.git
   cd ios-video-manager-toolkit
   ```

2. Open the project in Xcode:
   ```bash
   open VideoManager.xcodeproj
   ```

3. Build and run the app on your device or simulator.

---

## Usage

### Folder Management
- Use the app's folder management UI to create, delete, or edit folders to organize your video files.

### Video Management
- Import videos into the app using the photo library or file picker.
- Delete unwanted videos directly from the app interface.



### Video Playback

#### Single Video Playback
- Play a single video in a loop using the `SingleVideoLooper` class:
  ```swift
  let videoLooper = SingleVideoLooper(asset: yourAVAsset)
  videoLooper.start(in: self, andloop: true)
  ```


#### Multiple Video Playback
- Play multiple videos sequentially or in a loop using the `MultipleVideoLooper` class:
  ```swift
  let multipleLooper = MultipleVideoLooper(assetItems: [asset1, asset2, asset3])
  multipleLooper.start(in: self, and: true)
  ```



## Code Overview

### Core Components

1. **SingleVideoLooper**:
   - Handles playback of a single video in a loop.
   - Automatically resets the video to the beginning upon completion.

2. **MultipleVideoLooper**:
   - Handles playback of multiple videos.
   - Supports both sequential playback and looping.

3. **PHAssetConverter**:
   - Converts `PHAsset` objects into `AVAsset` for use with video playback.
   - Generates thumbnails for video previews.



## Example Code

### Single Video Playback
```swift
let videoLooper = SingleVideoLooper(asset: yourAVAsset)
videoLooper.start(in: self, andloop: true)
```

### Multiple Video Playback
```swift
let multipleLooper = MultipleVideoLooper(assetItems: [asset1, asset2, asset3])
multipleLooper.start(in: self, and: true)
```



### Convert PHAsset to AVAsset
```swift
let assetConverter = PHAssetConverter()
assetConverter.getAVAsset(yourPHAsset) { avAsset, thumbnail in
    // Use avAsset and thumbnail as needed
}
```

---

## Requirements

- iOS 14.0+.
- Swift 5.
- AVFoundation and Photos frameworks.

---



## License

This project is licensed under the [MIT License](https://opensource.org/licenses/MIT).

---

## Contributing

Contributions are welcome! Feel free to fork the repository and submit a pull request.

---
