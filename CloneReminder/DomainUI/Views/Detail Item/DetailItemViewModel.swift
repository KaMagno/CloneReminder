import Combine
import SwiftUI
import SwiftData

protocol DetailItemViewModelInterface: ObservableObject {
    
    var item: Item { get set }
    
    var name: String { get set }
    var notes: String { get set }
    var reminderDate: Date? { get set }
    var reminderTime: Date? { get set }
    
    var isCalendarEnabled: Bool { get set }
    var isTimeEnabled: Bool { get set }
    var showCancelConfirmation: Bool { get set }

    func showCalendar()
    func showTime()
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
    var isCalendarEnabled: Bool
    @Published
    var isTimeEnabled: Bool
    @Published
    var showCancelConfirmation: Bool
    
    private let dataService: DataServiceInterface
    private let coordinator: any CoordinatorInterface
    
    init(item: Item, dataService: DataServiceInterface, coordinator: some CoordinatorInterface) {
        self.item = item
        self.dataService = dataService
        self.coordinator = coordinator
        
        self.isCalendarEnabled = item.reminderDate != nil
        self.isTimeEnabled = item.reminderTime != nil
        self.showCancelConfirmation = false
        
        self.name = item.name
        self.notes = item.notes ?? ""
        self.reminderDate = item.reminderDate
        self.reminderTime = item.reminderTime
    }
    
    func showCalendar() {
        isCalendarEnabled.toggle()
        
        guard isCalendarEnabled else {
            reminderDate = nil
            return
        }
        
        reminderDate = .now
    }
    
    func showTime() {
        isTimeEnabled.toggle()
        
        guard isTimeEnabled else {
            reminderTime = nil
            return
        }
        
        isCalendarEnabled = true
        reminderDate = .now
        reminderTime = .now
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
