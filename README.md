# COBALT Mobile App

Ayush Agarwal*, Ansh Gandhi*, Jeremy A. Collins, Omar Rayyan, Aryan Sarswat, Ranjani Koushik, Masoud Moghani, Ajay Mandlekar, Animesh Garg

[![Website](https://img.shields.io/badge/Website-cobalt--teleop.github.io-0a84ff?logo=google-chrome&logoColor=white&style=flat)](https://cobalt-teleop.github.io/)
<!-- [![arXiv](https://img.shields.io/badge/arXiv-2506.14198-b31b1b.svg?logo=arXiv&logoColor=white&style=flat)](https://arxiv.org/abs/2506.14198) -->
[![Python](https://img.shields.io/badge/Python-3.10-3776AB?logo=python&logoColor=white&style=flat)](https://www.python.org)
![license](https://img.shields.io/github/license/pairlab/AMPLIFY?style=flat&cacheSeconds=1)

This repo contains the official mobile application for COBALT: Crowdsourcing Robot Learning via Cloud-Based Teleoperation with Smartphones. The COBALT mobile app connects to a running COBALT server and allows users to remotely teleoperate a robot from a smartphone.

## Related Links

* [Project website](https://cobalt-teleop.github.io/)
* [COBALT repo](https://github.com/pairlab/cobalt/)
* [COBALT Isaac Lab repo](https://github.com/pairlab/cobalt-isaaclab/)

## Quick Start

### Prerequisites

Install the following tools required for Flutter app development:

* [Flutter SDK](https://docs.flutter.dev/get-started/install)
* [Android Studio](https://developer.android.com/studio) to build for Android
* [Xcode](https://developer.apple.com/xcode/) to build for iOS
* A physical Android or iOS device

### Installation

#### 1. Clone the repository

```bash
git clone https://github.com/pairlab/cobalt-mobile-app.git
cd cobalt-mobile-app
```

#### 2. Install Flutter dependencies

```bash
flutter pub get
```

#### 3. Verify available devices

```bash
flutter devices
```

You should see at least one connected Android or iOS device.

#### 4. Set up device for installation

**Android**

Enable USB debugging on your Android phone:

1. Open **Settings > About phone**.
2. Tap **Build number** several times to enable Developer Options.
3. Open **Developer Options**.
4. Enable **USB debugging**.
5. Connect the phone over USB.

**iOS**

For iOS development, use macOS with Xcode installed.

1. Open the iOS project in Xcode if signing setup is needed:

```bash
open ios/Runner.xcworkspace
```

2. Select a development team under **Signing & Capabilities**.
3. Connect your iPhone.

#### 5. Install the app

```bash
flutter run --release
```

---

**Last Updated:** May 15, 2026
