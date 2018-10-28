//  Created by Cyril Clément
//  Copyright © 2018 clmntcrl. All rights reserved.

import Foundation
import Swidux

public enum TaskAction: Action {

    case createTask(title: String, parentId: Parent<Id<Task>>)
    case removeTask(id: Id<Task>)
    case toggleTask(id: Id<Task>)
    case completeAllTasks(parentId: Parent<Id<Task>>)
    case retitleTask(id: Id<Task>, title: String)
    case sortTasksByTitle(parentId: Parent<Id<Task>>)
}
