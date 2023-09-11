# Use an official Python runtime as a parent image
FROM python:3.12-rc-slim

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container at /app
COPY requirements.txt /app/

# Create a virtual environment named "venv"
RUN python -m venv venv

# Activate the virtual environment
SHELL ["/bin/bash", "-c"]
RUN source venv/bin/activate

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application's source code to the container
COPY . /app/

# Specify the command to run your FastAPI application on port 1234
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "1234"]
