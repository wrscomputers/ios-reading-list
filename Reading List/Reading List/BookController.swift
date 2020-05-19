//
//  BookController.swift
//  Reading List
//
//  Created by Jason Hoover on 5/19/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var books: [Book] = []
    
    var readingListURL: URL? {
        let fileManager = FileManager.default
        let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let booksURL = documentsDir?.appendingPathComponent("ReadingList.plist")
        return booksURL
    }
    func saveToPersistanceStore() {
        do {
            guard let readingListURL = readingListURL else {return}
            let encoder = PropertyListEncoder()
            let booksPlist = try encoder.encode(books)
            try booksPlist.write(to: readingListURL)
        } catch {
            print("Error saving stars: \(error)")
        }
    }
    func loadFromPersistentStore() {
        do {
            guard let readingListURL = readingListURL else { return }
            let booksPlist = try Data(contentsOf: readingListURL)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: booksPlist)
            self.books = decodedBooks
        } catch {
            print("Error loading stars from plist: \(error)")
        }
    }
    
}
