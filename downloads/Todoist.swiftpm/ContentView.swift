import SwiftUI

struct ContentView: View {
    @StateObject var remindersViewModel = ReminderViewModel()
    
    @State var isSheetPresented = false
    
    var body: some View {
        NavigationView{
            List{
                ForEach($remindersViewModel.reminders){ $todo in
                    NavigationLink{
                        TodoDetailView(todo: $todo)
                    }label: {
                        HStack{
                            Image(systemName: todo.isCompleted ?
                                  "checkmark.circle.fill" :
                                    "circle")
                            Text(todo.title)
                                .strikethrough(todo.isCompleted)
                        }
                    }
                }
                .onDelete{ indexSet in
                    remindersViewModel.reminders.remove(atOffsets: indexSet)
                }
                .onMove{ indices, newOffset in 
                    remindersViewModel.reminders.move(fromOffsets: indices, toOffset: newOffset)
                }
            }
            .navigationTitle("To-Do-List✅")
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    EditButton()
                    Button{
                        isSheetPresented = true
                    }label:{
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $isSheetPresented){
            NewtodoView(reminders: $remindersViewModel.reminders)
        }
    }
}
