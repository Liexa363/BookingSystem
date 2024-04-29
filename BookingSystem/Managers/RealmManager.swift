//
//  RealmManager.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 25.04.2024.
//

import SwiftUI
import RealmSwift

class RealmManager: ObservableObject {
    var realm: Realm
    
    init() {
        do {
            self.realm = try Realm()
            
            print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!)
        } catch {
            fatalError("Error initializing Realm: \(error)")
        }
    }
    
    func registerUser(user: RealmUser) -> Bool {
        do {
            try realm.write {
                let userRealm = RealmUser()
                userRealm.id = user.id
                userRealm.name = user.name
                userRealm.surname = user.surname
                userRealm.phone = user.phone
                userRealm.photo = user.photo
                userRealm.email = user.email
                userRealm.password = user.password
                userRealm.role = user.role
                userRealm.date = String(Date.now.timeIntervalSince1970)
                
                realm.add(userRealm)
            }
            return true
        } catch {
            print("Error registering user: \(error)")
            return false
        }
    }
    
    func isEmailExists(email: String) -> Bool {
        let usersWithEmail = realm.objects(RealmUser.self).filter("email == %@", email)
        return !usersWithEmail.isEmpty
    }
    
    func getUser(by email: String, and password: String) -> User? {
        return realm.objects(RealmUser.self)
            .filter("email == %@ AND password == %@", email, password)
            .first
            .map { userRealm in
                return User(id: userRealm.id,
                            name: userRealm.name,
                            surname: userRealm.surname,
                            phone: userRealm.phone,
                            photo: userRealm.photo,
                            email: userRealm.email,
                            password: userRealm.password,
                            role: userRealm.role, date: userRealm.date)
            }
    }
    
    func login(by email: String, _ password: String, and role: String) {
        do {
            try realm.write {
                let credentials = Credentials()
                credentials.email = email
                credentials.password = password
                credentials.role = role
                
                realm.add(credentials)
            }
        } catch {
            print("Error saving credentials: \(error)")
        }
    }
    
    func logout() {
        do {
            try realm.write {
                realm.delete(realm.objects(Credentials.self))
            }
        } catch {
            print("Error deleting credentials: \(error)")
        }
    }
    
    func isLogined() -> Bool {
        return !realm.objects(Credentials.self).isEmpty
    }
    
    func getCredentials() -> Credentials? {
        return realm.objects(Credentials.self).first
    }
    
    func updateUserPhotoName(userEmail: String, newPhotoName: String) -> Bool {
        guard let user = realm.objects(RealmUser.self).filter("email == %@", userEmail).first else {
            print("User with email \(userEmail) not found")
            return false
        }
        do {
            try realm.write {
                user.photo = newPhotoName
            }
            return true
        } catch {
            print("Error updating user photo name: \(error)")
            return false
        }
    }
    
    func editUser(user: RealmUser) -> Bool {
        guard let tempUser = realm.objects(RealmUser.self).filter("id == %@", user.id).first else {
            print("User with id \(user.id) not found")
            return false
        }
        do {
            try realm.write {
                tempUser.name = user.name
                tempUser.surname = user.surname
                tempUser.phone = user.phone
                tempUser.email = user.email
                tempUser.password = user.password
                tempUser.role = user.role
            }
            return true
        } catch {
            print("Error updating user data: \(error)")
            return false
        }
    }
    
    func isEmailAlreadyTaken(byOtherUser email: String, userId: String) -> Bool {
        // Fetch the user with the provided ID
        guard let currentUser = realm.objects(RealmUser.self).filter("id == %@", userId).first else {
            print("User with ID \(userId) not found")
            return false
        }
        
        // Check if any other user has the provided email
        let usersWithSameEmail = realm.objects(RealmUser.self).filter("email == %@ AND NOT id == %@", email, userId)
        return !usersWithSameEmail.isEmpty
    }
    
    
    func getUsers() -> [User] {
        let realmUsers = realm.objects(RealmUser.self)
        var users: [User] = []
        for realmUser in realmUsers {
            let user = User(
                id: realmUser.id,
                name: realmUser.name,
                surname: realmUser.surname,
                phone: realmUser.phone,
                photo: realmUser.photo,
                email: realmUser.email,
                password: realmUser.password,
                role: realmUser.role,
                date: realmUser.date
            )
            users.append(user)
        }
        
        users.sort { $0.date < $1.date }
        return users
    }
    
    func deleteUser(withId userId: String) -> Bool {
        guard let userToDelete = realm.objects(RealmUser.self).filter("id == %@", userId).first else {
            print("User with ID \(userId) not found")
            return false
        }
        
        do {
            try realm.write {
                realm.delete(userToDelete)
            }
            return true
        } catch {
            print("Error deleting user: \(error)")
            return false
        }
    }
    
    func addCar(car: RealmCar) -> Bool {
        do {
            try realm.write {
                realm.add(car)
            }
            return true
        } catch {
            print("Error registering car: \(error)")
            return false
        }
    }
    
    func isCarExist(forUserID userID: String) -> Bool {
        let carsWithUserID = realm.objects(RealmCar.self).filter("ownerID == %@", userID)
        return !carsWithUserID.isEmpty
    }
    
    func getCar(byOwnerID ownerID: String) -> Car? {
        if let realmCar = realm.objects(RealmCar.self).filter("ownerID == %@", ownerID).first {
            let car = Car(
                id: realmCar.id,
                brand: realmCar.brand,
                model: realmCar.model,
                year: realmCar.year,
                bodyType: realmCar.bodyType,
                fuel: realmCar.fuel,
                engineCapacity: realmCar.engineCapacity,
                transmission: realmCar.transmission,
                color: realmCar.color,
                registrationNumber: realmCar.registrationNumber,
                ownerID: realmCar.ownerID
            )
            return car
        } else {
            return nil
        }
    }
    
    func editCar(withNewCarData newCarData: Car) -> Bool {
        guard let carToUpdate = realm.objects(RealmCar.self).filter("ownerID == %@", newCarData.ownerID).first else {
            print("Car with ownerID \(newCarData.ownerID) not found")
            return false
        }
        do {
            try realm.write {
                carToUpdate.brand = newCarData.brand
                carToUpdate.model = newCarData.model
                carToUpdate.year = newCarData.year
                carToUpdate.bodyType = newCarData.bodyType
                carToUpdate.fuel = newCarData.fuel
                carToUpdate.engineCapacity = newCarData.engineCapacity
                carToUpdate.transmission = newCarData.transmission
                carToUpdate.color = newCarData.color
                carToUpdate.registrationNumber = newCarData.registrationNumber
            }
            return true
        } catch {
            print("Error updating car data: \(error)")
            return false
        }
    }
    
}

