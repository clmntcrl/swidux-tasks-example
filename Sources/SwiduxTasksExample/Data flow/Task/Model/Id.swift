//  Created by Cyril Clément
//  Copyright © 2018 clmntcrl. All rights reserved.

import Foundation

public final class Id<A> {
    let id = UUID()
}

extension Id: Equatable {

    public static func == (lhs: Id<A>, rhs: Id<A>) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Id: Hashable {

    public var hashValue: Int {
        return id.hashValue
    }
}

extension Id: CustomStringConvertible {

    public var description: String {
        return "\(Id.self)(\(id))"
    }
}
