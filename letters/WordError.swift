//
//  WordError.swift
//  letters
//
//  Created by Mati on 28/11/2019.
//  Copyright © 2019 devmini. All rights reserved.
//

import Foundation
enum WordError:Error {
    
    case wordIsEmpty
    case wordAlreadyUsed
}

func validateWord (word:String, wordList:[String]) throws {
    
    if word.isEmpty {
        throw WordError.wordIsEmpty
        
    } else if wordList.contains(word) {
        throw WordError.wordAlreadyUsed
    }
}

func wordIsValid (_ word:String, _ wordList:[String]) {
    
    do {
        try validateWord(word: word, wordList: wordList)
    } catch WordError.wordIsEmpty {
        print("Please create a word")
    } catch WordError.wordAlreadyUsed {
        print("This word has been used before. Try another one")
    } catch {
        print("Word error")
    }
}

