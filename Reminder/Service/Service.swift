import UIKit
import CoreData

final class Service {
    private static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchList() -> [ReminderList]? {
        var listModels = [ReminderList]()
        let context = Service.context
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ReminderListEntity")
        fetchRequest.returnsObjectsAsFaults = false
        guard let results = try? context.fetch(fetchRequest) as? [NSManagedObject] else { return nil }
        for result in results {
            guard let name = result.value(forKey: "name") as? String,
                  let colorRawValue = result.value(forKey: "color") as? Int,
                  let imageName = result.value(forKey: "image") as? String,
                  let id = result.value(forKey: "id") as? UUID else { continue }
            let listModel = ReminderList(id: id, name: name, color: colorRawValue, image: imageName, reminders: [])
            listModels.append(listModel)
        }
        return listModels
    }
    
    func fetchReminders() -> [Reminder]? {
        var reminders = [Reminder]()
        let context = Service.context
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ReminderEntity")
        fetchRequest.returnsObjectsAsFaults = false
        guard let results = try? context.fetch(fetchRequest) as? [NSManagedObject] else { return nil }
        for result in results {
            guard let id = result.value(forKey: "id") as? UUID,
                  let title = result.value(forKey: "title") as? String,
                  let content = result.value(forKey: "content") as? String,
                  let isFlag = result.value(forKey: "isFlag") as? Bool,
                  let priority = result.value(forKey: "priority") as? Int,
                  let reminderListId = result.value(forKey: "reminderListId") as? UUID else { continue }
            let reminder = Reminder(id: id, reminderListId: reminderListId, title: title, content: content, isFlag: isFlag, priority: Priority.init(rawValue: priority) ?? .none)
            reminders.append(reminder)
        }
        return reminders
    }
    
    func saveList(reminderList: ReminderList) throws {
        let context = Service.context
        let newObj =  NSEntityDescription.insertNewObject(forEntityName: "ReminderListEntity", into: context)
        newObj.setValue(reminderList.id, forKey: "id")
        newObj.setValue(reminderList.name, forKey: "name")
        newObj.setValue(reminderList.color, forKey: "color")
        newObj.setValue(reminderList.image, forKey: "image")
        do {
            try context.save()
        } catch let error {
            throw(error)
        }
    }
    
    func saveReminder(reminder: Reminder) throws {
        let context = Service.context
        let newObj =  NSEntityDescription.insertNewObject(forEntityName: "ReminderEntity", into: context)
        newObj.setValue(reminder.id, forKey: "id")
        newObj.setValue(reminder.title, forKey: "title")
        newObj.setValue(reminder.content, forKey: "content")
        newObj.setValue(reminder.isFlag, forKey: "isFlag")
        newObj.setValue(reminder.priority.rawValue, forKey: "priority")
        newObj.setValue(reminder.reminderListId, forKey: "reminderListId")
        do {
            try context.save()
        } catch let error {
            throw(error)
        }
    }
    
    func deleteReminder(reminder: Reminder) throws {
        let context = Service.context
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ReminderEntity")
        fetchRequest.predicate = NSPredicate(format: "ANY %K == %@", "id", reminder.id as CVarArg)
        do {
            let objects = try context.fetch(fetchRequest)
            for object in objects {
                guard let object = object as? NSManagedObject else { continue }
                context.delete(object)
            }
            try context.save()
        } catch let error {
            throw(error)
        }
    }
    
    func changeReminderFlag(reminder: Reminder) throws {
        let context = Service.context
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ReminderEntity")
        fetchRequest.predicate = NSPredicate(format: "ANY %K == %@", "id", reminder.id as CVarArg)
        do {
            let objects = try context.fetch(fetchRequest)
            for object in objects {
                guard let object = object as? NSManagedObject,
                      let isFlag = object.value(forKey: "isFlag") as? Bool else { continue }
                object.setValue(!isFlag, forKey: "isFlag")
            }
            try context.save()
        } catch let error {
            throw(error)
        }
    }
}
