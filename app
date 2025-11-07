from flask import Flask, request, send_from_directory, jsonify, send_file
import json
import os

app = Flask(__name__)

# Fichiers de sauvegarde
ESCOMPTE_FILE = 'escompte.json'
ENCAIS_FILE = 'encais.json'

# Initialisation des fichiers si absents
def init_files():
    if not os.path.exists(ESCOMPTE_FILE):
        with open(ESCOMPTE_FILE, 'w') as f:
            json.dump({
                "sourceAWB": [],
                "sourceCONF": [],
                "destAWB": [],
                "destCONF": []
            }, f, indent=2)

    if not os.path.exists(ENCAIS_FILE):
        with open(ENCAIS_FILE, 'w') as f:
            json.dump({
                "AWBe": [],
                "CONFe": []
            }, f, indent=2)

init_files()

# Routes pour ESCOMPTE
@app.route('/escompte.json')
def get_esc_data():
    return send_file(ESCOMPTE_FILE, mimetype='application/json')

@app.route('/escompte_save', methods=['POST'])
def save_esc_data():
    data = request.get_json()
    if not data or not isinstance(data, dict):
        return jsonify({"status": "error", "message": "Données invalides"}), 400
    with open(ESCOMPTE_FILE, 'w') as f:
        json.dump(data, f, indent=2)
    return jsonify({"status": "ok"})

# Routes pour ENCAIS
@app.route('/encais.json')
def get_encais_data():
    return send_file(ENCAIS_FILE, mimetype='application/json')

@app.route('/encais_save', methods=['POST'])
def save_encais_data():
    data = request.get_json()
    if not data or not isinstance(data, dict):
        return jsonify({"status": "error", "message": "Données invalides"}), 400
    with open(ENCAIS_FILE, 'w') as f:
        json.dump(data, f, indent=2)
    return jsonify({"status": "ok"})

# Servir les pages HTML
@app.route('/')
def index():
    return send_from_directory('.', 'escompte.html')

@app.route('/encais.html')
def encais_page():
    return send_from_directory('.', 'encais.html')

if __name__ == '__main__':
    app.run(debug=True, port=5000)
