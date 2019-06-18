 //
//  Model.swift
//  SampleToRemind
//
//  Created by Andrei Konovalov on 6/16/19.
//  Copyright © 2019 Andrei Konovalov. All rights reserved.
//

import Foundation

 class Game {
  
    private(set) var cards = [Card]()
     
    private var indexOfOneCardFacedUp: Int?{
        get{
            var foundindex: Int?
            for index in cards.indices {
                if cards[index].isFacedUp{
                    if foundindex == nil{
                        foundindex = index
                    }else{
                        return nil
                    }
                }
            }
            return foundindex
        }
        set{
            for index in cards.indices{
                cards[index].isFacedUp = (index == newValue)
            }
        }
    }
    
    var counter = 0
    func choseCard(at index: Int){
        assert(cards.indices.contains(index), "Crashed when entered choseCard with index \(index)")
        if !cards[index].isMatched{
            if let matchindex = indexOfOneCardFacedUp, matchindex != index{
                if cards[matchindex].identifier == cards[index].identifier {
                    cards[matchindex].isMatched = true
                    cards[index].isMatched = true
                    counter += 2
                }else{
                    //TODO: mismatch penalising logic
                    if (cards[index].isSeen == true) {
                        counter -= 1
                    } 
                }
                cards[index].isFacedUp = true
                cards[index].isSeen = true
                
            }else{
                indexOfOneCardFacedUp = index  
            }
        }
    }
    
    init(numOfParis: Int){
        assert(numOfParis > 0, "Crashed when entered init with numOfPairs \(numOfParis)")
        for _ in 1...numOfParis{
            let card = Card()
            cards += [card,card]
        }
        cards.shuffle()
    }
    deinit {
        cards.removeAll()
    }
 }
