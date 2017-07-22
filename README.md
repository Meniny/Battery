# Battery

`Battery` is an easy-to-use class to monitor battery status on iOS.

> Also see [MXBatteryMointor](https://github.com/Meniny/MXBatteryMointor-in-Objective-C) for Objective-C version.

## Installation

#### CocoaPods

```
pod 'Battery'
```

## Usage

```swift
import Battery
```

```swift
Battery.mointor.onBatteryStateChanged = { (state) in
  print("State: " + state.stringValue)
}

Battery.mointor.onBatteryLevelChanged = { (level) in
  print("Level: " + (level.percentString() ?? "Unknown"))
}
Battery.mointor.start()
```

```swift
let level = Battery.mointor.batteryLevel
let state = Battery.mointor.batteryState
```

```swift
let levelString = Battery.mointor.batteryLevelString
let stateString = Battery.mointor.batteryStateString
```

```swift
Battery.monitor.stop()
```
