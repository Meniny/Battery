//
//  ViewController.swift
//  Sample
//
//  Created by Meniny on 2017-07-22.
//  Copyright © 2017年 Meniny. All rights reserved.
//

import UIKit
import Battery

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Battery.mointor.onBatteryStateChanged = { (state) in
            print("State: " + state.stringValue)
        }
        
        Battery.mointor.onBatteryLevelChanged = { (level) in
            print("Level: " + (level.percentString() ?? "Unknown"))
        }
        
        Battery.mointor.start()
    }
    
    deinit {
        Battery.mointor.stop()
    }
}

