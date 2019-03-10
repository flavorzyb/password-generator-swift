//
//  MainWindowMediator.swift
//  password
//
//  Created by 朱彦斌 on 2019/3/10.
//  Copyright © 2019 朱彦斌. All rights reserved.
//

import Foundation
import PureMVC

class MainWindowMediator: Mediator {
    let MediatorName = "MainWindowMediator"
    
    init(viewComponent: MainWindowController) {
        super.init(mediatorName: MediatorName, viewComponent: viewComponent)
    }
    
    override func listNotificationInterests() -> [String] {
        return [
            NotificationName.S_MEDIATOR_CLOSE,
            NotificationName.S_MEDIATOR_MAIN_WINDOW_INIT,
            NotificationName.S_MEDIATOR_MAIN_WINDOW_EXIT,
        ]
    }
    
    func getViewComponent() -> MainWindowController {
        return  viewComponent as! MainWindowController
    }

    override func handleNotification(_ notification: INotification) {
        switch notification.name {
        case NotificationName.S_MEDIATOR_CLOSE:
            getViewComponent().close()
            let _ = facade.removeMediator(MediatorName)
        case NotificationName.S_MEDIATOR_MAIN_WINDOW_INIT:
            getViewComponent().showWindow(nil)
        case NotificationName.S_MEDIATOR_MAIN_WINDOW_EXIT:
            let controller = getViewComponent()
            controller.close()
            let _ = facade.removeMediator(MediatorName)
            controller.terminate()
        default:
            break
        }
    }
}
