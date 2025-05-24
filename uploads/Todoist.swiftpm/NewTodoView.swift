import SwiftUI 

struct NewtodoView: View {
    
    @State var todo = ""
    
    //@Binding var todos: [Todo]
    @Binding var reminders: [Todo]
    
    @State var desc = ""
    @State var selectDate = Date()
    
    @Environment(\.presentationMode) var presentationMode1 
    
    var body: some View {
        ZStack{
            
        Form{
            TextField("Task Name", text: $todo)
            TextField("Description", text: $desc)
            DatePicker("Date", selection: $selectDate, displayedComponents: .date)
                .padding()
            
            Button("Save"){
                reminders.append(Todo(title: todo, description: desc, date: selectDate))
                presentationMode1.wrappedValue.dismiss()
            }
        }
    }
}
}
struct NewtodoView_Previews: PreviewProvider {
    static var previews: some View {
        NewtodoView(reminders: .constant([]))
    }
}
