//
// Created by 朱彦斌 on 2019-01-10.
// Copyright (c) 2019 朱彦斌. All rights reserved.
//

import Foundation
import PureMVC

class AppFacade {
    private static let instance = AppFacade()
    private var facade: IFacade!

    class func getInstance() -> AppFacade {
        return instance
    }

    private init() {
        facade = Facade.getInstance { Facade() }
    }

    func startUp() {
        initCommand()
        initProxy()

        sendNotification(NotificationName.S_COMMAND_STARTUP)
    }

    private func initCommand() {
        let mainCommand = MainCommand()
        facade.registerCommand(NotificationName.S_COMMAND_STARTUP) { mainCommand }
    }

    private func initProxy() {
    }

    func sendNotification(_ notificationName: String) {
        sendNotification(notificationName, body: nil, type: nil)
    }

    func sendNotification(_ notificationName: String, body: Any?) {
        sendNotification(notificationName, body: body, type: nil)
    }

    func sendNotification(_ notificationName: String, body: Any?, type: String?) {
        facade.sendNotification(notificationName, body: body, type: type)
    }
}
