//
//  String+Suffixes.swift
//  DataStructuresProfiling
//
//  Created by Иван Лазарев on 05.05.2020.
//  Copyright © 2020 Exey Panteleev. All rights reserved.
//

import Foundation

extension String {
    func suffixArray() -> [String] {
        var suffixes = [String]()
        var index = self.startIndex
        while index != self.endIndex {
            suffixes.append(String(self.suffix(from: index)))
            index = self.index(after: index)
        }
        return suffixes.sorted()
    }
}

extension String {
    func makeSuffixIterator() -> SuffixIterator {
        let iterator = SuffixIterator.init(self)
        return iterator
    }
}
