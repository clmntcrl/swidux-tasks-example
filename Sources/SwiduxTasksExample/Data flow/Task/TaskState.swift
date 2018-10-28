//  Created by Cyril Clément
//  Copyright © 2018 clmntcrl. All rights reserved.

import Foundation

public struct TaskState: Equatable {

    public var tasks: [Id<Task>: Task]
    public var tree: [Parent<Id<Task>>: [Id<Task>]]

    static var initialState: TaskState {
        return TaskState(tasks: [:], tree: [.root: []])
    }

    private init(tasks: [Id<Task>: Task], tree: [Parent<Id<Task>>: [Id<Task>]]) {
        self.tasks = tasks
        self.tree = tree
    }
}

// MARK: Accessors

public extension TaskState {

    func getTask(with id: Id<Task>) -> Task {
        guard let task = tasks[id] else {
            fatalError("❌ Cannot get task with id \(id)")
        }
        return task
    }

    func getChildrenTasks(with parentId: Parent<Id<Task>>) -> [Task] {
        return tree[parentId, default: []]
            .map(getTask)
    }

    func hasChidren(forTaskWith parentId: Parent<Id<Task>>) -> Bool {
        return tree[parentId] != .none
    }
}

// MARK: Mutate

extension TaskState {

    private func ensuringAncestorsCompletionConsistency(forTasksWith parentId: Parent<Id<Task>>) -> TaskState {
        guard case .parent(let id) = parentId else {
            return self // Stop if parent is root
        }
        // Compute completion regarding children completion
        let parent = getTask(with: id)
        let completion = getChildrenTasks(with: parentId)
            .reduce(true) { $0 && $1.done }
        // Continue state mutation only if completion need to be update for parent
        guard parent.done != completion else {
            return self
        }
        let nextState = TaskState(
            tasks: tasks.updatingValue(parent.completed(completion), forKey: id),
            tree: tree
        )
        // Recursively ensure completion consistency for parent ancestors
        return nextState.ensuringAncestorsCompletionConsistency(forTasksWith: parent.parentId)
    }

    func adding(task: Task) -> TaskState {
        let brothersAndSistersIds = tree[task.parentId, default: []]
        // Add task
        let nextState = TaskState(
            tasks: tasks.updatingValue(task, forKey: task.id),
            tree: tree.updatingValue(brothersAndSistersIds + [task.id], forKey: task.parentId)
        )
        // Ensure ancestors completion consistency
        return nextState.ensuringAncestorsCompletionConsistency(forTasksWith: task.parentId)
    }

    func removing(taskWith id: Id<Task>) -> TaskState {
        let task = getTask(with: id)
        // Cascading delete task
        var nextState = cascadingDeleteChildren(forTaskWith: id)
        // Ensure parent children consistency
        let brothersAndSistersIds = nextState.tree[task.parentId]!.filter { $0 != id }
        nextState = TaskState(
            tasks: nextState.tasks,
            tree: brothersAndSistersIds.isEmpty
                ? nextState.tree.removingValue(forKey: task.parentId)
                : nextState.tree.updatingValue(brothersAndSistersIds, forKey: task.parentId)
        )
        // Ensure ancestors completion consistency
        return nextState.ensuringAncestorsCompletionConsistency(forTasksWith: task.parentId)
    }

    /// The aim of this function is to optimise deletion of children by not checking state
    /// consistency. So caller need to:
    ///   - ensure consistency in the completion of ancestors for the task designated by the passed id
    ///   - update task parent children list
    ///
    /// Return inconsistent state. ⚠️
    private func cascadingDeleteChildren(forTaskWith id: Id<Task>) -> TaskState {
        let nextState = tree[.parent(id), default: []]
            .reduce(self) { $0.cascadingDeleteChildren(forTaskWith: $1) }
        return TaskState(
            tasks: nextState.tasks.removingValue(forKey: id),
            tree: nextState.tree.removingValue(forKey: .parent(id))
        )
    }

    func toggling(taskWith id: Id<Task>) -> TaskState {
        let task = getTask(with: id)
        return cascadingCompleteChildren(forTaskWith: id, completion: !task.done)
            .ensuringAncestorsCompletionConsistency(forTasksWith: task.parentId)
    }

    func completingAllTasks(with parentId: Parent<Id<Task>>) -> TaskState {
        return tree[parentId, default: []]
            .reduce(self) { $0.cascadingCompleteChildren(forTaskWith: $1, completion: true) }
            .ensuringAncestorsCompletionConsistency(forTasksWith: parentId)
    }

    /// Purpose of this function is to optimise completion of children by not checking state consistency. Caller need to ensure
    /// consistency in the completion of ancestors for the task designated by the passed id.
    ///
    /// Return inconsistent state. ⚠️
    private func cascadingCompleteChildren(forTaskWith id: Id<Task>, completion: Bool) -> TaskState {
        let nextState = tree[.parent(id), default: []]
            .reduce(self) {
                getTask(with: $1).done != completion
                    ? $0.cascadingCompleteChildren(forTaskWith: $1, completion: completion)
                    : $0
            }
        let task = getTask(with: id)
        return TaskState(
            tasks: nextState.tasks.updatingValue(task.completed(completion), forKey: id),
            tree: nextState.tree
        )
    }

    func retitling(taskWith id: Id<Task>, title: String) -> TaskState {
        let retitledTask = getTask(with: id)
            .retitled(title)
        return TaskState(
            tasks: tasks.updatingValue(retitledTask, forKey: id),
            tree: tree
        )
    }

    func sortingByTitle(tasksWith parentId: Parent<Id<Task>>) -> TaskState {
        let sortedChildrenIds = getChildrenTasks(with: parentId)
            .sorted(by: Task.byTitle)
            .map { $0.id }
        return TaskState(
            tasks: tasks,
            tree: tree.updatingValue(sortedChildrenIds, forKey: parentId)
        )
    }
}
