//
//  SwiftSuffixArrayManipulator.swift
//  DataStructuresProfiling
//
//  Created by Иван Лазарев on 06.05.2020.
//  Copyright © 2020 Exey Panteleev. All rights reserved.
//

import Foundation

class SwiftSuffixArrayManipulator: SuffixArrayManipulator {
    
    typealias SuffixArrayElement = Array<(SuffixSequence, String)>
    
    private var tupleArray = SuffixArrayElement()
    
    func arrayHasObjects() -> Bool {
        if tupleArray.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    func setupWithObjectCount(_ count: Int) -> TimeInterval {
        return Profiler.runClosureForTime() { [weak self] in
            guard let self = self else { return }
            self.tupleArray = SuffixArrayElement()
            
            
            (0..<count).forEach { _ in
                let suffixTuples = AlgoProvider().suffixTuples
                suffixTuples.forEach { tuple in
                    self.tupleArray.append(tuple)
                }
            }
        }
    }
    
    fileprivate func nextElement() -> (SuffixSequence, String) {
        return AlgoProvider().suffixTuples.randomElement()!
    }
    
    func insertNewObjectAtBeginning() -> TimeInterval {
        let next = nextElement()
        let time = Profiler.runClosureForTime() {
            self.tupleArray.insert(next, at: 0)
        }
        
        assert(tupleArray[0] == next, "First object was not changed!")
        tupleArray.remove(at: 0)
        assert(tupleArray[0] != next, "First object not back to original!")
        
        return time
    }
    
    func insertNewObjectInMiddle() -> TimeInterval {
        let half = Float(tupleArray.count) / Float(2)
          let middleIndex = Int(ceil(half))
          let next = nextElement()
        
          let time = Profiler.runClosureForTime() {
            self.tupleArray.insert(next, at: middleIndex)
          }
          
          assert(tupleArray[middleIndex] == next, "Middle object didn't change!")
          
          //Reset
          self.tupleArray.remove(at: middleIndex)
          
          assert(tupleArray[middleIndex] != next, "Middle object is not the same after removal!")
          
          return time
    }
    
    func addNewObjectAtEnd() -> TimeInterval {
        let next = nextElement()
        let time = Profiler.runClosureForTime() {
            self.tupleArray.append(next)
        }
        
        //Remove the added string
        self.tupleArray.removeLast()
        return time
    }
    
    //MARK: Removal tests
    
    func removeFirstObject() -> TimeInterval {
      let originalFirst = tupleArray[0]
      let time = Profiler.runClosureForTime() {
        self.tupleArray.remove(at: 0)
      }
      
      assert(tupleArray[0] != originalFirst, "First object didn't change!")
      tupleArray.insert(originalFirst, at: 0)
      assert(tupleArray[0] == originalFirst, "First object is not the same after removal!")
      return time
    }
    
    func removeMiddleObject() -> TimeInterval {
      let half = Float(tupleArray.count) / Float(2)
      let middleIndex = Int(ceil(half))
      let originalMiddle = tupleArray[middleIndex]
      
      let time = Profiler.runClosureForTime() {
        self.tupleArray.remove(at: middleIndex)
      }
      
      assert(tupleArray[middleIndex] != originalMiddle, "Middle object didn't change!")
      tupleArray.insert(originalMiddle, at: middleIndex)
      assert(tupleArray[middleIndex] == originalMiddle, "Middle object is not the same after being added back!")
      
      return time
    }
    
    func removeLastObject() -> TimeInterval {
      tupleArray.append(nextElement())
      return Profiler.runClosureForTime() {
        self.tupleArray.removeLast()
      }
    }
    
    //MARK: Lookup tests

    func lookupByIndex() -> TimeInterval {
      let elements = UInt32(tupleArray.count)
      let randomIndex = Int(arc4random_uniform(elements))
      
      let time = Profiler.runClosureForTime() {
        _ = self.tupleArray[randomIndex]
      }
      
      return time
    }
    
    func lookupByObject() -> TimeInterval {
      //Add a known object at a random index.
      let next = nextElement()
      let elements = UInt32(tupleArray.count)
      let randomIndex = Int(arc4random_uniform(elements))
      tupleArray.insert(next, at: randomIndex)
      
      let time = Profiler.runClosureForTime() {
        let _ = self.tupleArray.firstIndex { tuple -> Bool in
            tuple == next
        } //firstIndex(of: next)//find(self.tupleArray, next)
      }

      return time
    }
    

    func lookupRandomString() -> (TimeInterval, Int) {
        
        let randomStrings = (0..<10).map { _ in
            return StringGenerator().generateRandomString(2)
        }
        
        var count = 0
        
        let time = Profiler.runClosureForTime() {
            randomStrings.forEach { randStr in
                print(randStr)
                self.tupleArray.forEach { tuple in
                    for suffix in tuple.0 {
                        if let suffix = suffix as? String, suffix.lowercased().contains(randStr.lowercased()) {
                            count += 1
                        }
                    }
                }
            }
        }
        
        print("founded \(count) entrances")
        
        return (time, count)
    }
    
}

protocol SuffixArrayManipulator: ArrayManipulator {
    func lookupRandomString() -> (TimeInterval, Int)
}
