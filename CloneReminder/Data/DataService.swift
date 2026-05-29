import Foundation
import SwiftData

protocol DataServiceInterface {
    func fetch<T: PersistentModel>() throws -> [T]
    func save(_ model: any PersistentModel) throws
    func delete(_ model: any PersistentModel) throws
    func rollback() throws
}

struct DataService: DataServiceInterface {
    
    enum Errors: Error {
        case undoManagerNil
    }
    private let modelContainer: ModelContainer
    private let undoManager: UndoManager
    
    init(modelContainer: ModelContainer, undoManager: UndoManager) {
        self.modelContainer = modelContainer
        self.undoManager = undoManager
        
        self.modelContainer.mainContext.autosaveEnabled = false
        self.modelContainer.mainContext.undoManager = undoManager
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
    
    func rollback() throws {
        guard let undoManager = modelContainer.mainContext.undoManager else {
            throw Errors.undoManagerNil
        }
        undoManager.undo()
        Logger.debug("\(undoManager)")
        Logger.debug("\(undoManager.undoCount)")
        
        modelContainer.mainContext.rollback()
    }
}

#if DEBUG
extension DataService {
    static var mock: Self {
        .init(
            modelContainer: previewContainer,
            undoManager: UndoManager()
        )
    }
}
#endif
