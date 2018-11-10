//  Created by Cyril Clément
//  Copyright © 2018 clmntcrl. All rights reserved.

import Foundation
import SwiduxRouter

public extension Route {

    public static func tasks(withParentTaskId parent: Parent<Id<Task>>) -> Route {
        return  Route(type: TaskTableViewController.self, routeParam: parent)
    }
}
