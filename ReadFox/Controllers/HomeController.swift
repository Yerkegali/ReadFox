//
//  HomeViewController.swift
//  ReadFox
//
//  Created by Yerkegali Abubakirov on 02.04.2018.
//  Copyright © 2018 Yerkegali Abubakirov. All rights reserved.
//

import UIKit
import Firebase

class HomeController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var homeView: HomeView!
    var readingBooks = [Book]()
    var mustReadBooks = [Book]()
    var thirdArray = [Book]()
    
    let tableView: UITableView = {
        let t = UITableView()
        t.separatorStyle = .singleLine
        t.backgroundColor = UIColor(white: 1, alpha: 0.0)
        return t
    }()
    
    let tableViewCell: UITableViewCell = {
        let tCell = UITableViewCell()
        return tCell
    }()

    var appUser: AppUser? {
        didSet {
            print("value set")
        }
    }
    
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plusIcon").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(plusBtnPressed))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "leftArrowIcon")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "leftArrowIcon")
        navigationController?.navigationBar.backItem?.title = ""
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.tableView.separatorStyle = .none
        setupView()
        setupConstraints()
        tableView.register(BooksTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        fetchBooks()

    }
 
    @objc func plusBtnPressed() {
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(SearchController(), animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    
    func fetchBooks(){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("users").child(uid).child("books").observe(.value) { (snapshot) in
            guard let value = snapshot.value as? NSDictionary else { return }
            self.readingBooks = []
            self.mustReadBooks = []
            value.forEach({ (dict) in
                guard let bookID = dict.key as? String else { return }
                guard let bookData = dict.value as? NSDictionary else { return }
                let book = Book(value: bookData)
                book.bookID = bookID
                DispatchQueue.main.async {
                    if book.lastDate == 0 {
                        self.readingBooks.append(book)
                    } else if book.lastDate == 1 {
                        self.mustReadBooks.append(book)
                    }
                    
                    self.thirdArray = self.readingBooks
                    self.tableView.reloadData()
                    
                    if self.homeView.tag == 1 {
                        self.thirdArray = []
                        if self.thirdArray.isEmpty == true {
                            self.thirdArray = self.mustReadBooks
                            self.tableView.reloadData()
                        }
                    }
                    
                    if self.readingBooks.count != 0 {
                        self.homeView.readingtLabel.isHidden = true
                        self.homeView.middleStackView.isHidden = true
                    }
                }
            })
        }
    }
}

extension HomeController{
    
    private func setupView(){

        let mainView = HomeView(frame: view.frame)
        self.homeView = mainView
        self.homeView.plusBtnAction = plusBtnPressed
        self.view.addSubview(homeView)
        
        view.backgroundColor = UIColor.green
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor(r: 242.0, g: 126.0, b: 82.0, alpha: 1.0).cgColor, UIColor(r: 255.0, g: 53.0, b: 108.0, alpha: 1.0).cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        
        self.view.addSubview(tableView)
    }
    
    private func setupConstraints(){
        homeView.fillSuperView()
        tableView.anchor(top: homeView.topStackView.bottomAnchor, leading: view.leadingAnchor, bottom: self.view.safeBottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 25, left: 8, bottom: 0, right: 8))
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thirdArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BooksTableViewCell
        let book = thirdArray[indexPath.row]
        cell.titleLabel.text = book.title
        cell.authorLabel.text = book.author
        cell.bookImageView.imageFromUrl(urlString: book.imageURL)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let readingBookVC = ReadingBookViewController()
        readingBookVC.book = thirdArray[indexPath.row]
        self.navigationController?.pushViewController(readingBookVC, animated: true)

    }
}
