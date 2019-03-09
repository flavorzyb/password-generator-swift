//
//  MainWindowController.swift
//  password
//
//  Created by 朱彦斌 on 2019/3/10.
//  Copyright © 2019 朱彦斌. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
    class func build() -> MainWindowController {
        let window = MainWindow.build()
        let result = MainWindowController(window: window)
        return result
    }
}
