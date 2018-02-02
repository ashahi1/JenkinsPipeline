FROM ubuntu

RUN apt-get update
RUN apt-get install -y curl

COPY HelloWorld.sh /HelloWorld.sh

CMD ["/HelloWorld.sh"]

