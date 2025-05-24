import SwiftUI
import UIKit

func get(from:String,pos:Int)->Character{
    return from[from.index(from.startIndex,offsetBy: pos)]
}

func ord(i:Character)->Int{
    for k in i.utf8{
        return Int(k-97)
    }
    return 0
}


func exists(str:String)->Bool{
    let url = URL(string: "https://www.collinsdictionary.com/dictionary/english/"+str)
    do{
        let contents = try String(contentsOf: url!).prefix(623)
        if(contents.contains("definition") == true){return true}
    }
    catch{}
    return false
}

var alpha = [
    ["q","w","e","r","t","y","u","i","o","p","del"]
    ,["a","s","d","f","g","h","j","k","l","enter"]
    ,["z","x","c","v","b","n","m"]
]

var words = 
["ample", "blaze", "clove", "daisy", "ebony",
 "flair", "gazer", "hefty", "ivory", "joker", "karma", "leash", "mirth", "noble", "oasis", "panda", "quill", "razor", "shark", "tasty", "unify", "vixen", "waltz", "xerox", "yummy", "zebra", "ample", "blaze", "clove", "daisy", "ebony", "flair", "gazer", "hefty", "ivory", "joker", "karma", "leash", "mirth", "noble", "oasis", "panda", "quill", "razor", "shark", "tasty", "unify", "vixen", "waltz", "xerox", "yummy", "zebra", "ample", "blaze", "clove", "daisy", "ebony", "flair", "gazer", "hefty", "ivory", "joker", "karma", "leash", "mirth", "noble", "oasis", "panda", "quill", "razor", "shark", "tasty", "unify", "vixen", "waltz", "xerox", "yummy", "zebra", "ample", "blaze", "clove", "daisy", "ebony", "flair", "gazer", "hefty", "ivory", "joker", "karma", "leash", "mirth", "noble", "oasis", "panda", "quill", "razor", "shark", "tasty", "unify", "vixen", "waltz", "xerox", "yummy", "zebra", "ample", "blaze", "clove", "daisy", "ebony", "flair", "gazer", "hefty", "ivory", "joker", "karma", "leash", "mirth", "noble", "oasis", "panda", "quill", "razor", "shark", "tasty", "unify", "vixen", "waltz", "xerox", "yummy", "zebra","comet","storm","water"]


struct Game: View {
    @State var grid = [Array<chara>](repeating: [chara](repeating: chara(colour: 0, letter: " "), count: 5), count: 6)
    @State var keys = [Int](repeating: 0, count: 26)
    @State var answer = ""
    let model = words[Int.random(in: 0..<words.count)]
    
    @State var txti = 0
    @State var txtj = 0
    @State var isAlertPresented = false
    @State var alerttxt = ""
    @Environment(\.openURL) var openURL
    
    func mark()->Void{
        var mask = [Int](repeating: 0, count: 26)
        for k in model.utf8{mask[Int(k)-97] += 1;}
        
        for i in 0..<5{
            if(get(from: answer,pos: i) == get(from: model,pos: i)){
                grid[txti][i].colour = 1
                mask[ord(i:get(from: answer, pos: i))] -= 1
                keys[ord(i:get(from: answer, pos: i))] = 1
            }
            else{
                grid[txti][i].colour = 2
                if(keys[ord(i:get(from: answer, pos: i))] != 1){ keys[ord(i:get(from: answer, pos: i))] = 2}
            }
        }
        for i in 0..<5{
            if(mask[ord(i: get(from: answer, pos: i))] != 0){
                mask[ord(i:get(from: answer, pos: i))] -= 1
                grid[txti][i].colour = 3
                if(keys[ord(i:get(from: answer, pos: i))] != 1){
                    keys[ord(i:get(from: answer, pos: i))] = 3
                }
            }
        }
    }
    
    var body: some View {
        VStack{
            Text("WORDLE")
                .alert(isPresented:$isAlertPresented){
                    Alert(title: Text("non-exisitent word"),
                          message: Text(alerttxt),
                          dismissButton: .default(Text("ok")){
                        alerttxt = ""
                    })
                }
            ForEach(0..<6){i in HStack{
                ForEach(0..<5){j in
                    grid[i][j].display1()
                }
            }}
            ForEach(0..<3){
                i in HStack{ForEach(0..<alpha[i].count){
                    j in Button{
                        let key = alpha[i][j]
                        if(key == "del"){if(answer.count != 0){
                            answer.removeLast()
                            txtj -= 1
                            grid[txti][txtj].letter = ""
                        }}
                        else if(key == "enter"){
                            if answer.count != 5{
                                isAlertPresented = true
                                alerttxt = "Please type a 5 letter word"
                            }
                            else if(exists(str: answer) == false){
                                isAlertPresented = true
                                alerttxt = "the word doesn't exist"
                            }
                            else{
                                mark()
                                
                                answer = ""
                                txti += 1
                                txtj = 0
                            }
                        }
                        else{
                            if(answer.count != 5){
                                answer += key
                                grid[txti][txtj].letter = key
                                txtj += 1
                            }
                        }
                    }label: {
                        if(alpha[i][j] == "del"){chara(colour: 0,letter: alpha[i][j]).display1()}
                        else if(alpha[i][j] == "enter"){chara(colour: 0,letter: alpha[i][j]).display1()}
                        else{chara(colour: keys[ord(i: get(from: alpha[i][j],pos: 0))],letter: alpha[i][j]).display1()}
                    }
                }}
            }
        }
    }
}
