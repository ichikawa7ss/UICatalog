//
//  ChatDateLabel.swift
//  UICatalog
//
//  Created by ichikawa on 2021/03/03.
//  Copyright © 2021 ichikawa. All rights reserved.
//

import UIKit

final class ChatDateLabel: UILabel {
    
    func configure(_ parent: UIView, dateString: String, isMe: Bool) {
        self.text = dateString
        
        self.textColor = UIColor.gray
        self.font = UIFont(name: "HiraginoSans-W3", size: 10)!
        
        // constraints
        self.translatesAutoresizingMaskIntoConstraints = false
        self.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: 0).isActive = true
        if isMe {
            self.trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: 0).isActive = true
        }
        else {
            self.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 0).isActive = true
        }
        self.widthAnchor.constraint(equalToConstant: 30).isActive = true
        self.heightAnchor.constraint(equalToConstant: 16).isActive = true
    }
}
