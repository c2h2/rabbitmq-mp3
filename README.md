rabbitmq-mp3
============

transmitting mp3 to client queue and playback on linux machines.

requirments
===========

install rabbit-server, mpg123 and amqp gem, for example on ubuntu machine would be:

    sudo apt-get isntall rabbitmq-server mpg123
    gem install amqp



on the emiiter side
===================

+ configure rabbit server address emit_mp3.rb
+ run by: ruby emit_mp3.rb mp3file.mp3


on the receive side
===================

+ configure rabbit server address in the receive_mp3.rb
+ run by: ruby receive_mp3.rb


