//  Created by Cyril Clément
//  Copyright © 2018 clmntcrl. All rights reserved.

import Foundation

extension Task {

    static func byTitle(lhs: Task, rhs: Task) -> Bool {
        return lhs.title < rhs.title
    }
}
