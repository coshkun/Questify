from api_main import app, socketio

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=80, debug=True)
    #socketio.run(app)

