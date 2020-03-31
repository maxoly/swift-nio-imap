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

extension NIOIMAP {

    /// IMAPv4 `response-fatal`
    public typealias ResponseFatal = ResponseConditionalBye

}

// MARK: - Encoding
extension ByteBuffer {

    @discardableResult mutating func writeResponseFatal(_ fatal: NIOIMAP.ResponseFatal) -> Int {
        self.writeString("* ") +
        self.writeResponseConditionalBye(fatal) +
        self.writeString("\r\n")
    }

}