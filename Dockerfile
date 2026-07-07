#use python 3.13 base image
FROM python:3.13.11

#Set working directory
WORKDIR /app

#Copy requirements and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

#Copy rest of application code
COPY . .

#Expose the application port
EXPOSE 8000  
EXPOSE 8501  

# Start both FastAPI and Streamlit
CMD ["uvicorn app:app --host 0.0.0.0 --port 8000 & streamlit run streamlit_app.py --server.address=0.0.0.0 --server.port=8501"]