//
//  IFacade.swift
//  password
//
//  Created by 朱彦斌 on 2019/3/9.
//  Copyright © 2019 朱彦斌. All rights reserved.
//

import Foundation
import PureMVC

extension IFacade {
    public func sendNotification(_ notificationName: String) {
        sendNotification(notificationName, body: nil, type: nil)
    }
    
    public func sendNotification(_ notificationName: String, body: Any?) {
        sendNotification(notificationName, body: body, type: nil)
    }
}
