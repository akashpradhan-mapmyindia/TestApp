//
//  HomeSectionHeaderView.swift
//  TestApp
//
//  Created by rento on 06/09/24.
//

import UIKit

class HomeSectionHeaderView: UIView {
    var titleLbl: UILabel!
    
    convenience init(title: String){
        self.init(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
        
        backgroundColor = .lightGray
        
        self.titleLbl = UILabel()
        titleLbl.text = title
        titleLbl.font = .systemFont(ofSize: 20, weight: .light)
        addSubview(titleLbl)
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.textAlignment = .center
        titleLbl.backgroundColor = UIColor(red: 251/255, green: 247/255, blue: 245/255, alpha: 1.0)
        
        NSLayoutConstraint.activate([
            titleLbl.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLbl.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLbl.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            titleLbl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
}
