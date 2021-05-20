//
//  SearchTableViewHeader.swift
//  Reminder
//
//  Created by aytug on 20.05.2021.
//

import UIKit

class SearchTableViewHeader: UITableViewHeaderFooterView {
    private let title = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureContents() {
        contentView.backgroundColor = .white
        title.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(title)
        NSLayoutConstraint.activate([
            title.heightAnchor.constraint(equalToConstant: 30),
            title.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            title.trailingAnchor.constraint(equalTo:
                                                contentView.layoutMarginsGuide.trailingAnchor),
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configure(text: String, color: UIColor) {
        let attribute: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(24), weight: .semibold),
                                                         NSAttributedString.Key.foregroundColor: color]
                        
        title.attributedText = NSAttributedString(string: text, attributes: attribute)
    }
    
}
