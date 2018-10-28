//  Created by Cyril Clément
//  Copyright © 2018 clmntcrl. All rights reserved.

import Foundation

extension Dictionary {

    func updatingValue(_ value: Dictionary.Value, forKey key: Dictionary.Key) -> Dictionary<Key, Value> {
        var mutableSelf = self
        mutableSelf[key] = value
        return mutableSelf
    }

    func removingValue(forKey key: Dictionary.Key) -> Dictionary<Key, Value> {
        var mutableSelf = self
        mutableSelf.removeValue(forKey: key)
        return mutableSelf
    }
}
