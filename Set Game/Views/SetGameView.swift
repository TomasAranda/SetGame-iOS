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
                dealedCardsView
                Spacer()
                newGameButton
            }
            HStack{
                deck
                Spacer()
                discardPile
            }
            .padding(.horizontal, 30)
        }.padding(.bottom, 10)
    }
    
    // MARK: -Deck
    
    private var deck: some View {
        ZStack {
            ForEach(game.deck) {card in
                let index = game.deck.firstIndex(where: { $0.id == card.id })!
                SetCardView(card: card, isMismatched: isMismatched(card))
                    .animation(.setGameDealAnimation(for: index))
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace, isSource: !game.dealedCards.contains { $0.id == card.id } &&
                        !game.matchedCards.contains { $0.id == card.id }
                    )
            }
            if(game.deck.count != 0) {
                RoundedRectangle(cornerRadius: 8.0)
                    .transition(.identity)
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

    // MARK: -Dealed Cards
    
    private var dealedCardsView: some View {
        AspectVGrid(items: game.dealedCards, aspectRatio: 4/7) { card in
            let index = game.dealedCards.firstIndex(where: { $0.id == card.id })!
            SetCardView(card: card, isMismatched: isMismatched(card))
                .animation(.setGameDealAnimation(for: index))
                .matchedGeometryEffect(id: card.id, in: dealingNamespace, isSource:
                    !game.deck.contains { $0.id == card.id } &&
                    !game.matchedCards.contains { $0.id == card.id }
                )
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
        }.padding(5)
    }
    
    private func isMismatched(_ card: SetGame.Card) -> Bool {
        game.selectedCards.count == 3 && !card.isMatched
    }
    
    // MARK: -Discarded cards
    
    private var discardPile: some View {
        ZStack {
            ForEach(game.matchedCards) {card in
                let index = game.matchedCards.firstIndex(where: { $0.id == card.id })!
                SetCardView(card: card, isMismatched: false)
                    .animation(.setGameDealAnimation(for: index))
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace, isSource:
                                !game.dealedCards.contains { $0.id == card.id } &&
                                !game.deck.contains { $0.id == card.id }
                    )
            }
            Color.clear
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
        game.dealCards()
        
        return SetGameView(game: game)
    }
}
