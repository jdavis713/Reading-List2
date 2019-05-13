//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Jordan Davis on 5/13/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    func updateViews() {
        guard let book = book else { return }
        
        bookNameLabel.text = book.title
        if book.hasBeenRead == true {
            checkedUnchecked.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            checkedUnchecked.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }
    
    //MARK: -Actions

    @IBAction func checkedUnchecked(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    //MARK: -Properties
    
    @IBOutlet var bookNameLabel: UILabel!
    @IBOutlet var checkedUnchecked: UIButton!
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    var delegate: BookTableViewCellDelegate?
    
}
