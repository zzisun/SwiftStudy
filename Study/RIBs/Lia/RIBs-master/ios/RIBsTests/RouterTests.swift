//
//  Copyright (c) 2017. Uber Technologies
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import RxSwift
import XCTest
@testable import RIBs

final class RouterTests: XCTestCase {

    private var router: Router<Interactable>!
    private var lifecycleDisposable: Disposable!

    // MARK: - Setup

    override func setUp() {
        super.setUp()

        router = Router(interactor: InteractableMock())
    }

    override func tearDown() {
        super.tearDown()

        lifecycleDisposable.dispose()
    }

    // MARK: - Tests

    func test_load_verifyLifecycleObservable() {
        var currentLifecycle: RouterLifecycle?
        var didComplete = false
        lifecycleDisposable = router
            .lifecycle
            .subscribe(onNext: { lifecycle in
                currentLifecycle = lifecycle
            }, onCompleted: {
                currentLifecycle = nil
                didComplete = true
            })

        XCTAssertNil(currentLifecycle)
        XCTAssertFalse(didComplete)

        router.load()

        XCTAssertEqual(currentLifecycle, RouterLifecycle.didLoad)
        XCTAssertFalse(didComplete)

        router = nil

        XCTAssertNil(currentLifecycle)
        XCTAssertTrue(didComplete)
    }
}
