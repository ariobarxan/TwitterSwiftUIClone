//
//  MessageViewModel.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 9/3/22.
//

import Foundation
import Firebase


struct ChatViewModel{
    
    let user: User
    
    let messageRepository: MessageRepositoryProtocol
    
    init(user: User, repository: MessageRepositoryProtocol = MessageRepository()){
        self.user = user
        self.messageRepository = repository
    }
    
    func sendMessages(_ message: String){
        self.messageRepository.sendMessage(message, toUser: user)
    }
    

    
}
