//
//  ChatViewController.swift
//  UICatalog
//
//  Created by ichikawa on 2021/01/08.
//  Copyright © 2021 ichikawa. All rights reserved.
//

import UIKit
import MessageKit

final class ChatViewController: MessagesViewController {
    
    var messages: [MessageType] = []
    let senderId1 = UUID().uuidString
    let senderId2 = UUID().uuidString

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.messagesCollectionView.scrollToBottom()
    }
    
    private func setup() {
        self.setupData()
        self.setInputBarPreference()
        self.setupMessageKitProtocol()
        self.setupMessageKitComponetLayout()
    }
    
    private func setupData() {
        for i in 1...100 {
            var senderId: String
            if i % 2 == 0 {
                senderId = self.senderId1
            }
            else {
                senderId = self.senderId2
            }
            let sender = Sender(senderId: senderId, displayName: "me")
            let message = Message(sender: sender, messageId: String(i), sentDate: Date(), kind: .text("\(i): あいうえおかきくけこさしすせそたちつてと"))
            self.messages.append(message)
        }
    }
}

struct Sender: SenderType {
    let senderId: String
    let displayName: String
}

struct Message: MessageType {
    let sender: SenderType
    let messageId: String
    let sentDate: Date
    let kind: MessageKind
}
