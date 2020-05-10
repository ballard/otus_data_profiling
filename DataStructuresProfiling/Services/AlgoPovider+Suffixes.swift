//
//  AlgoPovider+Suffixes.swift
//  DataStructuresProfiling
//
//  Created by Иван Лазарев on 07.05.2020.
//  Copyright © 2020 Exey Panteleev. All rights reserved.
//

import Foundation

extension AlgoProvider {
    
    var suffixTuples: Array<(SuffixSequence, String)> {
        
        var algoSuffixTuples = Array<(SuffixSequence, String)>()
        
        for algo in self.all {
            let algoTuple = (SuffixSequence(algo), algo)
            algoSuffixTuples.append(algoTuple)
        }
        
        return algoSuffixTuples.sorted { $0.1 < $1.1 }
    }
}
