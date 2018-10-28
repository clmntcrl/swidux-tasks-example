//  Created by Cyril Clément
//  Copyright © 2018 clmntcrl. All rights reserved.

import Foundation

public enum Parent<A: Hashable>: Hashable {

    case root
    case parent(A)
}

extension Parent: CustomStringConvertible {

    public var description: String {
        switch self {
        case .root: return "\(Parent.self).root"
        case .parent(let p): return "\(Parent.self).parent(\(p))"
        }
    }
}
