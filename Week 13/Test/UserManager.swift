//
//  UserManager.swift
//  Test
//
//  Created by Muhammad Ali Asgar Fataymamode on 04/12/2024.
//




import FirebaseAuth
import FirebaseFirestore

class UserManager: ObservableObject {
    @Published var isLoggedIn = false
    @Published var currentUser: UserModel?

    private let db = Firestore.firestore()
    private let auth = Auth.auth()

    init() {
       
        logout()
    }

    func addUserWithDetails(
        email: String,
        username: String,
        password: String,
        age: Int,
        country: String,
        skillLevel: String,
        preferredPosition: String,
        trainingGoals: String,
        experience: String,
        height: Double,
        weight: Int,
        selectedDays: [String],
        trainingDuration: Int,
        notificationPreference: String,
        profileImage: UIImage?,
        completion: @escaping (Bool, Error?) -> Void
    ) {
        
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                completion(false, error)
                return
            }

            guard let userId = result?.user.uid else { return }

            
            var userData: [String: Any] = [
                "email": email,
                "username": username,
                "age": age,
                "country": country,
                "skillLevel": skillLevel,
                "preferredPosition": preferredPosition,
                "trainingGoals": trainingGoals,
                "experience": experience,
                "height": height,
                "weight": weight,
                "selectedDays": selectedDays,
                "trainingDuration": trainingDuration,
                "notificationPreference": notificationPreference,
                "profileImagePath": ""
            ]

            if let profileImage = profileImage {
                let imagePath = self?.saveImageLocally(image: profileImage, userId: userId) ?? ""
                userData["profileImagePath"] = imagePath
            }

            
            self?.db.collection("users").document(userId).setData(userData) { error in
                if let error = error {
                    completion(false, error)
                } else {
                    self?.isLoggedIn = true
                    self?.fetchCurrentUser()
                    completion(true, nil)
                }
            }
        }
    }

    func fetchCurrentUser() {
        guard let userId = auth.currentUser?.uid else { return }

        
        db.collection("users").document(userId).getDocument { [weak self] document, error in
            if let error = error {
                print("Error fetching user: \(error)")
                return
            }

            guard let data = document?.data() else { return }

            
            self?.currentUser = UserModel(
                uid: userId,
                username: data["username"] as? String ?? "",
                email: data["email"] as? String ?? "",
                age: data["age"] as? Int ?? 0,
                country: data["country"] as? String ?? "",
                skillLevel: data["skillLevel"] as? String ?? "",
                preferredPosition: data["preferredPosition"] as? String ?? "",
                trainingGoals: data["trainingGoals"] as? String ?? "",
                experience: data["experience"] as? String ?? "",
                height: data["height"] as? Double ?? 0.0,
                weight: data["weight"] as? Int ?? 0,
                selectedDays: data["selectedDays"] as? [String] ?? [],
                trainingDuration: data["trainingDuration"] as? Int ?? 0,
                notificationPreference: data["notificationPreference"] as? String ?? "",
                profileImagePath: data["profileImagePath"] as? String ?? ""
            )
        }
    }

    func login(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                completion(false, error)
                return
            }

            self?.isLoggedIn = true
            self?.fetchCurrentUser()
            completion(true, nil)
        }
    }

    func logout() {
        do {
            try auth.signOut()
            isLoggedIn = false
            currentUser = nil
        } catch {
            print("Error during logout: \(error)")
        }
    }

    private func saveImageLocally(image: UIImage, userId: String) -> String {
        
        guard let data = image.jpegData(compressionQuality: 0.8),
              let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return ""
        }

        let imagePath = directory.appendingPathComponent("\(userId).jpg")
        do {
            try data.write(to: imagePath)
            return imagePath.path
        } catch {
            print("Error saving image locally: \(error)")
            return ""
        }
    }
}


