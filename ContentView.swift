import SwiftUI

struct ContentView: View {
    @State private var username: String = "louclr06"
    @State private var generatedBio: String = ""
    @State private var showCopiedAlert = false
    @FocusState private var isInputFocused: Bool
    
    let zeroWidthSpace = "\u{200B}"
    
    let wordVariants = [
        "I\u{200B}n\u{200B}s\u{200B}t\u{200B}a",
        "I.n.s.t.a",
        "I n s t a",
        "l'autre réseau",
        "l'appareil photo 📸",
        "mon lG",
        "le réseau rose 📸"
    ]
    
    let debut = [
        "Plus branchée café en terrasse que soirées trop bruyantes,",
        "Ici pour faire de chouettes rencontres sans prise de tête,",
        "Ambiance chill, bonne humeur et zéro prise de tête ici,",
        "Toujours partante pour une bonne discussion ou un verre,",
        "Grande amatrice de moments simples et de fous rires,",
        "Un mélange de curiosité, de chill et d'un brin de folie,",
        "Simple, spontanée et toujours de bonne humeur,",
        "Pas là pour perdre mon temps mais pour échanger avec le sourire,",
        "Si tu aimes les bonnes vibes et la simplicité, tu es au bon endroit,",
        "Plutôt team discussions spontanées et bonnes adresses,",
        "Ici c'est la détente avant tout et zéro chichi,",
        "Un bon feeling vaut mieux que des milliers de messages,"
    ]
    
    let milieu = [
        "si tu cherches à papoter sereinement,",
        "pour échanger quelques messages sympas,",
        "si tu veux vérifier si le courant passe bien,",
        "histoire de faire plus ample connaissance,",
        "pour partager tes meilleures anecdotes,",
        "si l'envie de discuter te prend,",
        "pour un échange plus fluide et spontané,",
        "si tu veux éviter les bugs de l'application,",
        "pour continuer la discussion sans attendre,"
    ]
    
    let fin = [
        "retrouve-moi directement sur",
        "rejoins-moi plutôt sur",
        "on se fait un coucou sur",
        "fais un tour sur",
        "je réponds plus vite sur",
        "passe par",
        "fais-moi un signe sur",
        "je suis bien plus active sur"
    ]
    
    var body: some View {
        ZStack {
            // Fond dégradé dynamique plein écran
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.08, green: 0.05, blue: 0.15),
                    Color(red: 0.02, green: 0.02, blue: 0.05)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // Halo lumineux décoratif en arrière-plan
            Circle()
                .fill(Color.pink.opacity(0.15))
                .blur(radius: 80)
                .offset(x: -100, y: -200)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 24) {
                    
                    // --- Header ---
                    VStack(spacing: 8) {
                        Text("🍓 BioGenerator")
                            .font(.system(size: 32, weight: .black, design: .rounded))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.pink, .orange],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                        
                        Text("Anti-Filter • Glassmorphism Edition")
                            .font(.system(size: 13, weight: .semibold, design: .monospaced))
                            .foregroundColor(.gray.opacity(0.8))
                    }
                    .padding(.top, 20)
                    
                    // --- Carte 1 : Input Pseudo (Modifiable) ---
                    VStack(alignment: .leading, spacing: 10) {
                        Text("PSEUDO INSTAGRAM")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(.pink)
                            .padding(.leading, 4)
                        
                        HStack {
                            Image(systemName: "at")
                                .foregroundColor(.pink)
                                .font(.system(size: 18, weight: .bold))
                            
                            TextField("Entre ton pseudo...", text: $username)
                                .font(.system(size: 17, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                                .focused($isInputFocused)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                            
                            if !username.isEmpty {
                                Button(action: { username = "" }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .padding(16)
                        .background(Color.white.opacity(0.06))
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.white.opacity(0.12), lineWidth: 1)
                        )
                    }
                    .padding(.horizontal, 20)
                    
                    // --- Carte 2 : Zone de Résultat ---
                    VStack(alignment: .leading, spacing: 10) {
                        Text("BIO GÉNÉRÉE & OBFUSQUÉE")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(.pink)
                            .padding(.leading, 4)
                        
                        VStack {
                            TextEditor(text: .constant(generatedBio.isEmpty ? "Tape sur 'Générer' pour créer une bio..." : generatedBio))
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                .foregroundColor(generatedBio.isEmpty ? .gray : .white)
                                .scrollContentBackground(.hidden)
                                .frame(height: 140)
                        }
                        .padding(14)
                        .background(Color.black.opacity(0.4))
                        .cornerRadius(18)
                        .overlay(
                            RoundedRectangle(cornerRadius: 18)
                                .stroke(
                                    LinearGradient(colors: [.pink.opacity(0.6), .clear], startPoint: .topLeading, endPoint: .bottomTrailing),
                                    lineWidth: 1.5
                                )
                        )
                    }
                    .padding(.horizontal, 20)
                    
                    // --- Carte 3 : Boutons d'action ---
                    VStack(spacing: 14) {
                        // Bouton Générer
                        Button(action: {
                            isInputFocused = false
                            generateBio()
                        }) {
                            HStack {
                                Image(systemName: "sparkles")
                                Text("Générer une Bio")
                            }
                            .font(.system(size: 17, weight: .bold, design: .rounded))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                LinearGradient(colors: [.pink, Color(red: 1.0, green: 0.3, blue: 0.5)], startPoint: .leading, endPoint: .trailing)
                            )
                            .foregroundColor(.white)
                            .cornerRadius(16)
                            .shadow(color: .pink.opacity(0.4), radius: 10, x: 0, y: 5)
                        }
                        
                        // Bouton Copier
                        Button(action: copyToClipboard) {
                            HStack {
                                Image(systemName: "doc.on.doc.fill")
                                Text("Copier dans le presse-papiers")
                            }
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(generatedBio.isEmpty ? Color.white.opacity(0.05) : Color.white.opacity(0.12))
                            .foregroundColor(generatedBio.isEmpty ? .gray : .white)
                            .cornerRadius(16)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.white.opacity(0.15), lineWidth: 1)
                            )
                        }
                        .disabled(generatedBio.isEmpty)
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer(minLength: 30)
                }
            }
        }
        .alert(isPresented: $showCopiedAlert) {
            Alert(
                title: Text("Copié ! 📋"),
                message: Text("La bio à caractères invisibles est prête à être collée sur Fruitz."),
                dismissButton: .default(Text("OK"))
            )
        }
        .onAppear {
            generateBio()
        }
    }
    
    // --- Algorithme d'obfuscation ---
    func obfuscate(text: String) -> String {
        return text.map { String($0) }.joined(separator: zeroWidthSpace)
    }
    
    // --- Génération de la phrase ---
    func generateBio() {
        let cleanUser = username.trimmingCharacters(in: .whitespacesAndNewlines)
        let finalUser = cleanUser.isEmpty ? "ton_pseudo" : cleanUser
        let obfUser = obfuscate(text: finalUser)
        
        let network = wordVariants.randomElement() ?? "l'autre réseau"
        let d = debut.randomElement() ?? ""
        let m = milieu.randomElement() ?? ""
        let f = fin.randomElement() ?? ""
        
        generatedBio = "\(d) \(m) \(f) \(network) (\(obfUser))"
    }
    
    // --- Copie dans le presse-papiers ---
    func copyToClipboard() {
        UIPasteboard.general.string = generatedBio
        showCopiedAlert = true
    }
}
