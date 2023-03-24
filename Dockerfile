FROM python:3

COPY wes_bamcompare.py /app/wes_bamcompare.py

RUN pip install pandas
RUN pip install numpy
       
CMD ["python", "/app/wes_bamcompare.py"]
