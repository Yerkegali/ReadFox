//
//  BooksTableViewCell.swift
//  ReadFox
//
//  Created by Yerkegali Abubakirov on 25.05.2018.
//  Copyright © 2018 Yerkegali Abubakirov. All rights reserved.
//

import UIKit

class BooksTableViewCell: UITableViewCell {

    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    let bookImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let authorLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 8)
        l.numberOfLines = 1
        return l
    }()
    
    let titleLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 12)
        l.numberOfLines = 1
        return l
    }()
    
    var mainStackView: UIStackView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        setupView()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension BooksTableViewCell {
    
    private func setupView(){
        
        self.layer.cornerRadius = 5
        self.backgroundColor = .clear
        self.layer.masksToBounds = true
        mainStackView = UIStackView(arrangedSubviews: [titleLabel, authorLabel])
        mainStackView.axis = .vertical
        mainStackView.distribution = .equalSpacing
        addSubview(containerView)
        
        containerView.addSubview(bookImageView)
        containerView.addSubview(mainStackView)

    }
    private func setupConstraints(){
        
        containerView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 2, left: 0, bottom: 2, right: 0))
        
        bookImageView.anchor(top: nil, leading: containerView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 8, bottom: 0, right: 0), size: .init(width: 29, height: 44))
        bookImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        
        mainStackView.anchor(top: bookImageView.topAnchor, leading: bookImageView.trailingAnchor, bottom: bookImageView.bottomAnchor, trailing: containerView.trailingAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 10))
    }
}
