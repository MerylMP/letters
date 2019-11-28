//
//  WordError.swift
//  letters
//
//  Created by Mati on 28/11/2019.
//  Copyright © 2019 devmini. All rights reserved.
//

import Foundation
enum WordErrorCase:Error {
    
    case wordIsEmpty
    case wordAlreadyUsed
}

class GameErrors {
    
    static func validateWord (word:String, wordList:[String]) throws {
        
        if word.isEmpty {
            throw WordErrorCase.wordIsEmpty
            
        } else if wordList.contains(word) {
            throw WordErrorCase.wordAlreadyUsed
        }
    }
}
