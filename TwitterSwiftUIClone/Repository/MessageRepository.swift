//
//  MessageRepository.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 9/3/22.
//

import Foundation

protocol MessageRepositoryProtocol{
    func sendMessage(_ messageText: String, toUser user: User)
    
    func fetchRecentMessages(completion: @escaping (_ recentMessages: [Message]) -> ())
}

final class MessageRepository: MessageRepositoryProtocol{
    
    private var messageAPIService: MessageAPIServiceProtocol
    private var recentMessagesDictionary = [String: Message]()
    
    
    init(APIService: MessageAPIServiceProtocol = MessageAPIService()){
        self.messageAPIService = APIService
    }
    
    func sendMessage(_ messageText: String, toUser user: User){
        self.messageAPIService.sendMessage(messageText, toUser: user)
    }
    
    func fetchRecentMessages(completion: @escaping (_ recentMessages: [Message]) -> ()){
        messageAPIService.fetchRecentMessage { user, messageDict in
            self.recentMessagesDictionary[user.uid ?? ""] = Message(user: user, dictionary: messageDict)
            
            let recentMessages = Array(self.recentMessagesDictionary.values)
            
            completion(recentMessages)
        }
    }
}
///We used the dictionary to prevent duplication in showing messages.
