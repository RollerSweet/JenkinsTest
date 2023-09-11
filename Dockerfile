FROM python:3.12-rc-slim

WORKDIR /app

COPY requirements.txt /app/

RUN python -m venv venv

SHELL ["/bin/bash", "-c"]
RUN source venv/bin/activate

RUN pip install --no-cache-dir -r requirements.txt

COPY . /app/

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "1234"]
