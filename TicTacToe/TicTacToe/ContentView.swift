//
//  ContentView.swift
//  TicTacToe
//
//  Created by Rohan Kumar on 11/07/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var players = ["", ""]
    
    var body: some View {
        NavigationView {
            
            ZStack{
                Color.black.ignoresSafeArea()
                VStack {
                    //Background Image
                    Image("game-ui")
                        .renderingMode(.original)
                        .resizable()
                        .ignoresSafeArea(edges: .horizontal)
                }
                VStack {
                    
                    Spacer()
                    Spacer()
                    Spacer()
                    //User Input for the Players Names
                    TextField("Enter Player 1's Name", text: $players[0])
                        .frame(width: 200, height: 0)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                        .autocorrectionDisabled()
                    TextField("Enter Player 2's Name", text: $players[1])
                        .frame(width: 200, height: 80)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                        .autocorrectionDisabled()
                    
                    Spacer()
                    
                    //Navigating to another view
                    NavigationLink {
                        gameView(players: $players)
                    } label: {
                        Text("Start Game")
                            .fontWeight(.heavy)
                            .fontDesign(.monospaced)
                    }
                    
                    Spacer()
                    Spacer()
                }
            }
        }.ignoresSafeArea(.keyboard, edges: .all)
    }
    
    func isNameEntered(p1: String, p2: String) -> Bool{
        if p1.count > 0 && p2.count > 0 {
            return true;
        }
        return false;
    }
}


struct gameView: View {
    var defaultImg = "questionmark.app"
    
    @Binding var players: [String];
    @State private var turn = 1;
    @State private var imgs1 = ["questionmark.app", "questionmark.app", "questionmark.app"]
    @State private var imgs2 = ["questionmark.app", "questionmark.app", "questionmark.app"]
    @State private var imgs3 = ["questionmark.app", "questionmark.app", "questionmark.app"]
    @State private var winnerDecided = false
    @State private var playedMoves = 0;
    
    
    var body: some View {
        ZStack {
            LinearGradient.init(gradient: Gradient(colors: [.indigo, .black, .cyan]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Tic Tac Toe")
                    .font(.system(size: 45))
                    .foregroundColor(.white)
                    .bold()
                Spacer()
                Text("\(players[turn-1])'s Turn")
                    .foregroundColor(.white)
                    .font(.title)
                    .bold()
                
                Spacer()
                VStack(spacing: 10) {
                    HStack {
                        ForEach(0...2, id: \.self){ i in
                            Button {
                                placeImage(row: 1, index: i)
                            } label: {
                                Image(systemName: imgs1[i])
                                    .font(.system(size: 60))
                                    .shadow(radius: 20)
                            }
                        }
                    }
                    HStack {
                        ForEach(0...2, id: \.self){ i in
                            Button {
                                placeImage(row: 2, index: i)
                            } label: {
                                Image(systemName: imgs2[i])
                                    .font(.system(size: 60))
                                    .shadow(radius: 20)
                            }
                        }
                    }
                    HStack {
                        ForEach(0...2, id: \.self){ i in
                            Button {
                                placeImage(row: 3, index: i)
                            } label: {
                                Image(systemName: imgs3[i])
                                    .font(.system(size: 60))
                                    .shadow(radius: 20)
                            }
                        }
                    }
                }
                
                Spacer()
                Spacer()
                Spacer()
                Spacer()
            }
        }
        
    }
    
    //places the image of the player
    func placeImage(row: Int, index: Int) {
        if turn == 1 {
            if row == 1 {
                if imgs1[index] == defaultImg {
                    imgs1[index] = "o.square.fill"
                    playedMoves+=1
                    if playedMoves >= 5 {
                        winnerDecided = checkWinner(row: row)
                    }
                    turn = 2
                }
            } else if row == 2 {
                if imgs2[index] == defaultImg {
                    imgs2[index] = "o.square.fill"
                    playedMoves+=1
                    if playedMoves >= 5 {
                        winnerDecided = checkWinner(row: row)
                    }
                    turn = 2
                }
            } else if row == 3 {
                if imgs3[index] == defaultImg {
                    imgs3[index] = "o.square.fill"
                    playedMoves+=1
                    if playedMoves >= 5 {
                        winnerDecided = checkWinner(row: row)
                    }
                    turn = 2
                }
            }
            
        } else if turn == 2 {
            if row == 1 {
                if imgs1[index] == defaultImg {
                    imgs1[index] = "x.square.fill"
                    playedMoves+=1
                    if playedMoves >= 5 {
                        winnerDecided = checkWinner(row: row)
                    }
                    turn = 1
                }
            } else if row == 2 {
                if imgs2[index] == defaultImg {
                    imgs2[index] = "x.square.fill"
                    playedMoves+=1
                    if playedMoves >= 5 {
                        winnerDecided = checkWinner(row: row)
                    }
                    turn = 1
                }
            } else if row == 3 {
                if imgs3[index] == defaultImg {
                    imgs3[index] = "x.square.fill"
                    playedMoves+=1
                    if playedMoves >= 5 {
                        winnerDecided = checkWinner(row: row)
                    }
                    turn = 1
                }
            }
        }
        
    }
    
    //decides who won the game
    func checkWinner (row: Int) -> Bool {
        if row == 1 {
            if imgs1[0]==imgs1[1] && imgs1[1]==imgs1[2] {
                return true
            }
            if imgs1[0] == imgs2[0] && imgs2[0] == imgs3[0] {
                return true
            }
            if imgs1[0] == imgs2[1] && imgs3[2]==imgs2[1] {
                return true
            }
        }
        else if row == 2 {
            if imgs2[0] == imgs2[1] && imgs2[1]==imgs2[2] {
                return true
            }
            if imgs2[0] == imgs1[0] && imgs1[0] == imgs3[0] {
                return true
            }
        }
        else if row == 3 {
            if imgs3[0] == imgs3[1] && imgs3[1]==imgs3[2] {
                return true
            }
            if imgs3[0] == imgs2[1] && imgs2[1]==imgs1[2] {
                return true
            }
            if imgs3[0] == imgs1[0] && imgs1[0] == imgs2[0] {
                return true
            }
        }
        return false
    }
    
    //Send an alert to who won
    func announceWinner(playerName: String) {
        NavigationView{
            ZStack {
                NavigationLink {
                    winnerScreen(winnerName: playerName)
                } label: {
                    Text("Winner!")
                }
            }
        }
    }
}


//announcing winner screen
struct winnerScreen: View {
    @State var winnerName: String;
    
    var body: some View {
        Text("Hello world")
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
