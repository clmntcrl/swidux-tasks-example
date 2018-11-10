import PlaygroundSupport
import UIKit
import SwiduxTasksExample
import SwiduxRouter

let router = Router(
    store: store,
    keyPath: \.routes
)
router.view.frame = CGRect(x: 0, y: 0, width: 375, height: 667)

PlaygroundPage.current.liveView = router.view

print("✅")
