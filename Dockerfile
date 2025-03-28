FROM python:3.10-slim

# Install dependencies
RUN apt-get update && apt-get install -y git

# Create the /etc/searxng directory
RUN mkdir -p /etc/searxng

# Clone the SearxNG source and install requirements
RUN git clone https://github.com/searxng/searxng.git /app
WORKDIR /app
RUN pip install -r requirements.txt

# Optionally, copy your custom settings if you have them:
# COPY settings.yml /etc/searxng/settings.yml
# COPY uwsgi.ini /etc/searxng/uwsgi.ini

# Expose the port (Railway sets the PORT env variable)
EXPOSE 8080

# Start SearxNG, binding to 0.0.0.0 and using the PORT provided by Railway
CMD ["sh", "-c", "python searx/webapp.py --host=0.0.0.0 --port=${PORT:-8080}"]
