//
//  MessageViewModel.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 9/3/22.
//

import SwiftUI

final class MessageViewModel: ObservableObject{
    @Published var recentMessages = [Message]()
    
    private var messageRepository: MessageRepositoryProtocol
    
    init(repository: MessageRepositoryProtocol = MessageRepository()){
        self.messageRepository = repository
        fetchRecentMessages()
    }
    
    func fetchRecentMessages(){
        messageRepository.fetchRecentMessages { recentMessage in
            self.recentMessages = recentMessage
        }
    }
    
    
    
}

