import SwiftUI
import AVFoundation

struct ContentView: View {
    private let tts = TextToSpeech()
    private let story = """
    Hello, I am Jordan, an iOS Dev. This is a simplified Text-to-Speech App. 
    I've been writing code for about 5 years in SwiftUI. 
    I have spent about 10 years reconfiguring computer towers and implementing low-level UI tabs 
    to assist companies' employees with their workflow. 
    I like long walks on the beach and pizza. 
    I am available to begin working as soon as possible. Boom Shacka Lacka.
    """

    @State private var userText = ""
    @State private var savedTexts: [String] = []
    private let paletteColors: [Color] = [.yellow, .orange, .pink, .purple, .green, .blue]

    var body: some View {
        ZStack {
            Color(red: 173/255, green: 216/255, blue: 230/255) // Baby blue background
                .edgesIgnoringSafeArea(.all)

            ScrollView { // Allow full story viewability with scrolling
                VStack(spacing: 20) {
                    Text(story)
                        .padding()
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .font(.system(size: 18, weight: .medium))
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Button("Speak Story") {
                        tts.speak(text: story)
                    }
                    .padding()
                    .background(Color.white)
                    .foregroundColor(.blue)
                    .clipShape(Capsule())
                    .shadow(radius: 3)

                    TextField("Enter text to speak", text: $userText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    HStack {
                        Button("Speak User Text") {
                            tts.speak(text: userText)
                        }
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.blue)
                        .clipShape(Capsule())
                        .shadow(radius: 3)

                        Button("Save") {
                            if !userText.isEmpty {
                                savedTexts.append(userText)
                                userText = "" // Clear input after saving
                            }
                        }
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .shadow(radius: 3)
                    }

                    LazyVStack(spacing: 10) {
                        ForEach(savedTexts.indices, id: \.self) { index in
                            HStack {
                                Text(savedTexts[index])
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(paletteColors[index % paletteColors.count])
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    .shadow(radius: 3)
                                    .foregroundColor(.white)

                                Button(action: {
                                    tts.speak(text: savedTexts[index])
                                }) {
                                    Image(systemName: "speaker.wave.3.fill")
                                        .foregroundColor(.black)
                                }
                                .padding()

                                Button(action: {
                                    savedTexts.remove(at: index)
                                }) {
                                    Image(systemName: "trash.fill")
                                        .foregroundColor(.red)
                                }
                                .padding()
                            }
                        }
                    }
                    .padding()
                }
            }
            .padding()
        }
    }
}
