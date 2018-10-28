//  Created by Cyril Clément
//  Copyright © 2018 clmntcrl. All rights reserved.

import UIKit

struct TableCellDescriptor {

    let reuseIdentifier: String
    let cellClass: UITableViewCell.Type

    let configure: (UITableViewCell) -> Void

    init<A: UITableViewCell>(reuseIdentifier: String = String(describing: A.self),
                             configure: @escaping (A) -> Void = { _ in }) {
        self.reuseIdentifier = reuseIdentifier
        self.cellClass = A.self
        self.configure = { cell in
            configure(cell as! A) // Force cast is due to type erasure (we know that cell is always of type A)
        }
    }
}
