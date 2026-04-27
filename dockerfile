FROM python:3.9-alpine

WORKDIR /app

# Create non-root user
RUN adduser -D appuser

COPY requirements.txt .

# Install dependencies securely
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Switch to non-root user
USER appuser

EXPOSE 5000

CMD ["python", "app.py"]