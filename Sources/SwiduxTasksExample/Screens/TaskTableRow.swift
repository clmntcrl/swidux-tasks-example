//  Created by Cyril Clément
//  Copyright © 2018 clmntcrl. All rights reserved.

import UIKit
import SwiduxRouter

struct TaskTableRow {

    let task: Task
    let taskHasChildren: Bool
}

extension TaskTableRow: TableRow {

    var cellDescriptor: TableCellDescriptor {
        return TableCellDescriptor { (cell: UITableViewCell) in
            cell.textLabel?.text = (self.task.done ? "☑︎" : "☐") + "\t" + self.task.title
            cell.textLabel?.textColor = self.task.done
                ? .lightGray
                : .black

            cell.accessoryType = self.taskHasChildren
                ? .detailDisclosureButton
                : .none
        }
    }

    func didSelect(on viewController: UIViewController) {
        store.dispatch(TaskAction.toggleTask(id: task.id))
    }

    func tapAccessoryButton(on tableViewController: UIViewController) {
        store.dispatch(RouteAction.push(route: .tasks(withParentTaskId: .parent(task.id))))
    }
}
