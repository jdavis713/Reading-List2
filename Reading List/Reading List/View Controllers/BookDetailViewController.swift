//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Jordan Davis on 5/13/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    private func updateViews() {
        guard let book = book else { return }
        
        title = book.title
        bookTitleTextField.text = book.title
        reasonToReadTextView.text = book.reasonToRead
        
        if book.title.isEmpty {
            title = "Add a New Book"
        }
    }
    
    //MARK: -Actions
    
    @IBAction func saveBook(_ sender: Any) {
        guard let title = bookTitleTextField.text, !title.isEmpty,
            let reasonToRead = reasonToReadTextView.text, !reasonToRead.isEmpty else { return }
        
        if let book = book {
            bookController?.updateBook(book: book, title: title, reasonToRead: reasonToRead)
        } else {
            bookController?.createBook(title: title, reasonToRead: reasonToRead)
        }
        navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: -Properties
    @IBOutlet var bookTitleTextField: UITextField!
    @IBOutlet var reasonToReadTextView: UITextView!
    
    var bookController: BookController?
    var book: Book?
    
}
