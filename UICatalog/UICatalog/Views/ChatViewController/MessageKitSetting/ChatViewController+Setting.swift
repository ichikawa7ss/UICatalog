//
//  ChatViewController+Setting.swift
//  UICatalog
//
//  Created by ichikawa on 2021/03/03.
//  Copyright © 2021 ichikawa. All rights reserved.
//

import UIKit
import MessageKit
import InputBarAccessoryView

// MARK: - Setup
extension ChatViewController {
    
    /// MessageKitのDelegateとDataSourceをセット
    func setupMessageKitProtocol() {
        self.messagesCollectionView.messagesDataSource = self
        self.messagesCollectionView.messagesLayoutDelegate = self
        self.messagesCollectionView.messagesDisplayDelegate = self
        self.messageInputBar.delegate = self
    }
    
    ///　bubbleViewの設定
    func setupMessageKitComponetLayout() {
        
        guard let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout else {
            return
        }
        
        // avatarView
        layout.setMessageOutgoingAvatarSize(.zero)
        layout.setMessageIncomingAvatarSize(CGSize(width: 48, height: 48))
        layout.setMessageIncomingAvatarPosition(AvatarPosition(vertical: .cellTop))
        
        // accessoryView
        let bubbleWidth = UIScreen.main.bounds.width * 240 / 375
        let outgoingAccessoryViewWidth = UIScreen.main.bounds.width - bubbleWidth - (8 * 2) - 8 - 4
        let incomingAccessoryViewWidth = UIScreen.main.bounds.width - bubbleWidth - (8 * 2) - 48 - 8 - 8
        layout.setMessageIncomingAccessoryViewSize(CGSize(width: incomingAccessoryViewWidth, height: 16))
        layout.setMessageIncomingAccessoryViewPadding(HorizontalEdgeInsets(left: 4, right: 0))
        layout.setMessageIncomingAccessoryViewPosition(.messageBottom)
        layout.setMessageOutgoingAccessoryViewSize(CGSize(width: outgoingAccessoryViewWidth, height: 16))
        layout.setMessageOutgoingAccessoryViewPadding(HorizontalEdgeInsets(left: 0, right: 4))
        layout.setMessageOutgoingAccessoryViewPosition(.messageBottom)
        
        // messageContainerView
        layout.setMessageIncomingMessagePadding(UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0))
        layout.setMessageOutgoingMessagePadding(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8))
    }
    
    /// InputBarの見た目の設定
    func setInputBarPreference() {
        // inputBar全体
        messageInputBar.padding = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        self.messageInputBar.setRightStackViewWidthConstant(to: 32, animated: false)
        self.messageInputBar.setLeftStackViewWidthConstant(to: 32, animated: false)

        // 送信ボタン
        self.messageInputBar.sendButton.setSize(CGSize(width: 32, height: 40), animated: false)
        self.messageInputBar.sendButton.center = self.messageInputBar.sendButton.superview!.center
        self.messageInputBar.sendButton.image = UIImage(named: "iconSend")
        self.messageInputBar.sendButton.title = nil
        
        // メッセージ入力欄
        messageInputBar.inputTextView.textContainerInset = UIEdgeInsets(top: 10, left: 14, bottom: 10, right: 14)
        messageInputBar.inputTextView.textContainer.lineFragmentPadding = 0
        messageInputBar.inputTextView.backgroundColor = UIColor(hex: "E9EEF1")
        messageInputBar.inputTextView.cornerRadius = 20
        // ヒラギノを指定するとカーソル位置と文章がずれるのでデフォルトで
        messageInputBar.inputTextView.placeholder = "ここにテキストを入力してください"
    }
}

// MARK: - MessageDataSource
// DataSourceの名の通りメッセージの内容をセットする時に呼ばれる
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

// MARK: - MessagesLayoutDelegate
// bubbleViewまわりのframe周りのレイアウト関連の処理で呼ばれる
extension ChatViewController: MessagesLayoutDelegate {
    
    func messageBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 20
    }
}

// MARK: - MessagesLayoutDelegate
// バブルの部分的な描画処理や、アクセサリービューやアバタービューの描画のときに呼ばれる。ここでaddSubViewすることでいい感じにレイアウトを組む
extension ChatViewController: MessagesDisplayDelegate {
    
    // メッセージの色 自分 → 白 / 相手 → 黒
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? UIColor(hex: "F9FBFC") : UIColor(hex: "333333")
    }
    
    // メッセージの背景色 自分 → green / 相手 → グレー
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? UIColor(hex: "0DBEA9") : UIColor(hex: "E1EDF2")
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        // 初期化
        avatarView.subviews.forEach {
            $0.removeFromSuperview()
        }
        
        // 相手のみアイコンを表示
        if !self.isFromCurrentSender(message: message) {
            // subViewにシャドーをつけるためにfalseにしておく
            avatarView.clipsToBounds = false

            // avatarViewにUserIconViewをaddする
            let userIconView = UserIconView()
            let avaterSize = avatarView.frame.size
            userIconView.configure(UIImage(named: "imageWoman")!, isEnableTouchIcon: false, frame: CGRect(origin: .zero, size: avaterSize))
            avatarView.addSubview(userIconView)
        }
    }
    
    func configureAccessoryView(_ accessoryView: UIView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        // 初期化
        accessoryView.subviews.forEach {
            $0.removeFromSuperview()
        }
        
        // 時間に関するsubViewをつける
        let label = ChatDateLabel()
        accessoryView.addSubview(label)
        let dateString = "11:11"
        label.configure(accessoryView, dateString: dateString, isMe: self.isFromCurrentSender(message: message))
    }
}

extension ChatViewController: InputBarAccessoryViewDelegate {

    @objc
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        inputBar.inputTextView.text = ""
    }
}
