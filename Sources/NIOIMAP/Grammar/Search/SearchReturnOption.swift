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

    /// IMAPv4 `search-return-opts`
    public typealias SearchReturnOptions = [SearchReturnOption]?

    /// IMAPv4 `search-return-opt`
    public enum SearchReturnOption: Equatable {
        case min
        case max
        case all
        case count
        case save
        case optionExtension(SearchReturnOptionExtension)
    }

}

// MARK: - Encoding
extension ByteBuffer {

    @discardableResult mutating func writeSearchReturnOption(_ option: NIOIMAP.SearchReturnOption) -> Int {
        switch option {
        case .min:
            return self.writeString("MIN")
        case .max:
            return self.writeString("MAX")
        case .all:
            return self.writeString("ALL")
        case .count:
            return self.writeString("COUNT")
        case .save:
            return self.writeString("SAVE")
        case .optionExtension(let option):
            return self.writeSearchReturnOptionExtension(option)
        }
    }

    @discardableResult mutating func writeSearchReturnOptions(_ options: NIOIMAP.SearchReturnOptions) -> Int {
        self.writeString(" RETURN (") +
        self.writeIfExists(options) { (options) -> Int in
            self.writeArray(options, parenthesis: false) { (option, self) in
                self.writeSearchReturnOption(option)
            }
        } +
        self.writeString(")")
    }

}