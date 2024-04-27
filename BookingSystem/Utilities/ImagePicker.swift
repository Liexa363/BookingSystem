//
//  ImagePicker.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 27.04.2024.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) private var presentationMode
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var selectedImage: UIImage?
    var user: User
    var realmManager: RealmManager
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
                
                parent.downloadImageToDevice(image)
            }

            parent.presentationMode.wrappedValue.dismiss()
        }

    }
    
    
    func downloadImageToDevice(_ image: UIImage?) {
        // Convert UIImage to Data
        if let data = image?.jpegData(compressionQuality: 1.0) {
            // Get document directory URL
            if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                // Create file URL
                let imageName = "\(user.email)_profile_image.jpg"
                let fileURL = documentsDirectory.appendingPathComponent(imageName)
                
                if realmManager.updateUserPhotoName(userEmail: user.email, newPhotoName: fileURL.path) {
                    
                    do {
                        // Write data to file
                        try data.write(to: fileURL)
                        print("Image downloaded to: \(fileURL)")
                        // Set downloaded image URL to view
                    } catch {
                        print("Error saving image:", error)
                    }
                } else {
                    
                    print("Error updating user photo name")
                }
                
                
            }
        }
    }
    
}
