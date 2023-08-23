ARG PY_VERSION=3.8
ARG base_stage=stage3
# syntax=docker/dockerfile:1

FROM python:$PY_VERSION AS stage1
WORKDIR /app
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
RUN echo stage1

FROM stage1 AS stage2
RUN pip install numpy
RUN echo stage2

FROM stage2 AS stage3
RUN pip install -U pytest coverage
RUN echo stage3
COPY . .

FROM stage3 AS stage4
RUN echo stage4

FROM ${base_stage} AS stage5
RUN echo stage5
