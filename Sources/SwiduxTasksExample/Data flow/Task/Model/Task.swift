//  Created by Cyril Clément
//  Copyright © 2018 clmntcrl. All rights reserved.

import Foundation

public struct Task: Equatable {

    let parentId: Parent<Id<Task>>
    let id: Id<Task>

    let title: String
    let done: Bool

    let modifiedDate = Date()

    init(title: String, done: Bool = false, parentId: Parent<Id<Task>> = .root) {
        self.parentId = parentId
        id = Id<Task>()
        self.title = title
        self.done = done
    }

    private init(id: Id<Task>, title: String, done: Bool = false, parentId: Parent<Id<Task>> = .root) {
        self.parentId = parentId
        self.id = id
        self.title = title
        self.done = done
    }
}

public extension Task {

    func completed(_ isComplete: Bool) -> Task {
        guard isComplete != done else { return self }
        return Task(id: id, title: title, done: isComplete, parentId: parentId)
    }

    func retitled(_ newTitle: String) -> Task {
        guard newTitle != title else { return self }
        return Task(id: id, title: newTitle, done: done, parentId: parentId)
    }
}
