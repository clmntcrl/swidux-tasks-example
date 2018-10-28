//  Created by Cyril Clément
//  Copyright © 2018 clmntcrl. All rights reserved.

import Foundation
import Swidux

let taskReducer = Reducer<TaskState> { state, action in
    guard let action = action as? TaskAction else { return }
    switch action {
    case .createTask(let title, let parentId):
        state = state.adding(task: Task(title: title, parentId: parentId))
    case .removeTask(let id):
        state = state.removing(taskWith: id)
    case .toggleTask(let id):
        state = state.toggling(taskWith: id)
    case .completeAllTasks(let parentId):
        state = state.completingAllTasks(with: parentId)
    case .retitleTask(let id, let title):
        state = state.retitling(taskWith: id, title: title)
    case .sortTasksByTitle(let parentId):
        state = state.sortingByTitle(tasksWith: parentId)
    }
}
