//
//  ReadingBookViewController.swift
//  ReadFox
//
//  Created by Yerkegali Abubakirov on 29.05.2018.
//  Copyright © 2018 Yerkegali Abubakirov. All rights reserved.
//

import UIKit

class ReadingBookViewController: UIViewController {

    var readingBookView: ReadingBookView!
    
    let imgBackArrow = UIImage(named: "leftArrowIcon")

    var book: Book!

    var navigationTitle: UILabel = {
        let l = UILabel()
        let boldText = NSMutableAttributedString(string: "Read", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20)])
        boldText.append(NSMutableAttributedString(string: "Fox", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20)]))
        l.attributedText = boldText
        l.textColor = UIColor.white
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = navigationTitle

        navigationItem.titleView = navigationTitle
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backIndicatorImage = imgBackArrow
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = imgBackArrow
        navigationController?.navigationBar.tintColor = UIColor.white
        
        setupView()
        setupConstraints()

        if book != nil {
            self.readingBookView.bookImage.imageFromUrl(urlString: book.imageURL)
            self.readingBookView.bookNameLabel.text = book.title
            self.readingBookView.authorLabel.text = book.author
            self.readingBookView.pageCountLabel.text = String(book.pageCount)
        }
    }
    
    func deleteBook(){
        dismiss(animated: false, completion: nil)
    }
    
}

extension ReadingBookViewController {
    
    private func setupView(){
        let mainView = ReadingBookView(frame: view.frame)
        self.readingBookView = mainView
        self.view.addSubview(readingBookView)
        self.readingBookView.deleteBookAction = deleteBook
    }
    
    private func setupConstraints(){
        
    }
    
}
