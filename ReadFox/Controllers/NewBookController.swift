//
//  NewBookController.swift
//  ReadFox
//
//  Created by Yerkegali Abubakirov on 04.04.2018.
//  Copyright © 2018 Yerkegali Abubakirov. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase

class NewBookController: UIViewController, PhotoControllerDelegate {
    func changePhoto(image: UIImage) {
        newBookView.addBookImage.image = image
    }
    
    var bookImage: UIImage!

    var book: Book!

    var newBookView: NewBookView!
    var ref: DatabaseReference!
    var storageRef: StorageReference!
    
    let imgBackArrow = UIImage(named: "leftArrowIcon")
    
    let dateLabel: UILabel = {
        let l = UILabel()
        return l
    }()
    
    func getCurrentDate(){
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date)
        
        dateLabel.text = result
    }
    
    let segmtControl: UISegmentedControl = {
        let items = ["Now", "Later"]
        let sc = UISegmentedControl(items: items)
        sc.addTarget(self, action: #selector(segmentControlV), for: .valueChanged)
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    let label: UILabel = {
        let l = UILabel()
        return l
    }()
    
    @objc func segmentControlV(sender: UISegmentedControl){
        switch sender.selectedSegmentIndex {
        case 1:
            label.text = "0"
        case 2:
            label.text = "1"
        default:
            label.text = "1"
        }
    }
    
    var navigationTitle: UILabel = {
        let l = UILabel()
        let boldText = NSMutableAttributedString(string: "New Book", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16)])
        l.attributedText = boldText
        l.textColor = UIColor.white
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = navigationTitle
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backIndicatorImage = imgBackArrow
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = imgBackArrow
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "saveButtonIcon").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(saveBtnTapped(_:)))
        getCurrentDate()
        ref = Database.database().reference()
        storageRef = Storage.storage().reference()
        setupView()
        setupConstraints()
        
        if book != nil {
            self.newBookView.addBookImage.imageFromUrl(urlString: book.imageURL!)
            self.newBookView.authorTitle.text = book.author
            self.newBookView.bookTitle.text = book.title
            self.newBookView.numberOfPagesTitle.text = String(book.pageCount)
            self.newBookView.descriptionLabel.text = book.descript
        }
    }

    func addBookImageButton() {
        let photoVC = PhotoController()
        photoVC.delegate = self
        self.present(UINavigationController(rootViewController: photoVC), animated: true, completion: nil)
    }
    
    @objc func saveBtnTapped(_ sender: UIBarButtonItem) {
        guard let name = newBookView.bookTitle.text else { return }
        guard let author = newBookView.authorTitle.text else { return }
        guard let numOfPage = newBookView.numberOfPagesTitle.text else { return }
        guard let ttext = self.label.text else { return }
        guard let description = newBookView.descriptionLabel.text else { return }
        guard let gdatalabel = dateLabel.text else { return }
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        
        if let uploadData = UIImageJPEGRepresentation(newBookView.addBookImage.image!, 0.1) {
            
            storageRef.child("images/\(name).jpg").putData(uploadData, metadata: metaData) { (metadata, error) in
                if error != nil {
                    print(error?.localizedDescription as Any)
                    return
                }
                if let bookImageURL = metadata?.downloadURL()?.absoluteString {
                    let bookData = ["bookName": name,
                                    "bookAuthor": author,
                                    "totalPage": numOfPage,
                                    "imageURL": bookImageURL,
                                    "description": description,
                                    "addedDate": gdatalabel,
                                    "lastDate": ttext]
                    self.ref.child("users").child(FirebaseAPI.shared.userID!).child("books").childByAutoId().setValue(bookData) { (err, reference) in
                        if err != nil {
                            print(err?.localizedDescription as Any)
                        } else {
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            }
        }
    }
}

extension NewBookController {
    
    private func setupView(){
        let mainView = NewBookView(frame: self.view.frame)
        self.newBookView = mainView
        self.newBookView.addBookImageAction = addBookImageButton
        if bookImage != nil {
            self.newBookView.addBookImage.image = bookImage
        }
        self.view.addSubview(newBookView)
        self.view.addSubview(segmtControl)
    }
    private func setupConstraints(){
        newBookView.fillSuperView()
        segmtControl.centerYAnchor.constraint(equalTo: newBookView.willReadLabel.centerYAnchor).isActive = true
        segmtControl.anchor(top: nil, leading: nil, bottom: nil, trailing: newBookView.stackview.trailingAnchor, padding: .init(top: 15.0, left: 0.0, bottom: 0.0, right: 0.0), size: .init(width: self.view.frame.width/2.461, height: 25.0))
    }
}
