import markdown
import os
import shelve

#Import the framework
from flask import Flask, g
from flask import request, jsonify, make_response
#from flask_restful import Resource, Api, reqparse
from flask_socketio import SocketIO, send, emit


# Create the API
#api = Api(app)

# Create socket connector
socketio = SocketIO()

def create_app(package_name):
    app = Flask(package_name)

    socketio.init_app(app, engineio_logger=False, async_mode='gevent')
    return app

#Create the app
app = create_app(__name__)
app.config['SECRET_KEY'] = 'mysecretkeyisverysecretrealydontsmiletoyourscreen'



#TEMP DATA STORE
questions = []


#Create DB
def get_db():
    db = getattr(g, '_database', None)
    if db is None:
        db = g._database = shelve.open("questions.db")
    return db

@app.teardown_appcontext
def teardown_db(exception):
    db = getattr(g, '_database', None)
    if db is not None:
        db.close()


#API DEFINITIONS
@app.route("/")
def index():
    ''' Present some documentation ''' 

    #Open the Readme file
    with open(os.path.dirname(app.root_path) + '/README.md', 'r') as markdown_file:
        #Read the content of the file
        content = markdown_file.read()
        #Convert to HTML
        return markdown.markdown(content)


@app.route('/sendquestion', methods=['POST'])
def sendQuestion():
    ''' Read question from HttpBoady and forward it to the mobile app '''

    data = request.get_json()

    newQuestion = Question(id=data['id'], title=data['title'])
    newQuestion.answers=[]
    
    for a in data['answers']:
            newAnswer = Answer(id=a['id'], title=a['title'], isSelected=a['isSelected'], isCorrect=a['isCorrect'] )
            newQuestion.answers.append(newAnswer)
    
    questions.append(newQuestion)
    
    #Alert Mobile Evet Handler here
    socketio.emit('new_question', { "status" : 0, "errorText" : "", "response" : data} )

    return jsonify({ "message" : "Question Sent!", 'response' : data }), 200


@app.route('/questions', methods=['GET'])
def get_all_guestions():

        response = []
        for q in questions:
                qResponse = {}
                qResponse['id'] = q.id
                qResponse['title'] = q.title
                answers = []

                for a in q.answers:
                        aResponse = {}
                        aResponse['id'] = a.id
                        aResponse['title'] = a.title
                        aResponse['isSelected'] = a.isSelected
                        aResponse['isCorrect'] = a.isCorrect
                        answers.append(aResponse)
                
                qResponse['answers'] = answers
                response.append(qResponse)


        return jsonify({'message':'success', 'response' : response}), 200




#SOCKET HANDLERS
@socketio.on('hello')
def handleHello(data):
        print('Client says', data)







class Question:
        id = 0
        title = ""
        answers = []

        def __init__(self, id, title):
                self.id = id
                self.title = title
                self.answers = []

class Answer:
        id = 0
        title = ""
        isSelected = False
        isCorrect = False

        def __init__(self, id, title, isSelected, isCorrect):
                self.id = id
                self.title = title
                self.isSelected = isSelected
                self.isCorrect = isCorrect