//
//  BookController.swift
//  Reading List
//
//  Created by Jordan Davis on 5/13/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    
    //MARK: -Functions
    
    func createBook(title: String, reasonToRead: String) {
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        
        saveToPersistentStore()
    }
    
    func deleteBook(book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        books.remove(at: index)
        
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        books[index].hasBeenRead.toggle()
        
        saveToPersistentStore()
    }
    
    func updateBook(book: Book, title: String, reasonToRead: String) {
        guard let index = books.firstIndex(of: book) else { return }
        books[index].title = title
        books[index].reasonToRead = reasonToRead
        
        saveToPersistentStore()
    }
    
    //MARK: -Persistent Functions
    
    func saveToPersistentStore() {
        
        guard let url = readingListURL else { return }
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(books)
            try data.write(to: url)
        } catch {
            print("Error saving books: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        
        let fileManager = FileManager.default
        guard let url = readingListURL, fileManager.fileExists(atPath: url.path) else { return }
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: data)
            books = decodedBooks
        } catch {
            print("Error loading data from disk: \(error)")
        }
    }
    
    
    
    
    
    
    
    
    
    
    //MARK: -Properties
    
    private(set) var books: [Book] = []
    
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        print("Documents: \(documents.path)")
        return documents.appendingPathComponent("ReadingList.plist")
    }
    
    var readBooks: [Book] {
        let read = books.filter { $0.hasBeenRead == true }
        return read
    }
    
    var unreadBooks: [Book] {
        let unread = books.filter { $0.hasBeenRead == false }
        return unread
    }
    
}
