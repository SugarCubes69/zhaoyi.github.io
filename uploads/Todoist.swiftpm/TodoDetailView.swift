import SwiftUI

struct TodoDetailView : View {
    
    @Binding var todo: Todo
    
    var body : some View {
        VStack{
        TextField("Todo title", text: $todo.title
        )
        .multilineTextAlignment(.center)
        .foregroundColor(.red)
        
            TextField("Todo title", text: $todo.description
            )
            .multilineTextAlignment(.center)
            .foregroundColor(.red)
        Button{
            todo.isCompleted.toggle()
        }label: {
            Text("Mark as \(todo.isCompleted ? "Incomplete" : "Complete")")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(15)
        }
        }
        .navigationTitle(todo.title)
    }
}

struct TodoDetailView_Preview:
    PreviewProvider {
    static var previews: some View {
        TodoDetailView(todo: .constant(Todo(title: "Eat a sandwich", description: "Eat a sandwich", date: Date.now)))
    }
}
