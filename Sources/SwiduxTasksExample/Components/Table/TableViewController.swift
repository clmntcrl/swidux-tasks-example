//  Created by Cyril Clément
//  Copyright © 2018 clmntcrl. All rights reserved.

import UIKit

public class TableViewController: UITableViewController {

    var rows: [TableRow] = []
    private var identifiers: Set<String> = []

    // MARK: - Data source

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }

    // MARK: - Cell rendering and selection

    private func register(cellWithDescriptor descriptor: TableCellDescriptor) {
        guard !identifiers.contains(descriptor.reuseIdentifier) else {
            return
        }
        identifiers.insert(descriptor.reuseIdentifier)
        tableView.register(descriptor.cellClass, forCellReuseIdentifier: descriptor.reuseIdentifier)
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get item and cell descriptor
        let descriptor = rows[indexPath.row].cellDescriptor
        // Register cell if needed
        register(cellWithDescriptor: descriptor)
        // Dequeue and configure cell
        let cell = tableView.dequeueReusableCell(withIdentifier: descriptor.reuseIdentifier, for: indexPath)
        descriptor.configure(cell)
        return cell
    }

    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rows[indexPath.row].didSelect(on: self)
    }

    public override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        rows[indexPath.row].tapAccessoryButton(on: self)
    }
}
