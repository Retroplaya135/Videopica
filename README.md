# Videopica

# iOS Video Manager Toolkit

An Open-source, free to use iOS native application toolkit built in Swift to manage folders, create and delete videos, and play videos either in a loop or sequentially. The app provides functionalities for seamless video playback using AVFoundation. Serves as an starting point of media applications. Designed to easily adapt for different UIs, providing basic functoinality of playback framework. 

---
# System Overview
```
+------------------------------+
|        Videopica App         |
|   (iOS Video Manager)        |
+------------------------------+
        |          |          |
        v          v          v
+----------------+  +----------------+  +----------------+
| Folder System |  | Video Manager  |  | Video Playback |
| (Create, Edit)|  | (Import, Delete)|  | (Loop, Seq.)  |
+----------------+  +----------------+  +----------------+
        |          |          |
        v          v          v
+----------------------------------------------------+
|               AVFoundation Framework               |
| (Handles Video Processing & Playback)             |
+----------------------------------------------------+
```

## Features

1. **Folder Management**:
   - Create, delete, and edit folders.

2. **Video Management**:
   - Create and delete videos within folders.

3. **Video Playback**:
   - Play a single video in a loop.
   - Play multiple videos sequentially or in a loop.

---

# Video Playback Flow
```
+-----------------------+
|   User Selects Video  |
+-----------------------+
        |
        v
+-----------------------+
|  PHAssetConverter     |
|  (Convert Video)      |
+-----------------------+
        |
        v
+----------------------------+
|  SingleVideoLooper /       |
|  MultipleVideoLooper       |
|  (Loop or Sequential Play) |
+----------------------------+
        |
        v
+----------------------------+
|    AVFoundation Playback   |
+----------------------------+
```

## Getting Started

### Prerequisites

Ensure you have the following:
- An Apple device running macOS. 
- macOS with Xcode installed.
- iOS device or simulator.
- Basic familiarity with Swift and iOS development.

# Folder & Video Management
```
+--------------------------------------------------+
|                  Folder System                   |
|--------------------------------------------------|
| 🔹 Create, rename, and delete folders            |
| 🔹 Organize videos within folders                |
+--------------------------------------------------+

+--------------------------------------------------+
|                 Video Management                 |
|--------------------------------------------------|
| 🔹 Import videos from Photos or File Picker      |
| 🔹 Delete unwanted videos                        |
| 🔹 Store video metadata for playback preferences |
+--------------------------------------------------+
```

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

# Core Components Architecture

```
+------------------------------------------------+
|            Swift Classes & Functions          |
+------------------------------------------------+
| 🔹 SingleVideoLooper                           |
|   - Plays a single video in a loop            |
| 🔹 MultipleVideoLooper                         |
|   - Plays multiple videos sequentially        |
| 🔹 PHAssetConverter                           |
|   - Converts PHAssets to AVAssets             |
+------------------------------------------------+
```

## Usage

### Folder Management
- Use the app's folder management UI to create, delete, or edit folders to organize your video files.

### Video Management
- Import videos into the app using the photo library or file picker.
- Delete unwanted videos directly from the app interface.
- Add videos to be looped as many times as you want.
- Setting a framework that acts as a plug and play system. 



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

# Video Playback Flow

```
+--------------------------------------+
|      Video Playback Process         |
+--------------------------------------+
        |
        v
+-----------------------+
|  User Selects Video  |
+-----------------------+
        |
        v
+----------------------------+
|  PHAssetConverter          |
|  (Convert PHAsset to AVAsset) |
+----------------------------+
        |
        v
+----------------------------+
|  SingleVideoLooper         |
|  (Loop Playback for One)   |
+----------------------------+
        |
        v
+----------------------------+
|    AVFoundation            |
|  (Handles Playback)        |
+----------------------------+
```

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

# Single Video Playback

```
+-------------------------------+
|  Single Video Playback Flow   |
+-------------------------------+
        |
        v
+------------------------------+
| SingleVideoLooper            |
| - Initializes video          |
| - Starts looping playback    |
| - Resets when finished       |
+------------------------------+
        |
        v
+----------------------------+
|    AVFoundation            |
|  (Executes Playback)       |
+----------------------------+
```
# Multiple Video Playback

```
+-------------------------------+
|  Multiple Video Playback Flow |
+-------------------------------+
        |
        v
+------------------------------+
| MultipleVideoLooper          |
| - Manages multiple videos    |
| - Plays sequentially/loop    |
| - Handles transitions        |
+------------------------------+
        |
        v
+----------------------------+
|    AVFoundation            |
|  (Executes Playback)       |
+----------------------------+
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
- MacOS Catalina and above.

---
```
+---------------------------------+
|       System Requirements       |
+---------------------------------+
| 🔹 iOS 14.0+                    |
| 🔹 Swift 5                      |
| 🔹 AVFoundation Framework       |
| 🔹 Photos Framework             |
| 🔹 MacOS Catalina or later      |
+---------------------------------+
```


# Contributing & Open Source Licensing

```
+------------------------------------------------+
|          Open Source Contribution              |
+------------------------------------------------+
| 🔹 MIT Licensed                                |
| 🔹 Fork & Submit Pull Requests                 |
| 🔹 Modify freely for different UIs             |
+------------------------------------------------+
```



## License

This project is licensed under the [MIT License](https://opensource.org/licenses/MIT). Can be used freely without permission for any type of distribution, granted that assets and project names are changes.

---

## Contributing

Contributions are welcome! Feel free to fork the repository and submit a pull request.

---
