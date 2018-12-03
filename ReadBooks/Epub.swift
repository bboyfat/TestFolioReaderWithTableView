//
//  Epub.swift
//  ReadBooks
//
//  Created by Andrey Petrovskiy on 02.12.2018.
//  Copyright © 2018 Andrey Petrovskiy. All rights reserved.
//

import Foundation

import FolioReaderKit

enum Epub: Int{
    
    case bookOne = 0
    case bookTwo
    case bookThree
    
    var name: String{
        switch self{
        case.bookOne: return "Alisa-V-Strane"
        case.bookTwo: return "Mobi-Dik"
        case.bookThree: return "Sherlock-Holmes"
        }
    }
    
    var shouldHiddenNavigationOnTap: Bool{
        switch self{
        case.bookOne: return false
        case.bookTwo: return false
        case.bookThree: return false
        }
    }
    
    
    
    var scrollDirection: FolioReaderScrollDirection {
        switch self{
        case.bookOne: return .horizontal
        case.bookTwo: return .horizontal
        case.bookThree: return .horizontal
        }
    }
    
    var bookPath: String?{
        
        return Bundle.main.path(forResource: self.name, ofType: "epub")
        
    }
    
    var readerIdentifier: String{
        switch self{
        case.bookOne: return "Book One"
        case.bookTwo: return "Book Two"
        case.bookThree: return "Book Three"
        }
        
        
        
    }
    
    
    
    
    
}
