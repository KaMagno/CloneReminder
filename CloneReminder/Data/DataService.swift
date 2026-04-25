import Foundation
import SwiftData

protocol DataServiceInterface {
    func fetch<T: PersistentModel>() throws -> [T]
    func save(_ model: any PersistentModel) throws
    func delete(_ model: any PersistentModel) throws
}

struct DataService: DataServiceInterface {
    private let modelContainer: ModelContainer
    
    init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
    }
    
    func fetch<T: PersistentModel>() throws -> [T] {
        let descriptor = FetchDescriptor<T>()
        return try modelContainer.mainContext.fetch(descriptor)
    }
    
    func save(_ model: any PersistentModel) throws {
        modelContainer.mainContext.insert(model)
        try modelContainer.mainContext.save()
    }
    
    func delete(_ model: any PersistentModel) throws {
        modelContainer.mainContext.delete(model)
        try modelContainer.mainContext.save()
    }
}

#if DEBUG
extension DataService {
    static var mock: Self {
        .init(modelContainer: previewContainer)
    }
}
#endif
