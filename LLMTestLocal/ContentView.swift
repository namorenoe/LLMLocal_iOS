//
//  ContentView.swift
//  LLMTestLocal
//
//  Created by Nicolas Moreno on 6/05/24.
//

import SwiftUI
import LLM

class Bot: LLM {
    
    convenience init() {
        let url = Bundle.main.url(forResource: "Phi-3-mini-4k-instruct-q4", withExtension: "gguf")!
        let systemPrompt = "You are an AI assistant with short answers"
        self.init(from: url, template: .chatML(systemPrompt))
    }
}

struct BotView: View {
    @ObservedObject var bot: Bot
    @State var input = "Some"
    init(_ bot: Bot) { self.bot = bot }
    func respond() { Task { await bot.respond(to: input) } }
    func stop() { bot.stop() }
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView { Text(bot.output)}
            Spacer()
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 8).foregroundStyle(.thinMaterial).frame(height: 40)
                    TextField("input", text: $input).padding(8)
                }
                Button(action: respond) { Image(systemName: "paperplane.fill") }
            }
        }.frame(maxWidth: .infinity).padding()
    }
}

struct ContentView: View {
    var body: some View {
        BotView(Bot())
    }
}

#Preview {
    ContentView()
}

