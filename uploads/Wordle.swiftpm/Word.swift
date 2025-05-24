import SwiftUI
struct chara{
    var colour = 0
    var colours = [Image("White"),Image("Green"),Image("Grey"),Image("Yellow")]
    var letter = " "
    func display1()->ZStack<TupleView<(Image,Text)>>{
        return ZStack{
            colours[colour]
            Text(letter)
                .font(.system(size: 35))
        }
    }
    
}


