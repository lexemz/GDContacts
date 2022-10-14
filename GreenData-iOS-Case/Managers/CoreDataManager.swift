//
//  CoreDataManager.swift
//  GreenData-iOS-Case
//
//  Created by Igor Buzykin on 11.10.2022.
//

import CoreData

final class CoreDataManager {
  static let shared = CoreDataManager()

  private let persistentContainer: NSPersistentContainer
  private let context: NSManagedObjectContext

  // MARK: - Core Data stack

  private init() {
    let container = NSPersistentContainer(name: "GreenData_iOS_Case")
    container.loadPersistentStores(completionHandler: { _, error in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })

    persistentContainer = container
    context = container.viewContext
  }

  // MARK: - Core Data Saving support
  
  func fetchData() -> [ContactCoreData] {
    let fetchRequest = ContactCoreData.fetchRequest()
    do {
      return try context.fetch(fetchRequest)
    } catch {
      Log.e("Failed to fetch data", error)
    }
    return []
  }

  func createNewObjects(_ contacts: [Contact]) {
    guard let entityDescription = NSEntityDescription.entity(
      forEntityName: "ContactCoreData",
      in: context
    ) else { return }
    for contact in contacts {
      guard let createdContact = NSManagedObject(
        entity: entityDescription,
        insertInto: context
      ) as? ContactCoreData else { return }

      createdContact.fullname = contact.fullname
      createdContact.gender = contact.gender.rawValue
      createdContact.mail = contact.mail
      createdContact.birthdayDate = contact.birthdayDate
      createdContact.birthdayAge = Int64(contact.birthdayAge)
      createdContact.localTimeOffset = contact.localTimeOffset
      createdContact.picURL = contact.picURL
      createdContact.phoneNumber = contact.phoneNumber
    }
    saveContext()
  }

  func deleteAllObjects() {
    let fetchRequest: NSFetchRequest<NSFetchRequestResult>
    fetchRequest = NSFetchRequest(entityName: "ContactCoreData")
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    deleteRequest.resultType = .resultTypeObjectIDs
    do {
      try context.execute(deleteRequest)
    } catch {
      Log.e("Failed to delete all entities", error)
    }
    saveContext()
  }
  
  private func saveContext() {
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        context.rollback()
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
}
