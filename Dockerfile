FROM python:3.10-slim

# Install dependencies
RUN apt-get update && apt-get install -y git

# Clone the SearxNG repository into /app
RUN git clone https://github.com/searxng/searxng.git /app
WORKDIR /app

# Install required Python packages
RUN pip install -r requirements.txt

# Install SearxNG as a package in editable mode
RUN pip install -e .

# Expose the port (Railway sets the PORT environment variable)
EXPOSE 8080

# Start SearxNG, binding to 0.0.0.0 using the PORT provided by Railway
CMD ["sh", "-c", "python searx/webapp.py --host=0.0.0.0 --port=${PORT:-8080}"]
