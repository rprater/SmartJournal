from flask import Flask, request
from google.cloud import language
from dotenv import load_dotenv

app = Flask(__name__)
load_dotenv()

@app.route('/sentiment', methods=['POST'])
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