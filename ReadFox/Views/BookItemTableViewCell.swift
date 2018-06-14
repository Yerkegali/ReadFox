//
//  BookItemTableViewCell.swift
//  ReadFox
//
//  Created by Yerkegali Abubakirov on 16.05.2018.
//  Copyright © 2018 Yerkegali Abubakirov. All rights reserved.
//

import UIKit

class BookItemTableViewCell: UITableViewCell {

    let bookImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let authorLabel: UILabel = {
        let l = UILabel()
        return l
    }()
    
    let titleLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        return l
    }()
    
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
        bookImageView.image = nil
        titleLabel.text = ""
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}

extension BookItemTableViewCell {
    
    private func setupView(){
        addSubview(bookImageView)
        addSubview(titleLabel)
        addSubview(authorLabel)
    }
    private func setupConstraints(){
        bookImageView.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 8, bottom: 0, right: 0), size: .init(width: 120, height: 120))
        titleLabel.anchor(top: topAnchor, leading: bookImageView.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 10))
        authorLabel.anchor(top: topAnchor, leading: bookImageView.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 90, left: 10, bottom: 0, right: 10))
    }
}
