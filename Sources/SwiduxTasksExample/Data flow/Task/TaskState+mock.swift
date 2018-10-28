//  Created by Cyril Clément
//  Copyright © 2018 clmntcrl. All rights reserved.

import Foundation

extension TaskState {

    public static var mockedState: TaskState = {
        let sleepTask = Task(title: "Sleep")
        return TaskState
            .initialState
            .adding(task: Task(title: "Buy milk"))
            .adding(task: Task(title: "Pay rent"))
            .adding(task: Task(title: "Change tires"))
            .adding(task: sleepTask)
            .adding(task: Task(title: "Find a bed", parentId: .parent(sleepTask.id)))
            .adding(task: Task(title: "Lie down", parentId: .parent(sleepTask.id)))
            .adding(task: Task(title: "Close eyes", parentId: .parent(sleepTask.id)))
            .adding(task: Task(title: "Wait", parentId: .parent(sleepTask.id)))
            .adding(task: Task(title: "Dance"))
    }()
}
