import SwiftUI
struct Intro: View {
    @State var op = 1.0
    @State var start = true
    @State var posy:Array<CGFloat> = [300,300,300,300,300,300,300,300,300,300,300,300];
    var body: some View {
        if op != 0{
            ZStack{
                HStack{
                    Text("M").font(.system(size: 30)).offset(y: posy[0])
                    Text("A").font(.system(size: 30)).offset( y: posy[1])
                    Text("D").font(.system(size: 30)).offset( y: posy[2])
                    Text("E").font(.system(size: 30)).offset(y: posy[3])
                }.offset(x: -100)
                
                HStack{
                    Text("B").font(.system(size: 30)).offset(y: posy[4])
                    Text("Y").font(.system(size: 30)).offset(y: posy[5])
                }.offset(x: 0)
                
                HStack{
                    Text("Z").font(.system(size: 30)).offset(y: posy[6])
                    Text("H").font(.system(size: 30)).offset(y: posy[7])
                    Text("A").font(.system(size: 30)).offset(y: posy[8])
                    Text("O").font(.system(size: 30)).offset(y: posy[9])
                    Text("Y").font(.system(size: 30)).offset(y: posy[10])
                    Text("I").font(.system(size: 30)).offset(y: posy[11])
                }.offset(x: 100)
                
            }
            .opacity(op)
            .onAppear{
                for i in 0..<posy.count{
                    withAnimation(Animation.linear(duration: 1.0+0.3*Double(i))){
                        posy[i] -= 300
                    }
                }
                withAnimation(Animation.linear(duration: 3).delay(5.0)){
                    op -= 1.0
                }
            }
        }
        else{
            Game()
        }
    }
}

