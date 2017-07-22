//
//  Battery.swift
//  Meniny
//
//  Created by Meniny on 15/8/8.
//  Copyright (c) 2013 Meniny. All rights reserved.
//
//  Powerd by Meniny.
//  See https://meniny.cn/ for more informations.
//

import Foundation
import UIKit

public extension UIDeviceBatteryState {
    /// Battery State in String
    public var stringValue: String {
        switch self {
        case .unknown:
            return "Unknown"
        case .unplugged:
            return "Unplugged"
        case .charging:
            return "Charging"
        default:
            return "Full"
        }
    }
}

public extension Float {
    public func percentString() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 1
        return formatter.string(for: self)
    }
}

/// Battery Monitor
open class Battery {
    
    public typealias State = UIDeviceBatteryState
    public typealias StateClosure = (_ level: Battery.State) -> Swift.Void
    public typealias Level = Float
    public typealias LevelClosure = (_ level: Battery.Level) -> Swift.Void
    
    /// Monitor, Singleton
    open static let mointor = Battery()
    
    /// is Battery Monitoring Enabled
    open var isEnabled: Bool = false {
        didSet {
            UIDevice.current.isBatteryMonitoringEnabled = isEnabled
        }
    }
    
    /// Battery Level (Float Number Value)
    open var batteryLevel: Battery.Level {
        return UIDevice.current.batteryLevel
    }
    
    /// Battery Level (String Value)
    open var batteryLevelString: String {
        let l = batteryLevel
        if l <= 0 {
            return "Unknown"
        }
        return l.percentString() ?? "Unknown"
    }
    
    /// Battery State (Enumeration Value)
    open var batteryState: Battery.State {
        return UIDevice.current.batteryState
    }
    
    /// Battery State (String Value)
    open var batteryStateString: String {
        return UIDevice.current.batteryState.stringValue
    }
    
    /// Battery Level Changed Action
    open var onBatteryLevelChanged: Battery.LevelClosure?
    /// Battery State Changed Action
    open var onBatteryStateChanged: Battery.StateClosure?
    
    @objc
    private func batteryLevelChanged(_ notification: Notification) {
        onBatteryLevelChanged?(batteryLevel)
    }
    
    @objc
    private func batteryStateChanged(_ notification: Notification) {
        onBatteryStateChanged?(batteryState)
    }
    /// Enable Battery Monitoring
    open class func startMonitor() {
        Battery.mointor.start()
    }
    
    /// Enable Battery Monitoring
    open func start() {
        setEnabled(true) { [weak self] () in
            self?.addObserver()
        }
    }
    
    /// Disable Battery Monitoring
    open class func stopMonitor() {
        Battery.mointor.stop()
    }
    
    /// Disable Battery Monitoring
    open func stop() {
        setEnabled(false) { [weak self] () in
            self?.removeObserver()
        }
    }
    
    /// Set Battery Monitoring Enable/Disable with Completion Action
    open func setEnabled(_ enabled: Bool, completion: (() -> Swift.Void)?) {
        isEnabled = enabled
        completion?()
    }
    
    internal func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(batteryLevelChanged(_:)), name: NSNotification.Name.UIDeviceBatteryLevelDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(batteryStateChanged(_:)), name: NSNotification.Name.UIDeviceBatteryStateDidChange, object: nil)
    }
    
    internal func removeObserver() {
        NotificationCenter.default.removeObserver(self)
    }

    deinit {
        stop()
    }

}
