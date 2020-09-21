//===----------------------------------------------------------------------===//
//
// This source file is part of the SwiftNIO open source project
//
// Copyright (c) 2020 Apple Inc. and the SwiftNIO project authors
// Licensed under Apache License v2.0
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.txt for the list of SwiftNIO project authors
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//

import NIO
@testable import NIOIMAPCore
import XCTest

class MetadataOption_Tests: EncodeTestClass {}

// MARK: - Encoding

extension MetadataOption_Tests {
    func testEncode() {
        let inputs: [(MetadataOption, String, UInt)] = [
            (.maxSize(123), "MAXSIZE 123", #line),
            (.scope(.one), "DEPTH 1", #line),
            (.other(.init(name: "param")), "param", #line),
        ]
        self.iterateInputs(inputs: inputs, encoder: { self.testBuffer.writeMetadataOption($0) })
    }

    func testEncode_array() {
        let inputs: [([MetadataOption], String, UInt)] = [
            ([.maxSize(123)], "(MAXSIZE 123)", #line),
            ([.maxSize(1), .scope(.one)], "(MAXSIZE 1 DEPTH 1)", #line),
        ]
        self.iterateInputs(inputs: inputs, encoder: { self.testBuffer.writeMetadataOptions($0) })
    }
}
