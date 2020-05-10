//
//  SuffixSequence.swift
//  DataStructuresProfiling
//
//  Created by Иван Лазарев on 05.05.2020.
//  Copyright © 2020 Exey Panteleev. All rights reserved.
//

import Foundation

struct SuffixSequence: Sequence {
    
    private let string: String
    
    init(_ string: String) {
        self.string = string
    }
    
    func makeIterator() -> some IteratorProtocol {
        return string.makeSuffixIterator()
    }
}

extension SuffixSequence: Equatable {
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.string == rhs.string
    }
}
