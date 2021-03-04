FROM tensorflow/tensorflow:latest-gpu
RUN groupadd -r fantine -g 901 && useradd -u 901 -r -g fantine
