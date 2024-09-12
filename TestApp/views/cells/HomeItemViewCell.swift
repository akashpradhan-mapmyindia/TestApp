//
//  HomeItemViewCell.swift
//  TestApp
//
//  Created by rento on 06/09/24.
//

import UIKit

class HomeItemViewCell: UITableViewCell {
    static let identifier: String = "HomeItemViewCell"
    
    var bgView: UIView!
    var titleLbl: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        bgView = UIView()
        contentView.addSubview(bgView)
        bgView.layer.cornerRadius = 10
        bgView.translatesAutoresizingMaskIntoConstraints = false
        bgView.layer.borderColor = UIColor.gray.cgColor
        bgView.layer.borderWidth = 1
        bgView.backgroundColor = UIColor(red: 51/255, green: 158/255, blue: 130/255, alpha: 1.0)

        NSLayoutConstraint.activate([
            bgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bgView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            bgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
        
        titleLbl = UILabel()
        contentView.addSubview(titleLbl)
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.backgroundColor = .clear
        titleLbl.numberOfLines = 0
        titleLbl.textAlignment = .center
        
        NSLayoutConstraint.activate([
            titleLbl.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 10),
            titleLbl.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 10),
            titleLbl.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -10),
            titleLbl.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
