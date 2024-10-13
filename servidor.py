import subprocess
from flask import Flask, request, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)  # Habilitar CORS para todas las rutas

@app.route('/analyze', methods=['POST'])
def analyze():
    try:
        data = request.get_json()
        input_text = data['input']
        print(f"Texto recibido: {input_text}")  # Depuración

        # Escribir el texto de entrada en un archivo temporal
        with open('input.txt', 'w') as f:
            f.write(input_text)

        print("Archivo input.txt creado")  # Depuración

        # Ejecutar el analizador léxico con el archivo de entrada
        result = subprocess.run(['./analizador.exe', 'input.txt'], capture_output=True, text=True)
        
        # Depurar el resultado y cualquier error
        print(f"Return code: {result.returncode}")
        print(f"Standard output: {result.stdout}")
        print(f"Standard error: {result.stderr}")

        # Verificar si hubo un error en la ejecución del analizador
        if result.returncode != 0:
            return jsonify({'error': 'Error ejecutando analizador', 'details': result.stderr}), 500

        # Capturar y devolver la salida del analizador
        output_lines = result.stdout.splitlines()
        return jsonify({'resultado': output_lines})
    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)
