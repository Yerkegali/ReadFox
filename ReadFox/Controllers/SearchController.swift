//
//  SearchController.swift
//  ReadFox
//
//  Created by Yerkegali Abubakirov on 15.05.2018.
//  Copyright © 2018 Yerkegali Abubakirov. All rights reserved.
//

import UIKit

class SearchController: UIViewController {
    
    let imgBackArrow = UIImage(named: "leftArrowIcon")
    
    var gradientLayer: CAGradientLayer!
    
    var books = [Book]()
    
    lazy var searchBar: UISearchBar! = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Book name..."
        searchBar.tintColor = UIColor.red
        return searchBar
    }()
    
    let tableView: UITableView = {
        let t = UITableView()
        t.separatorStyle = .singleLine
        return t
    }()
    
    let tableViewCell: UITableViewCell = {
        let tCell = UITableViewCell()
        return tCell
    }()
    
    var navigationTitle: UILabel = {
        let l = UILabel()
        let boldText = NSMutableAttributedString(string: "Search", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16)])
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Own Book", style: .plain, target: self, action: #selector(pushToOwnBook))
        setupView()
        setupConstraints()
        createGradienLayer()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BookItemTableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    func createGradienLayer() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor(r: 242.0, g: 126.0, b: 82.0, alpha: 1.0).cgColor, UIColor(r: 255.0, g: 53.0, b: 108.0, alpha: 1.0).cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    @objc func pushToOwnBook() {
        let newBookVC = NewBookController()
        self.navigationController?.pushViewController(newBookVC, animated: true)
    }
    
    func getBooks(query: String){
        view.endEditing(true)
        let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = "https://www.googleapis.com/books/v1/volumes?q=\(query)"
        
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            if (error != nil) {
                print(error?.localizedDescription ?? "")
            } else {
                let json = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: AnyObject]
                
                if let items = json["items"] as? [[String: AnyObject]] {
                    
                    self.books = []
                    for item in items {
                        if let volumeInfo = item["volumeInfo"] as? [String: AnyObject] {
                            let book = Book()
                            book.title = volumeInfo["title"] as? String
                            if let imageLinks = volumeInfo["imageLinks"] as? [String: String] {
                                book.imageURL = imageLinks["thumbnail"]
                            }
                            
                            guard let pageCount = volumeInfo["pageCount"] as? Int else { return }
                            book.pageCount = pageCount
                            
                            book.descript = volumeInfo["description"] as? String
                            
                            guard let authors = volumeInfo["authors"] as? [String] else { return }
                            book.author = authors.joined(separator: ",")
                            self.books.append(book)
                        }
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }.resume()
    }
    
}

extension SearchController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BookItemTableViewCell
        let book = books[indexPath.row]
        cell.titleLabel.text = book.title
        cell.bookImageView.imageFromUrl(urlString: book.imageURL ?? "")
        cell.authorLabel.text = book.author
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newBookVC = NewBookController()
        newBookVC.book = books[indexPath.row]
        self.navigationController?.pushViewController(newBookVC, animated: true)
    }
}

extension SearchController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let text = searchBar.text
        self.getBooks(query: text!)
    }
    
    private func setupView(){
        [searchBar, tableView].forEach(){
            self.view.addSubview($0)
        }
    }
    
    private func setupConstraints(){
        searchBar.anchor(top: self.view.safeTopAnchor, leading: self.view.safeLeadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0), size: .init(width: 0, height: 56.0))
        tableView.anchor(top: searchBar.bottomAnchor, leading: view.leadingAnchor, bottom: self.view.safeBottomAnchor, trailing: view.trailingAnchor)
    }
}
