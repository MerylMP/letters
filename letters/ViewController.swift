//
//  ViewController.swift
//  letters
//
//  Created by Mati on 25/11/2019.
//  Copyright © 2019 devmini. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var wordResult: UILabel!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    
    var timer:Timer?
    var timeLeft = 60
    
    var numberOfTypeOfLetters = 5
    
    let consonants:[String] = ["B","C","D","F","G","H","J","K","L","M","N","O","P","Q","V","W","X","Y","Z"]
    let vowels:[String] = ["A","E","I","O","U"]
    
    var randomLetters:[String] = []
    
    
    
    //TABLE
    
    @IBOutlet weak var tableResults: UITableView!
    
    var checkedWords:[String] = []
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.checkedWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell=UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "wordCell")
        cell.textLabel?.text = checkedWords[indexPath.row]
        return cell
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.randomLetters.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "lettersCell", for: indexPath) as! LetterViewCell
        
        cell.letterButton.setTitle(self.randomLetters[indexPath.row], for: .normal)
        cell.letterButton.backgroundColor = #colorLiteral(red: 0.107338123, green: 0.2766298652, blue: 0.3985479474, alpha: 1)
        cell.letterButton.isSelected = false
        cell.letterButton.isEnabled = true
        
        return cell
    }
    
    
    func changeLetters(_ n:Int) {
        // game shows 5 vowels and 5 letters. Each letter may appear more than once.
        
        for _ in 0..<n {
            let vowelToShow = vowels[Int(arc4random_uniform(UInt32(vowels.count)))]
            let consonantToSwhow = consonants[Int(arc4random_uniform(UInt32(consonants.count)))]
            
            randomLetters.append(vowelToShow)
            randomLetters.append(consonantToSwhow)
            collectionView.reloadData()
        }
    }
    
    
    
    func startCountDown() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
    }
    
    
    @objc func onTimerFires() {
        
        timeLeft -= 1
        timerLabel.text = "\(timeLeft)"
        
        if timeLeft <= 0 {
            timer?.invalidate()
            timer = nil
        }
    }
    
    
    func restartWordResult() {
        self.wordResult.text = ""
    }
    
    
    func changeWordResult(letterAdded: String) {
        self.wordResult.text?.append(letterAdded)
    }
    
    
    
    @IBAction func clickLetter(_ sender: UIButton) {
        
        sender.isSelected = true
        sender.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        
        if let buttonTitle = sender.title(for: .normal) {
            changeWordResult(letterAdded: buttonTitle)
            print(wordResult.text ?? "")
        }
        
        sender.isEnabled = false
        
    }
    
    
    @IBAction func deleteLastLetter(_ sender: UIButton) {
        //TODO OPTIONAL: crear array de total letras y letras disponibles. A la hora de borrar, eliminar entonces de disponibles.
        
        if (self.wordResult.text != nil  &&  self.wordResult.text != "") {
            let lastLetter:String = String((self.wordResult.text?.last)!)
            self.wordResult.text?.removeLast()
            
            for i in 0..<collectionView.numberOfItems(inSection: 0){
                let indexPath = NSIndexPath(row: i, section: 0)
                let cell = collectionView.cellForItem(at: indexPath as IndexPath) as!LetterViewCell
                
                if cell.letterButton.currentTitle ==  lastLetter {
                    cell.letterButton.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
                    cell.letterButton.isSelected = false
                    cell.letterButton.isEnabled = true
                }
            }
        }
    }
    
    
    @IBAction func checkWord(_ sender: UIButton) {
        
        let checkedWord = self.wordResult.text ?? ""
        
        let apiClient:ApiClient = ApiClient()
        apiClient.checkWord(word: checkedWord, completion:{ result in
            
            print("WORD EVALUATED: \(result)")
            
            if result {
                do {
                    try GameErrors.validateWord(word: checkedWord,
                                               wordList: self.checkedWords)
                    
                    self.checkedWords.append(checkedWord)
                    self.tableResults.reloadData()
                    self.restartWordResult()
                    
                    for i in 0..<self.collectionView.numberOfItems(inSection: 0) {
                        let indexPath = NSIndexPath(row: i, section: 0)
                        let cell = self.collectionView.cellForItem(at: indexPath as IndexPath) as!LetterViewCell
                        
                        cell.letterButton.backgroundColor = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)
                        cell.letterButton.isSelected = false
                        cell.letterButton.isEnabled = true
                    }
                    
                } catch WordErrorCase.wordIsEmpty {
                    print("Please create a word")
                } catch WordErrorCase.wordAlreadyUsed {
                    print("This word has been used before. Try another one")
                } catch {
                    print("Word error")
                }
                
            } else {
                
                print("WORD IS NOT CORRECT")
            }
        })
    }
    
    
    @IBAction func startNewGame(_ sender: UIButton) {
        
        restartWordResult()
        if timer?.isValid ?? true {
            timer?.invalidate()
        }
        
        self.timeLeft = 60
        self.timerLabel.text = String(timeLeft)
        randomLetters.removeAll()
        changeLetters(numberOfTypeOfLetters)
        startCountDown()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restartWordResult()
        checkedWords.removeAll()
    }
}

