//
//  ViewController.swift
//  SampleToRemind
//
//  Created by Andrei Konovalov on 6/15/19.
//  Copyright © 2019 Andrei Konovalov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var cardgame = Game(numOfParis: (Buttons.count+1)/2)
    @IBOutlet private var Buttons: [UIButton]!
    @IBOutlet private weak var flipcounter: UITextField!
    @IBOutlet private var viewBackground: UIView!
    
    @IBAction private func newGame(_ sender: UIButton) {
        emoji.removeAll(keepingCapacity: false)
        // not shure what is going on with previous version of cardgame, I assume that swift has its own cleaners
        cardgame = Game(numOfParis: (Buttons.count+1)/2)
        updateViewFromModel(index: 1)
        choices = [moon,nature,views]
        theme = Int(arc4random_uniform(UInt32(choices.count)))
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flipcounter.textColor = #colorLiteral(red: 0.6142917275, green: 0.6143975854, blue: 0.6142777801, alpha: 0.7810574384)
        // Do any additional setup after loading the view.
    }

    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardindex = Buttons.firstIndex(of: sender){
            cardgame.choseCard(at: cardindex)
            updateViewFromModel(index: cardindex)
        }else{
            print("BA DuM tS card is not in the list, check that mess")
        }
    }
    
    private func updateViewFromModel(index of: Int){
        flipcounter.text = "Score: \(cardgame.counter)"
        for index in Buttons.indices{
            let card = cardgame.cards[index]
            let button = Buttons[index]
            if card.isFacedUp{
                button.setTitle(pickEmoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 0.4021511884)
            }else{
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : themeCardBackgroundColour[theme]
                viewBackground.backgroundColor = viewBackgroundColour[theme]
            }
        }
    }
   
    private var themeCardBackgroundColour = [#colorLiteral(red: 0.722305119, green: 0.6052984595, blue: 0.998216331, alpha: 1), #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1), #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)]
    private var viewBackgroundColour = [#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)]
    private var moon = ["🌕","🌖","🌗","🌘","🌑","🌒","🌓","🌔"]
    private var nature = ["🌷","🌹","🥀","🌺","🌻","💐","🎋","🌸"]
    private var views = ["🌇","🏙","🌃","🌌","🎑","🎇","🌄","🗾"]
    private var theme = 0
    private lazy var choices = [moon,nature,views]
    private var emoji = [Int:String]()
    
    private func pickEmoji(for card: Card)->String{
        if emoji[card.identifier] == nil, choices[theme].count > 0 {
            emoji[card.identifier] = choices[theme].remove(at: emoji.count.arc4random)
        }
            return emoji[card.identifier] ?? "?"
    }
}

extension Int{
    var arc4random: Int{
        return Int(arc4random_uniform(UInt32(self)))
    }
}
