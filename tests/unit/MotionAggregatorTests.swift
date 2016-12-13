/*
 Copyright 2016-present The Material Motion Authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

import XCTest
import IndefiniteObservable
import MaterialMotionStreams

class PropertyWriterTests: XCTestCase {

  func testWrites() {
    var someVar = 10
    let property = ScopedProperty(read: { return someVar }, write: { someVar = $0 })

    let value = 100

    let observable = MotionObservable<Int> { observer in
      observer.next(value)
      return noopDisconnect
    }

    let writer = MotionAggregator()
    writer.write(observable, to: property)

    XCTAssertEqual(someVar, value)
  }
}
