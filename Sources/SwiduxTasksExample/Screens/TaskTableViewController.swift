//  Created by Cyril Clément
//  Copyright © 2018 clmntcrl. All rights reserved.

import UIKit
import SwiduxRouter

public final class TaskTableViewController: TableViewController, ParametricRoutable {

    public var params: Parent<Id<Task>>! = .root
    private var taskSubscriptionToken: Any!

    public override func viewDidLoad() {
        super.viewDidLoad()

        // Add tootlbar
        navigationController?.isToolbarHidden = false
        setToolbarItems(
            [ UIBarButtonItem(title: "complete all", style: .plain, target: self, action: #selector(completeAll)) ],
            animated: true
        )

        // Subscribe task state changes
        taskSubscriptionToken = store.subscribe(\AppState.task) { [weak self] state in
            DispatchQueue.main.async { self.flatMap {
                // Set view controller title
                if case .parent(let id)? = $0.params {
                    $0.title = state.getTask(with: id).title
                } else {
                    $0.title = "Tasks"
                }
                // Build rows and update data source
                $0.rows = state.getChildrenTasks(with: $0.params).map { task in
                    TaskTableRow(task: task, taskHasChildren: state.hasChidren(forTaskWith: .parent(task.id)))
                }
                $0.tableView.reloadData()
            } }
        }
    }

    // MARK: Toolbar items actions

    @objc private func completeAll() {
        store.dispatch(TaskAction.completeAllTasks(parentId: params))
    }

    @objc private func sort() {
        store.dispatch(TaskAction.sortTasksByTitle(parentId: params))
    }
}
