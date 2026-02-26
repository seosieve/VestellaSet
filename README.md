# Vestella Set – Beacon Configuration Automation <img width="30" height="30" src="https://github.com/user-attachments/assets/64157d1d-6be1-4197-b6b8-be6b2eab8f54" />
> Automated Minew iBeacon Configuration via OCR and QR Scanning
<br>
<br>

<div align="center">
  <a href="https://apps.apple.com/us/app/vestellaset/id6753980785">
    <img src="https://github.com/user-attachments/assets/d0bba3c3-62ff-4a7c-b859-9854f5e0702b" alt="Download on the App Store" style="width: 300px">
  </a>
  <br>
  <br>
  <img src="https://img.shields.io/badge/iOS-18.0+-darkgray?logo=apple"/>
  <img src="https://img.shields.io/badge/Swift-v6.1.2-darkgray?logo=swift&logoColor=white"/>
  <img src="https://img.shields.io/badge/SwiftUI-gray?logo=swift&logoColor=white"/>
  <br>
</div>
<br>


## About
<div align="center">
  <img src="https://github.com/user-attachments/assets/7713d085-dfe9-465e-a1eb-bc91dddc89db" width="19%">
  <img src="https://github.com/user-attachments/assets/bee36a3c-5641-412f-80ad-688ad3d23a87" width="19%">
  <img src="https://github.com/user-attachments/assets/c84f8238-ee16-4053-acc4-61cd899931e5" width="19%">
  <img src="https://github.com/user-attachments/assets/d4e37bf4-7751-4350-8de2-687846bb0852" width="19%">
  <img src="https://github.com/user-attachments/assets/d551d1f7-06cf-42df-8ca2-c1492b825cf2" width="19%">
</div>
<br>

`🧩 Simplify and automate multiple beacons to accelerate your workflow.`
> An iOS app that automates beacon writing using **Vision and CoreBluetooth**
- **Project Duration**: 2025.08 - 2025.10 (v1.0.0)
- **Project Tech Stack**: SwiftUI 5.0 + TCA(The Composable Architecture) 1.22.3
- **Hardware & Perception APIs**: CoreBluetooth, Vision, AVFoundation
<br>


## OverView
<div align="center">
  <img src="https://github.com/user-attachments/assets/794b35d1-c08d-4dc5-a915-f55d2c72cd35" width="49.5%">
  <img src="https://github.com/user-attachments/assets/add9fb4e-4041-402f-88a1-89c5bfa2667b" width="49.5%">
</div>
<br>

> Time Comparison Simulation
- **Existing Problem**: Setting up 100–200 beacons with the current manufacturer app is time-consuming, labor-intensive.
- **Approach**: Created an automation app using OCR/QR vision technologies and a customized MinewBeacon SDK.
- **Business Impact**: Achieved a time reduction from 1m 30s to 15s *(≈83% faster)* ✅
<br>


## Architecture
![Architecture](https://github.com/user-attachments/assets/f0cdd00d-7056-4cbd-981f-12e17897447b)
> Hardware-Integrated TCA Architecture
- **Existing Problem**: Managing multiple hardware states (Bluetooth, Camera, Vision) simultaneously leads to race conditions and inconsistent UI updates.
- **Approach**: Implemented TCA's unidirectional data flow with centralized state management for all hardware interactions.
- **Technical Impact**: Eliminated state synchronization issues and achieved 100% predictable hardware state transitions ✅
<br>


## Trouble Shooting
![Trouble Shooting](https://github.com/user-attachments/assets/61656894-c73b-4ef3-9ff9-ca09c0084733)
> Obj-C Delegate → AsyncStream → TCA Action Bridging
- **Existing Problem**: MinewSDK's Obj-C delegate callbacks could not be directly received within TCA's Swift Concurrency-based unidirectional data flow.
- **Approach**: Bridged hardware events to TCA Actions via a 3-step conversion (Delegate → Closure → AsyncStream), monitoring 3 streams concurrently with `async let`.
- **Technical Impact**: SDK callbacks operate as first-class citizens within TCA's unidirectional flow, managing beacon discovery, detection, and connection in a single Reducer ✅

> Step 1. Delegate → Closure (BeaconManager)

`BeaconManager.swift`
```swift
  var onBeaconNotFound: (() -> Void)?
  var onBeaconFound: ((MinewBeacon) -> Void)?
  var onBeaconConnect: ((ConnectionState) -> Void)?

  // MinewBeaconManagerDelegate
  func minewBeaconManager(_ manager: MinewBeaconManager!, didRangeBeacons beacons: [MinewBeacon]!) {
      let foundBeacon = beacons.first { $0.mac == identifier }
      foundBeacon.map { onBeaconFound?($0) } ?? onBeaconNotFound?()
  }
```
`MinewBeaconManagerDelegate.swift`
```swift
  func minewBeaconManager(_ manager: MinewBeaconManager!, didRangeBeacons beacons: [MinewBeacon]!) {
      let foundBeacon = beacons.first { $0.mac == identifier }
      foundBeacon.map { onBeaconFound?($0) } ?? onBeaconNotFound?()
  }
```

> Step 2. Closure → AsyncStream (BeaconClient)

`BeaconClient.swift`
```swift
  var onBeaconNotFound: AsyncStream<Void>
  var onBeaconFound: AsyncStream<MinewBeacon>
  var onBeaconConnect: AsyncStream<ConnectionState>

  self.onBeaconFound = AsyncStream { continuation in
      manager.onBeaconFound = { continuation.yield($0) }
  }
```

> Step 3. AsyncStream → TCA Action (Reducer)

`BeaconEditorFeature.swift`
```swift
  return .run { send in
      async let notFound: Void = {
          for await _ in client.onBeaconNotFound { await send(.increaseTimeoutCounter) }
      }()
      async let found: Void = {
          for await beacon in client.onBeaconFound { await send(.updateBeacon(beacon)) }
      }()
      async let connect: Void = {
          for await state in client.onBeaconConnect { await send(.updateConnectionState(state)) }
      }()
      _ = await (notFound, found, connect)
  }
```
<br>


## Credits

© Minew Technology Co., Ltd. See [MinewSDK](https://github.com/minewdevelop/iOS_Pods_Minew_BeaconAdminSDK) for details.

<a title="Minew" href="https://www.minew.com/product-category/bluetooth-beacon">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://github.com/user-attachments/assets/cc26a7f1-d30c-47f5-832a-329768f8180c">
    <img alt="Minew" src="https://github.com/user-attachments/assets/cc26a7f1-d30c-47f5-832a-329768f8180c" width="160">
  </picture>
</a>

## License

Apache 2.0 © VestellaLab, Inc. See [LICENSE](https://www.apache.org/licenses/LICENSE-2.0.txt) for details.

<a title="VestellaLab" href="https://vestellalab.com">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://github.com/user-attachments/assets/bb4d39e4-01d1-4073-927b-b55fe28be1dd">
    <img alt="VestellaLab" src="https://github.com/user-attachments/assets/bb4d39e4-01d1-4073-927b-b55fe28be1dd" width="320">
  </picture>
</a>
