# Videopica

# iOS Video Manager Toolkit

An iOS native application toolkit built in Swift to manage folders, create and delete videos, and play videos either in a loop or sequentially. The app provides functionalities for seamless video playback using AVFoundation.

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
