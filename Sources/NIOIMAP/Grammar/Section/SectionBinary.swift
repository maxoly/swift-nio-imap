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

    /// IMAPv4 `section-binary`
    public typealias SectionBinary = SectionPart?

}

extension ByteBuffer {
    
    @discardableResult mutating func writeSectionBinary(_ binary: NIOIMAP.SectionBinary) -> Int {
        self.writeString("[") +
        self.writeIfExists(binary) { (part) -> Int in
            self.writeSectionPart(part)
        } +
        self.writeString("]")
    }

}