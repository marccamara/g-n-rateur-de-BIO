from flask import Flask, render_template, request, jsonify
import random

app = Flask(__name__)

variants = {
    "I": ["ℹ️", "Ꭵ", "Ⅰ", "ᛁ", "ǀ"],
    "N": ["🅽", "ᴺ", "η", "₦", "∏"],
    "S": ["💲", "§", "Ⴝ", "Ƨ", "Ṣ", "$", "𝒮"],
    "T": ["🆃", "🅃", "✝", "†", "⊤", "Ŧ", "₮", "𝕋"],
    "A": ["🅰️", "△", "▲", "⩓", "∀", "ᗅ", "Ⱥ", "𝒜"],
    "G": ["🅶", "Ⓖ", "Ꮆ", "𝒢", "Ǥ", "Ɡ", "Ꮐ"],
    "R": ["Ⓡ", "ℛ", "Я", "ᴙ", "®", "Ꭱ", "ℜ", "Ꮢ"],
    "M": ["Ⓜ️", "ɱ", "♏", "ᴹ", "𝕄", "Ⲙ"]
}
order = ["I","N","S","T","A","G","R","A","M"]

debut = ["Pas fan des chichis.","Ambiance chill.","Ici, on profite sans stress."]
milieu = ["Pour un moment tranquille,","Avec le sourire,","Pour partager un bon moment,"]
fin = ["Mon appart est libre ;)","Viens quand tu veux !","Passe me voir !"]

def generate_instagram():
    return "".join(random.choice(variants[letter]) for letter in order)

def generate_sentence(username):
    return f"{random.choice(debut)} {random.choice(milieu)} {random.choice(fin)} Passe par {generate_instagram()} : {username}"

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/generate', methods=['POST'])
def generate():
    data = request.get_json()
    username = data.get('username', '').strip() or 'Anonyme'
    phrase = generate_sentence(username)
    return jsonify({'phrase': phrase})

if __name__ == '__main__':
    app.run(debug=True)
