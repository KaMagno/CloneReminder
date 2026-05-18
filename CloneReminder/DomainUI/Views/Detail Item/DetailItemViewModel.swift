import Combine
import SwiftUI
import SwiftData

protocol DetailItemViewModelInterface: ObservableObject {
    var item: Item { get set }
    
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
    }
    
    func save() {
        do {
            try dataService.save(item)
        } catch {
            Logger.error(error)
        }
    }
    
    func shouldCancel() {
        showCancelConfirmation = true
//        guard item.hasChanges == false else{
//            showCancelConfirmation = true
//            return
//        }
//        
//        cancel()
    }
    
    func cancel() {
        coordinator.dismiss()
    }
}
