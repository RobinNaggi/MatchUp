//
//  ViewController.swift
//  Concentration.naggirk
//
//  Created by Robin Naggi on 1/2/19.
//  Copyright © 2019 Robin Naggi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1)/2)
    
    var themeList:[themeCheck] = [themeCheck(arr: ["👻","🎃","👹","💀","👽","🍎","🍭","👿"], theme: "Halloween", backgroudColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), cardBackColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), cardFrontColor: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1) ),
                                  themeCheck(arr: ["🌲","☃️","🏂","❄️","⛷","🎅","🥶","😴"], theme: "Christmas", backgroudColor: #colorLiteral(red: 0.4761485457, green: 0.5653342605, blue: 0.9987019897, alpha: 1), cardBackColor: #colorLiteral(red: 0, green: 0.9559331536, blue: 1, alpha: 1), cardFrontColor: #colorLiteral(red: 0, green: 0.5330947042, blue: 0.5245136619, alpha: 1)),
                                  themeCheck(arr: ["🏈","🏀","⚽️","⚾️","🥎","🥊","🏏","🏅"], theme: "Sports", backgroudColor:#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1),cardBackColor:#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1),cardFrontColor:#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)),
                                  themeCheck(arr: ["🐶","🐱","🐭","🐯","🐨","🦁","🐮","🐸"], theme: "Animals", backgroudColor:#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1),cardBackColor:#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),cardFrontColor:#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)),
                                  themeCheck(arr:["🍌","🍉","🍇","🍔","🍟","🌮","🍲","🍩"], theme: "Food", backgroudColor:#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),cardBackColor:#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1),cardFrontColor:#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)),
                                  themeCheck(arr: ["😇","🤪","🥳","🤣","🤯","😂","🤓","🤩"], theme: "Faces", backgroudColor:#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1),cardBackColor:#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1),cardFrontColor:#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1))]
    
    var numberOfIndex = 0
    var currentTheme: themeCheck! = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        numberOfIndex = Int(arc4random_uniform((UInt32(themeList.count))))
        currentTheme = themeList[numberOfIndex]
        themeLabel.text = "Theme: \(currentTheme.theme)"
    }
    

    
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var newGamebutton: UIButton!
    @IBOutlet weak var leaveButton: UIButton!
    
    @IBAction func quitGame(_ sender: UIButton) {
        exit(0);
    }
    
    struct themeCheck {
        var arr = [String]()
        var theme = ""
        var backgroudColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        var cardBackColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        var cardFrontColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        init(arr temp: [String], theme th: String,backgroudColor gb: UIColor, cardBackColor cb: UIColor,cardFrontColor cf: UIColor ) {
            arr = temp
            theme = th
            backgroudColor = gb
            cardBackColor = cb
            cardFrontColor = cf
        }
    }
    
    @IBOutlet weak var themeLabel: UILabel!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCountLabel.text = "Flips: \(game.getFlipCount())"
        scoreLabel.text = "Score: \(game.getScore())"
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        else {
            print("The card was not in cardButtons")
        }
        if game.checkGameWinner() {
            let alertController = UIAlertController(title: "Game over", message: "You found all the cards", preferredStyle: UIAlertController.Style.alert)
             alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
             present(alertController, animated: true, completion: nil)
            newGameButton(sender)
        }
    }
    
    @IBAction func newGameButton(_ sender: UIButton) {
        
        flipCountLabel.text = "Flips: 0"
        scoreLabel.text = "Score: 0"
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1)/2)
        updateViewFromModel()
        currentTheme = themeList[Int.random(in: 0 ..< themeList.count)]
        themeLabel.text = "Theme: \(currentTheme.theme)"
        //self.newGamebutton.backgroundColor = currentTheme.cardBackColor
        //self.leaveButton.backgroundColor = currentTheme.cardBackColor
        //gameTitle.backgroundColor = currentTheme.cardBackColor
        //themeLabel.backgroundColor = currentTheme.cardBackColor
        
        
        for index in cardButtons.indices {
            cardButtons[index].isEnabled = true
            cardButtons[index].backgroundColor = currentTheme.cardBackColor
            self.view.backgroundColor = currentTheme.backgroudColor
        }
        
    }
    
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = currentTheme.cardFrontColor
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.01679927147) : currentTheme.cardBackColor
            }
            if button.backgroundColor == #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.01679927147) {
                button.isEnabled = false
            }
        }
    }
    
    var emoji = [Int:String]()
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, currentTheme.arr.count > 0{
            let randomIndex = arc4random_uniform(UInt32(currentTheme.arr.count))
            emoji[card.identifier] = currentTheme.arr.remove(at: Int(randomIndex))
        }
        return emoji[card.identifier] ?? "?"
    }
    
}

