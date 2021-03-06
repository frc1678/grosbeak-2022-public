FROM python:3.8.10

WORKDIR /code

COPY ./pyproject.toml /code/pyproject.toml

ENV PYTHONPATH=${PYTHONPATH}:${PWD} 

RUN pip3 install poetry==1.2.0b1
RUN poetry config virtualenvs.create false
RUN poetry install --without dev

COPY ./grosbeak /code/grosbeak

COPY ./team-lists /code/team-lists

COPY ./match-schedules /code/match-schedules

CMD ["uvicorn", "grosbeak.main:app", "--proxy-headers", "--host", "0.0.0.0", "--port", "80"]