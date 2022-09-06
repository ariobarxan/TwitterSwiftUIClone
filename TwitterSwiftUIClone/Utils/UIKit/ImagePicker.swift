//
//  ImagePicker.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/26/22.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable{
    
    @Binding var image: UIImage?
    
    @Environment(\.dismiss) var dismissView
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let imgPicker      = UIImagePickerController()
        imgPicker.delegate = context.coordinator
        
        return imgPicker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

extension ImagePicker{
    //MARK: - Coordinator
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
        private let parent: ImagePicker
        
        init(_ parent: ImagePicker){
            self.parent = parent
        }
        
        
        //MARK: - ImagePicke
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let image = info[.originalImage] as? UIImage else {return}
            parent.image    = image
            parent.dismissView()
        }
    }
    
    
}

