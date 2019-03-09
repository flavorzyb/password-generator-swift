//
//  NSFont.swift
//  password
//
//  Created by 朱彦斌 on 2019/3/10.
//  Copyright © 2019 朱彦斌. All rights reserved.
//

import Cocoa

extension NSFont {
    class func mainBoldFont(size: CGFloat) -> NSFont {
        let font = NSFont(name: "AnonymousPro-Bold", size: size)
        
//        let manager = NSFontManager.shared
//        for name: String in manager.availableFonts {
//            print("font name=====" + name)
//        }
        
        return font ?? NSFont.systemFont(ofSize: size)
    }
    
    class func mainFont(size: CGFloat) -> NSFont {
        let font = NSFont(name: "AnonymousPro", size: size)
        return font ?? NSFont.systemFont(ofSize: size)
    }
}
