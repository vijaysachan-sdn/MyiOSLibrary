//
//  EDateTest.swift
//  MyiOSLibrary
//
//  Created by Vijay Sachan on 4/29/25.
//

import Testing
@testable import MyiOSLibrary
import Foundation
struct EDateTest{
    @Test func test() async throws{
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        Date().fw_test()
    }
}
