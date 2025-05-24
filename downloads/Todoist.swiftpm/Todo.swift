import SwiftUI

struct Todo:Identifiable, Codable{
    var id = UUID()
    
    var title : String
    var isCompleted : Bool = false
    
    var description: String
    var date: Date
}
