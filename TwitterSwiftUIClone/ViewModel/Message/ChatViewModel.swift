//
//  MessageViewModel.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 9/3/22.
//

import Foundation
import Firebase


final class ChatViewModel: ObservableObject{
    
    let user: User
    
    let messageRepository: MessageRepositoryProtocol
    @Published var messages = [Message]()
    
    init(user: User, repository: MessageRepositoryProtocol = MessageRepository()){
        self.user = user
        self.messageRepository = repository
    }
    
    func sendMessages(_ message: String){
        self.messageRepository.sendMessage(message, toUser: user)
    }
    
    func showMessages(){
        messageRepository.fetchMessages(withUser: user.uid ?? "") { messages in
            self.messages = messages
        }
    }

    
}
