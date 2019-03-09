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
        ]
    }
    
    func getViewComponent() -> MainWindowController {
        return  viewComponent as! MainWindowController
    }
    
    override func onRemove() {
        super.onRemove()
        viewComponent = nil
    }
    
    override func handleNotification(_ notification: INotification) {
        switch notification.name {
        case NotificationName.S_MEDIATOR_CLOSE:
            let _ = facade.removeMediator(MediatorName)
        case NotificationName.S_MEDIATOR_MAIN_WINDOW_INIT:
            getViewComponent().showWindow(nil)
        default:
            break
        }
    }
}
