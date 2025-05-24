import Foundation
import SwiftUI

class ReminderViewModel: ObservableObject {
    @Published var reminders: [Todo] = [] {
        didSet {
            save()
        }
    }
    
    init() {
        load()
    }
    
    let sampleReminders: [Todo] = [Todo(title: "Add Persistence file", description: "", date: Date.now),
                                   Todo(title: "Change stuff", description: "", date: Date.now)]
    
    func getArchiveURL() -> URL {
        let plistName = "reminders.plist"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        return documentsDirectory.appendingPathComponent(plistName)
    }
    
    func save() {
        let archiveURL = getArchiveURL()
        let propertyListEncoder = PropertyListEncoder()
        let encodedReminders = try? propertyListEncoder.encode(reminders)
        try? encodedReminders?.write(to: archiveURL, options: .noFileProtection)
    }
    
    func load() {
        let archiveURL = getArchiveURL()
        let propertyListDecoder = PropertyListDecoder()
        
        var finalReminders: [Todo]!
        
        if let retrievedReminderData = try? Data(contentsOf: archiveURL),
           let decodedReminders = try? propertyListDecoder.decode([Todo].self, from: retrievedReminderData) {
            finalReminders = decodedReminders
        } else {
            finalReminders = sampleReminders
        }
        
        reminders = finalReminders
    }
}
