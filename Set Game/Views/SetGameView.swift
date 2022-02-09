//
//  ContentView.swift
//  Set Game
//
//  Created by Tomás Aranda on 01/12/2021.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var game: SetGameViewModel
    
    @Namespace private var dealingNamespace
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                dealedCards
                Spacer()
                newGameButton
            }
            HStack{
                deck
                Spacer()
                matchedCards
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 40)
        }
    }
    
    private func isUndealt(_ card: SetGame.Card) -> Bool {
        game.dealedCards.first(where: {$0.id == card.id}) != nil
    }
    
    private var dealedCards: some View {
        AspectVGrid(items: game.dealedCards, aspectRatio: 4/7) { card in
            if card.isMatched {
                Color.clear
            } else {
                SetCardView(card: card)
                    .animation(dealAnimation(for: card))
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .opacity))
                    .zIndex(zIndex(of: card))
                    .padding(3)
                    .onTapGesture {
                        var transaction = Transaction(animation: .easeInOut(duration: 0.5))
                        transaction.disablesAnimations = true
                        withAnimation {
                            withTransaction(transaction) {
                                game.choose(card)
                            }
                        }
                    }
            }
        }.padding(5)
        
    }

    private func dealAnimation(for card: SetGame.Card) -> Animation {
        var delay = 0.0
        if let index = game.deck.firstIndex(where: { $0.id == card.id }) {
            if(index < 12) {
                delay = Double(index) * (1.0 / 12.0)
            } else {
                delay = Double((index % 3) + 1) * (0.5 / 3.0)
            }
        }
        return Animation.easeInOut(duration: 0.5).delay(delay)
    }
    
    private func zIndex(of card: SetGame.Card) -> Double {
        -Double(game.deck.firstIndex(where: { $0.id == card.id }) ?? 0)
    }
    
    private var deck: some View {
        ZStack {
            ForEach(game.deck) {card in
                if isUndealt(card) {
                    Color.clear
                } else {
                    SetCardView(card: card)
                        .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                        .transition(.asymmetric(insertion: .opacity, removal: .identity))
                        .zIndex(zIndex(of: card))
                }
            }
            if(game.numberOfDealedCards != 81) {
                RoundedRectangle(cornerRadius: 8.0)
                    .foregroundColor(.blue)
                    .onTapGesture {
                        withAnimation {
                            game.dealCards()
                        }
                    }
                Text("Deal")
            }
        }
        .frame(width: 40, height: 70)
    }
    
    private var matchedCards: some View {
        ZStack {
            ForEach(game.matchedCards) {card in
                if !card.isMatched {
                    Color.clear
                } else {
                    SetCardView(card: card)
                        .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                        .transition(.asymmetric(insertion: .opacity, removal: .identity))
                }
            }
        }
        .frame(width: 40, height: 70)
    }
    
    private var newGameButton: some View {
        Button {
            withAnimation {
                game.newGame()
            }
        } label: {
            Text("New Game")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        let game = SetGameViewModel()
        
        return SetGameView(game: game)
//            .preferredColorScheme(.dark)
    }
}
