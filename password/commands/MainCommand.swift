//
//  MainCommand.swift
//  password
//
//  Created by 朱彦斌 on 2019/3/9.
//  Copyright © 2019 朱彦斌. All rights reserved.
//
import Cocoa
import PureMVC

class MainCommand: SimpleCommand {
    override func execute(_ notification: INotification) {
        if notification.name == NotificationName.S_COMMAND_STARTUP {
            facade.sendNotification(NotificationName.S_MEDIATOR_CLOSE)
            let controller = MainWindowController.build()
            facade.registerMediator(MainWindowMediator(viewComponent: controller))
            facade.sendNotification(NotificationName.S_MEDIATOR_MAIN_WINDOW_INIT)
        }
    }
}
