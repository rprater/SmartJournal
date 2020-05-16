import json

from flask import Flask, request, jsonify
from google.cloud import language_v1 as language
from dotenv import load_dotenv

app = Flask(__name__)
load_dotenv()

@app.route('/text/sentiment_analysis', methods=['POST'])
def sentiment_analysis():
    client = language.LanguageServiceClient()

    document = language.types.Document(
        content=request.form['text'],
        type="PLAIN_TEXT"
    )

    response = client.analyze_sentiment(
        document=document,
        encoding_type='UTF32'
    )

    return {
        "score": response.document_sentiment.score,
        "magnitude": response.document_sentiment.magnitude
    }

@app.route('/text/entity_analysis', methods=['POST'])
def entity_analysis():
    client = language.LanguageServiceClient()

    document = language.types.Document(
        content=request.form['text'],
        type=language.enums.Document.Type.PLAIN_TEXT
    )
    
    response = client.analyze_entities(
        document=document,
        encoding_type='UTF32'
    )

    entities = []

    for entity in response.entities:
        entities.append({
            "name": entity.name,
            "type": language.enums.Entity.Type(entity.type).name,
            "salience": entity.salience
        })

    return jsonify(entities)