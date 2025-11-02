<<<<<<< HEAD
# version from GitHub (remote)
FROM python:3.9-slim
WORKDIR /app
COPY . .
RUN pip install -r requirements.txt
CMD ["python", "app.py"]
=======
# version from your local commit (Added Helm chart for ArgoCD deployment)
FROM python:3.9
WORKDIR /app
COPY . .
RUN pip install --no-cache-dir -r requirements.txt
CMD ["python", "app.py"]
>>>>>>> 9972a6a (Added Helm chart for ArgoCD deployment)
