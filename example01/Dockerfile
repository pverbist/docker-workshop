FROM alpine
MAINTAINER Peter Verbist <peter.verbist@vasco.com>
RUN apk update && apk add ruby
RUN mkdir average
ADD average.rb average/
WORKDIR average
ENTRYPOINT ["ruby","average.rb"]
