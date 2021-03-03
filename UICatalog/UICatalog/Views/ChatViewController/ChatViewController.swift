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
    
    private var messages: [MessageType] = []
    private let senderId1 = UUID().uuidString
    private let senderId2 = UUID().uuidString

    override func viewDidLoad() {
        super.viewDidLoad()
        self.messagesCollectionView.messagesDataSource = self
        self.messagesCollectionView.messagesLayoutDelegate = self
        self.messagesCollectionView.messagesDisplayDelegate = self
        self.setup()
        self.messagesCollectionView.scrollToBottom()
        self.maintainPositionOnKeyboardFrameChanged = true
    }
    
    private func setup() {
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

extension ChatViewController: MessagesDataSource {
    func currentSender() -> SenderType {
        return Sender(senderId: senderId1, displayName: "Me")
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return self.messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return self.messages.count
    }
    
    
}

extension ChatViewController: MessagesLayoutDelegate {
    
}

extension ChatViewController: MessagesDisplayDelegate {
    
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
