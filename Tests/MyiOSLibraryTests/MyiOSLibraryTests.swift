import Foundation
import Testing
@testable import MyiOSLibrary





@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    
    let nonSendable = NonSendable()
    let safeClosure: @Sendable () -> Void = {
        let localValue = 42  // Local values are safe
        print("Safe operation: \(localValue)")
    }
    nonSendable.performAsyncTask(safeClosure)
    
    
}
class NonSendable{
    func performAsyncTask(_ task: @Sendable @escaping() -> Void) {
        Task {
            task()  // This closure might execute on a different thread
        }
    }
}
