//
//  SuffixIterator.swift
//  DataStructuresProfiling
//
//  Created by Иван Лазарев on 05.05.2020.
//  Copyright © 2020 Exey Panteleev. All rights reserved.
//

import Foundation

struct SuffixIterator: IteratorProtocol {
    
    private var index = 0
    private var suffixes: [String]
    
    mutating func next() -> String? {
        if suffixes.isEmpty { return nil }
        return suffixes.removeFirst()
    }
    
    init(_ string: String) {
        self.suffixes = string.suffixArray()
    }
}
