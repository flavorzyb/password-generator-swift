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
        let rect = NSRect(x: 0, y: 0, width: 800, height: 600)
        let result = MainWindow(contentRect: rect, styleMask: .titled, backing: .buffered, defer: false)
        result.styleMask.insert(.closable)
        result.styleMask.insert(.miniaturizable)
//        result.styleMask.insert(.resizable)
        result.contentRect(forFrameRect: rect)
        result.title = NSLocalizedString("HomeTitle", comment: "")
        result.titleVisibility = .visible
        result.titlebarAppearsTransparent = false
        result.delegate = result
        result.center()
        
        return result
    }
    
    func windowShouldClose(_ sender: NSWindow) -> Bool {
        NSApplication.shared.terminate(self)
        return true
    }
}
