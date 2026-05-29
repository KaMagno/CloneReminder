import Combine
import SwiftUI
import SwiftData

protocol DetailItemViewModelInterface: ObservableObject {
    
    var item: Item { get set }
    
    var name: String { get set }
    var notes: String { get set }
    var reminderDate: Date? { get set }
    var reminderTime: Date? { get set }
    
    var showCalendar: Bool { get set }
    var showTime: Bool { get set }
    var showCancelConfirmation: Bool { get set }

    func save()
    func shouldCancel()
    func cancel()
}

final class DetailItemViewModel: DetailItemViewModelInterface {
    
    @Published
    var item: Item
    
    @Published
    var name: String
    @Published
    var notes: String
    @Published
    var reminderDate: Date?
    @Published
    var reminderTime: Date?
    
    @Published
    var showCalendar: Bool
    @Published
    var showTime: Bool
    @Published
    var showCancelConfirmation: Bool
    
    private let dataService: DataServiceInterface
    private let coordinator: any CoordinatorInterface
    
    init(item: Item, dataService: DataServiceInterface, coordinator: some CoordinatorInterface) {
        self.item = item
        self.dataService = dataService
        self.coordinator = coordinator
        
        self.showCalendar = item.reminderDate != nil
        self.showTime = item.reminderTime != nil
        self.showCancelConfirmation = false
        
        self.name = item.name
        self.notes = item.notes ?? ""
        self.reminderDate = item.reminderDate
        self.reminderTime = item.reminderTime
    }
    
    func save() {
        guard isValid() else {
            //TODO: Create a State invalid in view.
            return
        }
        updateItem()
        
        do {
            try dataService.save(item)
            coordinator.dismiss()
        } catch {
            Logger.error(error)
        }
    }
    
    func shouldCancel() {
        guard hasChanges() else {
            cancel()
            return
        }
        
        showCancelConfirmation = true
    }
    
    func cancel() {
        coordinator.dismiss()
    }
}

private extension DetailItemViewModel {
    func updateItem() {
        item.name = name
        item.reminderDate = reminderDate
        item.reminderTime = reminderTime
        
        if notes.isEmpty {
            item.notes = nil
        } else {
            item.notes = notes
        }
    }
    
    func isValid() -> Bool {
        return !name.isEmpty
    }
    
    func hasChanges() -> Bool {
        item.name != name ||
        item.reminderDate != reminderDate ||
        item.reminderTime != reminderTime ||
        (item.notes ?? "") != notes
    }
}
