//  Created by Cyril Clément
//  Copyright © 2018 clmntcrl. All rights reserved.

import Foundation
import Swidux
import SwiduxRouter
import SwiduxEcho

public struct AppState {

    public var root = RootDescriptor(initialRoute: .tasks(withParentTaskId: .root))
    public var task = TaskState.mockedState
}

public let store = Store(
    initialState: AppState(),
    reducer: .combine(reducers: [
        routeReducer.lift(\.root),
        taskReducer.lift(\.task),
    ]),
    middlewares: [
        echo(),
    ]
)
