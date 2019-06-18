//
//  Card.swift
//  SampleToRemind
//
//  Created by Andrei Konovalov on 6/16/19.
//  Copyright © 2019 Andrei Konovalov. All rights reserved.
//

import Foundation

struct Card{
    var isFacedUp = false
    var isMatched = false
    var identifier: Int
    var isSeen = false
    private static var UnicId = 0
    
    private static func getUnicId ()->Int{
        UnicId += 1
        return UnicId
    }
    
    init(){
        self.identifier = Card.getUnicId()
    }
}
