//
//  SuffixArrayViewController.swift
//  DataStructuresProfiling
//
//  Created by Иван Лазарев on 06.05.2020.
//  Copyright © 2020 Exey Panteleev. All rights reserved.
//

import Foundation

import UIKit

class SuffixArrayViewController: ArrayViewController {
    
    private let _arrayManipulator: SuffixArrayManipulator = SwiftSuffixArrayManipulator()
    
    override var arrayManipulator: ArrayManipulator {
        get {
            return _arrayManipulator
        }
        set { }
    }
    
    var lookupByRandomStrings: (TimeInterval, Int) = (0, 0)
    
    override func test() {
        super.test()
        if (arrayManipulator.arrayHasObjects()) {
            lookupByRandomStrings = _arrayManipulator.lookupRandomString()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if indexPath.row == 9 {
            cell.textLabel!.text = "Lookup Random String \(lookupByRandomStrings.1) entrances"
            cell.detailTextLabel!.text = formattedTime(lookupByRandomStrings.0)
        }
        
        return cell
    }
}

extension SuffixArrayViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.slider.minimumValue = 1
        self.slider.maximumValue = 100
    }
}
