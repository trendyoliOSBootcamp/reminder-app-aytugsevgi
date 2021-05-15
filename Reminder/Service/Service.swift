import UIKit
import CoreData

final class Service {
    private static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchList() -> [ListModel]? {
        var listModels = [ListModel]()
        let context = Service.context
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "List")
        fetchRequest.returnsObjectsAsFaults = false
        guard let results = try? context.fetch(fetchRequest) as? [NSManagedObject] else { return nil }
        for result in results {
            guard let name = result.value(forKey: "name") as? String,
                  let colorData = result.value(forKey: "color") as? Data,
                  let imageData = result.value(forKey: "image") as? Data else { continue }
            let listModel = ListModel(name: name, color: colorData, image: imageData)
            listModels.append(listModel)
        }
        return listModels
    }
    
    func saveList() {
        let context = Service.context
        guard let colorData = UIColor.blue.encode(),
              let image = UIImage(systemName: "cloud.heavyrain.fill") else { return }
        let imageData = image.pngData()
        let newObj =  NSEntityDescription.insertNewObject(forEntityName: "List", into: context)
        newObj.setValue(UUID(), forKey: "id")
        newObj.setValue("Selam", forKey: "name")
        newObj.setValue(colorData, forKey: "color")
        newObj.setValue(imageData, forKey: "image")
        do {
            try context.save()
        } catch  {
            print("DEBUG: Error on \(#function)")
        }
    }
}
