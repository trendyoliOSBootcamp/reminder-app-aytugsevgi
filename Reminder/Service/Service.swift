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
    
    func saveList(reminderList: ReminderList) throws {
        let context = Service.context
        let newObj =  NSEntityDescription.insertNewObject(forEntityName: "ReminderListEntity", into: context)
        newObj.setValue(reminderList.id, forKey: "id")
        newObj.setValue(reminderList.name, forKey: "name")
        newObj.setValue(reminderList.color, forKey: "color")
        newObj.setValue(reminderList.image, forKey: "image")
        do {
            try context.save()
            print("saved")
        } catch let error {
            throw(error)
        }
    }
}
