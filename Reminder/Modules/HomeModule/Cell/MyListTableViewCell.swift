//
//  MyListTableViewCell.swift
//  Reminder
//
//  Created by aytug on 13.05.2021.
//

import UIKit

class MyListTableViewCell: UITableViewCell {
    @IBOutlet weak var listImageView: UIImageView!
    @IBOutlet weak var listImageViewBackgroundView: UIView!
    
    func configure() {
        layoutIfNeeded()
        listImageViewBackgroundView.layer.cornerRadius = listImageViewBackgroundView.frame.width / 2
    }
    
}
