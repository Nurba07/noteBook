//
//  CoreDataManager.swift
//  notebook!
//
//  Created by Nurbakhyt on 10.08.2023.
//

import Foundation
import CoreData

class CoreDataManager{
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "notebook_")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var tasks: [List]? = nil
    var done: [Done]? = nil
    
    func save(title: String?, body: String?, date: String) {
        let context = persistentContainer.viewContext
        let lists = List(context: context)
        lists.body = body
        lists.title = title
        lists.date = date
        
        do {
          try context.save()
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
    }
    func addDone(list: List) {
        let context = persistentContainer.viewContext
        let dones = Done(context: context)
        dones.body = list.body
        dones.title = list.title
        dones.date = list.date
        
        do {
          try context.save()
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func delete(list: List) {
        let managedContext = persistentContainer.viewContext
        addDone(list: list)
        managedContext.delete(list)
        do {
          try managedContext.save()
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
    }
    func absoluteDelete(done: Done) {
        let managedContext = persistentContainer.viewContext
        managedContext.delete(done)
        do {
          try managedContext.save()
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func getAllTasks() -> [List]? {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<List> = List.fetchRequest()
        do{
            let objects = try context.fetch(fetchRequest)
            tasks = objects
            return tasks
        }catch{
            print("Error with fetching")
        }
        return tasks
    }
    
    func getAllDone() -> [Done]? {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Done> = Done.fetchRequest()
        do{
            let objects = try context.fetch(fetchRequest)
            done = objects
            return done
        }catch{
            print("Error with fetching")
        }
        return done
    }
    
    func saveContext () {
        let context = persistentContainer.viewContext
        
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
}
