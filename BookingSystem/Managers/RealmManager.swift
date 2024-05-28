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
    
    func getCars() -> [Car] {
        let realmCars = realm.objects(RealmCar.self)
        var cars: [Car] = []
        for realmCar in realmCars {
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
            cars.append(car)
        }
        return cars
    }
    
    func deleteCar(byID id: String) -> Bool {
        guard let carToDelete = realm.objects(RealmCar.self).filter("id == %@", id).first else {
            print("Car with ID \(id) not found")
            return false
        }
        
        do {
            try realm.write {
                realm.delete(carToDelete)
            }
            return true
        } catch {
            print("Error deleting car: \(error)")
            return false
        }
    }
    
    func getUser(byOwnerID ownerID: String) -> User? {
        if let car = realm.objects(RealmCar.self).filter("ownerID == %@", ownerID).first {
            
            return realm.objects(RealmUser.self)
                .filter("id == %@", car.ownerID)
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
            
        } else {
            print("No car found for owner ID: \(ownerID)")
            return nil
        }
    }
    
    func isServiceStationExists(forManagerID managerID: String) -> Bool {
        let predicate = NSPredicate(format: "managerID == %@", managerID)
        let results = realm.objects(RealmServiceStation.self).filter(predicate)
        return !results.isEmpty
    }
    
    func getServiceStation(byManagerID managerID: String) -> ServiceStation? {
        // Attempt to find the RealmServiceStation object by managerID
        if let realmServiceStation = realm.objects(RealmServiceStation.self).filter("managerID == %@", managerID).first {
            
            // Map RealmLocation to Location
            let location = Location(
                country: realmServiceStation.location?.country ?? "",
                city: realmServiceStation.location?.city ?? "",
                street: realmServiceStation.location?.street ?? "",
                houseNumber: realmServiceStation.location?.houseNumber ?? ""
            )
            
            // Map each RealmService to Service
            let services = Array(realmServiceStation.services.map { realmService in
                return Service(
                    name: realmService.name,
                    serviceDescription: realmService.serviceDescription,
                    price: realmService.price
                )
            })
            
            // Map each RealmWorkSchedule to WorkSchedule
            let workSchedule = Array(realmServiceStation.workSchedule.map { realmWorkSchedule in
                return WorkSchedule(
                    day: realmWorkSchedule.day,
                    startTime: realmWorkSchedule.startTime,
                    endTime: realmWorkSchedule.endTime,
                    interval: realmWorkSchedule.interval
                )
            })
            
            // Map each RealmFeedback to Feedback
            let feedbackList = Array(realmServiceStation.feedbackList.map { realmFeedback in
                return Feedback(
                    id: realmFeedback.id,
                    rating: realmFeedback.rating,
                    text: realmFeedback.text,
                    date: realmFeedback.date, 
                    author: realmFeedback.author, 
                    serviceStationID: realmFeedback.serviceStationID
                )
            })
            
            // Map each RealmMastersInServiceStation to MastersInServiceStation
            let masters = Array(realmServiceStation.masters.map { realmMaster in
                return Masters(
                    serviceStationID: realmMaster.serviceStationID,
                    masterEmail: realmMaster.masterEmail
                )
            })
            
            // Create the ServiceStation object
            let serviceStation = ServiceStation(
                id: realmServiceStation.id,
                name: realmServiceStation.name,
                location: location,
                services: services,
                managerID: realmServiceStation.managerID,
                workSchedule: workSchedule,
                feedbackList: feedbackList, 
                masters: masters
            )
            
            return serviceStation
        } else {
            return nil
        }
    }

    
    func addServiceStation(serviceStation: RealmServiceStation) -> Bool {
        do {
            try realm.write {
                realm.add(serviceStation)
            }
            return true
        } catch {
            print("Error adding service station: \(error)")
            return false
        }
    }
    
    func editServiceStation(withNewServiceStationData newServiceStationData: ServiceStation) -> Bool {
        guard let existingStation = realm.objects(RealmServiceStation.self).filter("id == %@", newServiceStationData.id).first else {
            print("Service Station with ID \(newServiceStationData.id) not found")
            return false
        }
        
        do {
            try realm.write {
                // Update the existing service station's properties with the new data
                existingStation.name = newServiceStationData.name
                existingStation.location?.country = newServiceStationData.location.country
                existingStation.location?.city = newServiceStationData.location.city
                existingStation.location?.street = newServiceStationData.location.street
                existingStation.location?.houseNumber = newServiceStationData.location.houseNumber
                
                // Delete existing work schedules
                realm.delete(existingStation.workSchedule)
                
                // Add new work schedules
                newServiceStationData.workSchedule.forEach { schedule in
                    let tempWorkSchedule = RealmWorkSchedule()
                    tempWorkSchedule.day = schedule.day
                    tempWorkSchedule.startTime = schedule.startTime
                    tempWorkSchedule.endTime = schedule.endTime
                    tempWorkSchedule.interval = schedule.interval
                    
                    existingStation.workSchedule.append(tempWorkSchedule)
                }
                
                // Delete existing services
                realm.delete(existingStation.services)
                
                // Add new services
                newServiceStationData.services.forEach { service in
                    let tempService = RealmService()
                    tempService.name = service.name
                    tempService.serviceDescription = service.serviceDescription
                    tempService.price = service.price
                    
                    existingStation.services.append(tempService)
                }
                
            }
            return true
        } catch {
            print("Error editing service station: \(error)")
            return false
        }
    }


    
    func getServiceStations() -> [ServiceStation] {
        let realmServiceStations = realm.objects(RealmServiceStation.self)
        var serviceStations: [ServiceStation] = []
        
        for realmServiceStation in realmServiceStations {
            let location = Location(
                country: realmServiceStation.location?.country ?? "",
                city: realmServiceStation.location?.city ?? "",
                street: realmServiceStation.location?.street ?? "",
                houseNumber: realmServiceStation.location?.houseNumber ?? ""
            )
            
            let services = Array(realmServiceStation.services.map { realmService in
                Service(
                    name: realmService.name,
                    serviceDescription: realmService.serviceDescription,
                    price: realmService.price
                )
            })
            
            let workSchedule = Array(realmServiceStation.workSchedule.map { realmWorkSchedule in
                WorkSchedule(
                    day: realmWorkSchedule.day,
                    startTime: realmWorkSchedule.startTime,
                    endTime: realmWorkSchedule.endTime,
                    interval: realmWorkSchedule.interval
                )
            })
            
            let feedbackList = Array(realmServiceStation.feedbackList.map { realmFeedback in
                Feedback(
                    id: realmFeedback.id,
                    rating: realmFeedback.rating,
                    text: realmFeedback.text,
                    date: realmFeedback.date, 
                    author: realmFeedback.author, 
                    serviceStationID: realmFeedback.serviceStationID
                )
            })
            
            let masters = Array(realmServiceStation.masters.map { realmMaster in
                Masters(
                    serviceStationID: realmMaster.serviceStationID,
                    masterEmail: realmMaster.masterEmail
                )
            })
            
            let serviceStation = ServiceStation(
                id: realmServiceStation.id,
                name: realmServiceStation.name,
                location: location,
                services: services,
                managerID: realmServiceStation.managerID,
                workSchedule: workSchedule,
                feedbackList: feedbackList, 
                masters: masters
            )
            
            serviceStations.append(serviceStation)
        }
        
        return serviceStations
    }

    
    func deleteServiceStation(byID id: String) -> Bool {
        // Find the service station to delete by its ID
        guard let stationToDelete = realm.objects(RealmServiceStation.self).filter("id == %@", id).first else {
            print("Service Station with ID \(id) not found")
            return false
        }
        
        do {
            try realm.write {
                // Delete related location if it exists
                if let location = stationToDelete.location {
                    realm.delete(location)
                }
                
                // Delete related services
                realm.delete(stationToDelete.services)
                
                // Delete related work schedule
                realm.delete(stationToDelete.workSchedule)
                
                // Delete related feedback
                realm.delete(stationToDelete.feedbackList)
                
                // Delete the service station itself
                realm.delete(stationToDelete)
            }
            return true
        } catch {
            print("Error deleting service station: \(error)")
            return false
        }
    }

    
    func getUser(byManagerID managerID: String) -> User? {
        if let serviceStation = realm.objects(RealmServiceStation.self).filter("managerID == %@", managerID).first {
            
            return realm.objects(RealmUser.self)
                .filter("id == %@", serviceStation.managerID)
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
            
        } else {
            print("No car found for owner ID: \(managerID)")
            return nil
        }
    }
    
    func addBooking(booking: RealmBooking) -> Bool {
        do {
            try realm.write {
                realm.add(booking)
            }
            return true
        } catch {
            print("Error saving booking to Realm: \(error.localizedDescription)")
            return false
        }
    }
    
    func getBookedTimes(for date: String, serviceStationID: String) -> [String] {
        let realm = try! Realm()  // Initializing Realm can throw, so we use try!
        let bookings = realm.objects(RealmBooking.self)
            .filter("date == %@ AND serviceStationID == %@", date, serviceStationID)
        
        var bookedTimes: [String] = []
        for booking in bookings {
            // Add the whole time slot to the array
            bookedTimes.append(booking.time)
        }
        return bookedTimes
    }
    
    func deleteBooking(byID id: String) -> Bool {
        // Find the booking list to delete by its ID
        guard let bookingToDelete = realm.objects(RealmBooking.self).filter("id == %@", id).first else {
            print("Booking list with ID \(id) not found")
            return false
        }
        
        do {
            try realm.write {
                // Delete related service if it exists
                if let service = bookingToDelete.service {
                    realm.delete(service)
                }
                
                // Delete the booking list itself
                realm.delete(bookingToDelete)
            }
            return true
        } catch {
            print("Error deleting booking list: \(error)")
            return false
        }
    }
    
    func getBookingList() -> [Booking] {
        let realmBookingLists = realm.objects(RealmBooking.self)
        
        // Mapping RealmBookingList objects to BookingList objects
        let bookingLists: [Booking] = realmBookingLists.map { realmBooking in
            let serviceStation = getServiceStation(byID: realmBooking.serviceStationID)
            let client = getUser(byID: realmBooking.clientID)
            let service = Service(name: realmBooking.service?.name ?? "", serviceDescription: realmBooking.service?.serviceDescription ?? "", price: realmBooking.service?.price ?? "")
            
            return Booking(
                id: realmBooking.id,
                date: realmBooking.date,
                time: realmBooking.time,
                serviceStation: serviceStation,
                client: client,
                service: service
            )
        }
        
        return bookingLists
    }
    
    func getServiceStation(byID id: String) -> ServiceStation {
        guard let realmServiceStation = realm.objects(RealmServiceStation.self).filter("id == %@", id).first else {
            // Handle the case where the service station is not found
            return ServiceStation(
                id: id,
                name: "",
                location: Location(country: "", city: "", street: "", houseNumber: ""),
                services: [],
                managerID: "",
                workSchedule: [],
                feedbackList: [], 
                masters: []
            )
        }
        
        let location = Location(
            country: realmServiceStation.location?.country ?? "",
            city: realmServiceStation.location?.city ?? "",
            street: realmServiceStation.location?.street ?? "",
            houseNumber: realmServiceStation.location?.houseNumber ?? ""
        )
        
        let services = Array(realmServiceStation.services.map { realmService in
            Service(
                name: realmService.name,
                serviceDescription: realmService.serviceDescription,
                price: realmService.price
            )
        })
        
        let workSchedule = Array(realmServiceStation.workSchedule.map { realmWorkSchedule in
            WorkSchedule(
                day: realmWorkSchedule.day,
                startTime: realmWorkSchedule.startTime,
                endTime: realmWorkSchedule.endTime,
                interval: realmWorkSchedule.interval
            )
        })
        
        let feedbackList = Array(realmServiceStation.feedbackList.map { realmFeedback in
            Feedback(
                id: realmFeedback.id,
                rating: realmFeedback.rating,
                text: realmFeedback.text,
                date: realmFeedback.date, 
                author: realmFeedback.author, 
                serviceStationID: realmFeedback.serviceStationID
            )
        })
        
        let masters = Array(realmServiceStation.masters.map { realmMaster in
            Masters(
                serviceStationID: realmMaster.serviceStationID,
                masterEmail: realmMaster.masterEmail
            )
        })
        
        return ServiceStation(
            id: realmServiceStation.id,
            name: realmServiceStation.name,
            location: location,
            services: services,
            managerID: realmServiceStation.managerID,
            workSchedule: workSchedule,
            feedbackList: feedbackList, 
            masters: masters
        )
    }

    
    func getUser(byID id: String) -> User {
        guard let realmUser = realm.objects(RealmUser.self).filter("id == %@", id).first else {
            // Handle the case where the user is not found
            return User(id: id, name: "", surname: "", phone: "", photo: "", email: "", password: "", role: "", date: "")
        }
        
        return User(
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
    }
    
    func getBookingList(byServiceStationID serviceStationID: String) -> [Booking] {
        // Fetch the bookings from Realm
        let results = realm.objects(RealmBooking.self).filter("serviceStationID == %@", serviceStationID)
        
        // Map the results to BookingList
        return results.map { realmBookingList in
            return Booking(
                id: realmBookingList.id,
                date: realmBookingList.date,
                time: realmBookingList.time,
                serviceStation: getServiceStation(byID: realmBookingList.serviceStationID),
                client: getUser(byID: realmBookingList.clientID),
                service: realmBookingList.service?.toService() ?? Service(name: "", serviceDescription: "", price: "")
            )
        }
    }
    
    func getBookingList(byClientID clientID: String) -> [Booking] {
        // Fetch the bookings from Realm
        let results = realm.objects(RealmBooking.self).filter("clientID == %@", clientID)
        
        // Map the results to BookingList
        return results.map { realmBookingList in
            return Booking(
                id: realmBookingList.id,
                date: realmBookingList.date,
                time: realmBookingList.time,
                serviceStation: getServiceStation(byID: realmBookingList.serviceStationID),
                client: getUser(byID: realmBookingList.clientID),
                service: realmBookingList.service?.toService() ?? Service(name: "", serviceDescription: "", price: "")
            )
        }
    }
    
    func addFeedback(toServiceStationWithID id: String, feedback: Feedback) -> Bool {
        guard let serviceStation = realm.objects(RealmServiceStation.self).filter("id == %@", id).first else {
            print("Service Station with ID \(id) not found")
            return false
        }
        
        do {
            try realm.write {
                let realmFeedback = RealmFeedback()
                realmFeedback.id = UUID().uuidString
                realmFeedback.rating = feedback.rating
                realmFeedback.text = feedback.text
                realmFeedback.date = feedback.date
                realmFeedback.author = feedback.author
                realmFeedback.serviceStationID = feedback.serviceStationID
                
                serviceStation.feedbackList.append(realmFeedback)
            }
            return true
        } catch {
            print("Error adding feedback: \(error)")
            return false
        }
    }
    
    func getFeedbackList(forServiceStationWithID id: String) -> [Feedback] {
        guard let serviceStation = realm.objects(RealmServiceStation.self).filter("id == %@", id).first else {
            print("Service Station with ID \(id) not found")
            return []
        }
        
        return serviceStation.feedbackList.map { realmFeedback in
            return Feedback(
                id: realmFeedback.id,
                rating: realmFeedback.rating,
                text: realmFeedback.text,
                date: realmFeedback.date, 
                author: realmFeedback.author, 
                serviceStationID: realmFeedback.serviceStationID
            )
        }
    }
    
    func getFeedbackList() -> [Feedback] {
        let realmServiceStations = realm.objects(RealmServiceStation.self)
        
        // Map each RealmServiceStation's feedbackList to an array of Feedback
        let feedbackList = Array(realmServiceStations.flatMap { $0.feedbackList.map { Feedback(id: $0.id, rating: $0.rating, text: $0.text, date: $0.date, author: $0.author, serviceStationID: $0.serviceStationID) } })
        
        return feedbackList
    }
    
    func deleteFeedback(byID id: String) -> Bool {
        do {
            try realm.write {
                // Find the feedback object by its ID
                if let feedbackToDelete = realm.objects(RealmFeedback.self).filter("id == %@", id).first {
                    // Delete the feedback object from Realm
                    realm.delete(feedbackToDelete)
                    return true
                } else {
                    print("Feedback with ID \(id) not found")
                    return false
                }
            }
        } catch {
            print("Error deleting feedback: \(error)")
            return false
        }
        return false
    }
    
    func getMasterEmails(byServiceStationID id: String) -> [String] {
        // Attempt to find the RealmServiceStation object by its ID
        if let realmServiceStation = realm.objects(RealmServiceStation.self).filter("id == %@", id).first {
            
            // Map the masters property to extract the masterEmail values
            let masterEmails = realmServiceStation.masters.map { $0.masterEmail }
            
            return Array(masterEmails)
        } else {
            // Handle the case where the service station is not found
            print("Service Station with ID \(id) not found")
            return []
        }
    }
    
    func refreshMasterEmails(forServiceStationID id: String, newEmails: [String]) -> Bool {
        guard let realmServiceStation = realm.objects(RealmServiceStation.self).filter("id == %@", id).first else {
            print("Service Station with ID \(id) not found")
            return false
        }
        
        do {
            try realm.write {
                // Remove existing masters
                realm.delete(realmServiceStation.masters)
                
                // Add new master emails
                for email in newEmails {
                    let newMaster = RealmMasters()
                    newMaster.serviceStationID = id
                    newMaster.masterEmail = email
                    realmServiceStation.masters.append(newMaster)
                }
            }
            return true
        } catch {
            print("Error refreshing master emails: \(error)")
            return false
        }
    }
    
    func getServiceStationID(byMasterEmail masterEmail: String) -> String? {
        if let master = realm.objects(RealmMasters.self).filter("masterEmail == %@", masterEmail).first {
            return master.serviceStationID
        } else {
            return nil
        }
    }
    
    
}

