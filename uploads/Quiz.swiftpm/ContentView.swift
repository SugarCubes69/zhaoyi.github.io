import SwiftUI

struct ContentView: View {
var questions = [Question(title: "What is paper made of?",option1: "Wood", option2: "Rocks", option3: "Animals' poop", option4: "Leaves", correctOption: 1),
                 Question(title: "What is the largest rainforest in the world?", option1: "Thailand", option2: "India", option3: "Brazil", option4: "Mexico",
                 correctOption: 3),
                 Question(title: "Which country is also a continent?", option1: "Greenland", option2: "Australia", option3: "Russia", option4: "Iceland",correctOption: 2),
                 Question(title: "The region of Siberia is part of which country?", option1: "Poland", option2: "Ukraine", option3: "Canada", option4: "Russia", correctOption: 4),
                 Question(title: "What was Disney's very first feature-length animated movie?", option1: "Dumbo", option2: "Snow White and the Seven Dwarfs", option3: "Cinderella", option4: "Pinocchio", correctOption: 2),
                 Question(title: "What is the capital of South Korea?", option1: "Bangkok", option2: "Tokyo", option3: "Seoul", option4: "Beijing", correctOption: 3),
                 Question(title: "Who painted the Mona Lisa?", option1: "Leonardo da Vinci", option2: "Rembrandt", option3: "Michelangelo", option4: "Vincent van Gogh", correctOption: 1),
                 Question(title: "Who is the first man on the moon?", option1: "Alan Shepard Jr", option2: "Yuri Gagarin", option3: "Neil Armstrong", option4: "John Glenn", correctOption: 3),
                 Question(title: "After decades of performances, what is the longest-running rock band?", option1: "Queen", option2: "AC/DC", option3: "The Rolling Stones", option4: "Aerosmith", correctOption: 3),
                 Question(title: "What was the first satellite ever launched into space?", option1: "Callisto", option2: "Sputnik", option3: "Minuta", option4: "Proteus", correctOption: 2),
                 Question(title: "Where is Mount Rushmore located?", option1: "South Dakota", option2: "North Dakota", option3: "Montana", option4: "Nebraska", correctOption: 1),
                 Question(title: "Where were French Fries created?", option1: "France", option2: "Belgium", option3: "England", option4: "Ireland", correctOption: 2),
                 Question(title: "Which chart-topping musician is known as the king of pop?", option1: "Elvis Presley", option2: "Elton John", option3: "David Bowie", option4: "Michael Jackson", correctOption: 4),
                 Question(title: "Genghis Khan was the founder of which empire?", option1: "Ottoman Empire", option2: "Persian Empire", option3: "Mongol Empire", option4: "Roman Empire", correctOption: 3),
                 Question(title: "What is the world's best selling book of all time?", option1: "Harry Potter and the Sorcerer's Stone", option2: "The Lord of the Rings", option3: "The Bible", option4: "Fifty Shades of Grey", correctOption: 3),
                 Question(title: "Which country has the longest coastline in the world?", option1: "Russia", option2: "Indonesia", option3: "Canada", option4: "Australia", correctOption: 3),
                 Question(title: "What is the world's most populated country?", option1: "India", option2: "Russia", option3: "USA", option4: "China", correctOption: 4),
                 Question(title: "What is the World's Smallest Country?", option1: "Singapore", option2: "Vatican City", option3: "Monaco", option4: "Lichtenstein", correctOption: 2),
                 Question(title: "What is the capital of Australia?", option1: "Adelaide", option2: "Canberra", option3: "Sydney", option4: "Melbourne", correctOption: 2),
                 Question(title: "In which country is the Cape of Good Hope?", option1: "Canada", option2: "USA", option3: "South Africa", option4: "Australia", correctOption: 3)]
    
    @State private var currentQuestion = 0
    @State private var isAlertPresented = false
    @State private var isCorrect = false
    @State private var correctAnswers = 0
    @State private var isModalPresented = false
    
    var body: some View {
        VStack {
            ProgressView(value: Double(currentQuestion),
                         total: Double(questions.count))
            .padding()
            
            Text(questions[currentQuestion].title)
                .bold()
                .italic()
                .padding()
        }
        
        HStack{
            VStack{
                Button(questions[currentQuestion].option1){didTapOption(optionNumber: 1)}
                    .padding()
                    .background(.red)
                    .foregroundColor(.black)
                Button(questions[currentQuestion].option2){didTapOption(optionNumber: 2)}
                    .padding()
                    .background(.blue)
                    .foregroundColor(.black)
            }
            .padding()
            VStack{
                Button(questions[currentQuestion].option3){didTapOption(optionNumber: 3)}
                    .padding()
                    .background(.yellow)
                    .foregroundColor(.black)
                Button(questions[currentQuestion].option4){didTapOption(optionNumber: 4)}
                    .padding()
                    .background(.green)
                    .foregroundColor(.black)
            }
        }
        .alert(isPresented:$isAlertPresented){
            Alert(title: Text(isCorrect ? "Correct" : "Wrong"),
                  message: Text(isCorrect ? "Congrats you are correct" : "You got it wrong"),
                  dismissButton: .default(Text("OK")){
                currentQuestion += 1
                
                if currentQuestion == questions.count{
                    isModalPresented = true
                    currentQuestion = 0
                }
            })
        }
        .sheet(isPresented: $isModalPresented,
               onDismiss: {
            correctAnswers = 0
        },
               content: {
            ScoreView(score: correctAnswers, totalQuestions: questions.count)
        })
    }
    func didTapOption(optionNumber: Int){
        if optionNumber == questions[currentQuestion].correctOption{
            print("Correct")
            isCorrect = true
            correctAnswers += 1
        } else{
            print("Wrong")
            isCorrect = false
        }
        isAlertPresented = true
    }
}

struct ContentView_Previews : PreviewProvider{
    static var previews: some View{
        ContentView()
    }
}
