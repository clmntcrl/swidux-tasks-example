//  Created by Cyril Clément
//  Copyright © 2018 clmntcrl. All rights reserved.

import UIKit

protocol TableRow {

    var cellDescriptor: TableCellDescriptor { get }

    func didSelect(on tableViewController: UIViewController)
    func tapAccessoryButton(on tableViewController: UIViewController)
}

extension TableRow {

    func didSelect(on tableViewController: UIViewController) {
    }

    func tapAccessoryButton(on tableViewController: UIViewController) {
    }
}
