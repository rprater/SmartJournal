# set the template to run from
FROM python:3

# Add the code
WORKDIR /app
COPY ./ /app

# install the dependencies
RUN pip install -r requirements.txt

# run the project
CMD ["python", "AsyncSetUp.py"]