//
//  MainWindow.swift
//  password
//
//  Created by 朱彦斌 on 2019/3/10.
//  Copyright © 2019 朱彦斌. All rights reserved.
//

import Cocoa

class MainWindow: NSWindow, NSWindowDelegate {
    class func build() -> MainWindow {
        let result = MainWindow(contentRect: AppConfig.windowRect, styleMask: .titled, backing: .buffered, defer: false)
        result.styleMask.insert(.closable)
        result.styleMask.insert(.miniaturizable)
//        result.styleMask.insert(.resizable)
        result.title = NSLocalizedString("HomeTitle", comment: "")
        result.titleVisibility = .visible
        result.titlebarAppearsTransparent = false
        result.delegate = result
        result.center()
        
        let viewController = MainViewController()
        result.contentViewController = viewController
        
        return result
    }
    
    func windowShouldClose(_ sender: NSWindow) -> Bool {
        NSApplication.shared.terminate(self)
        return true
    }
}
