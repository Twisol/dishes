*Dishes is a Rack-based Ruby framework that makes it easy to write real-time web applications.*

Why Dishes?
===========
Classically, the HTTP protocol is strictly request/response based. The client __always__ sends a request first; the server can't send data to a client arbitrarily. Workarounds using Ajax exist (such as [long polling][long-polling]), but they almost always tie up a whole connection until the server has something to say. Some browsers allow only a small number of active connections, placing a heavy upper-limit on what can be done simultaneously.

Dishes takes a different approach to this problem, requiring __only two connections__. One connection is used to send a request to the server, which is *immediately* closed so it can be reused. A second connection uses long-polling to stay open, which the server uses to send results back to the client. Whenever the long-polling connection is closed, it is re-opened to wait for updates. (This is the same model that the [BOSH protocol][bosh] uses.)

This makes Dishes a perfect fit for rich applications like real-time chat and other applications with a lot of client/server communication.


How to Use
==========
Dishes is under heavy development at this time, so there is no official RubyGems package. Feel free to clone or fork it and play around though!

At this time, [Thin][thin] is required to use Dishes. Hopefully other (evented) webservers will be supported in the future!


Misc
====
See examples/basic.ru for the current target syntax/feature-set. It's practically guaranteed not to work at this time, but it paints a pretty picture.

The name "Dishes" is an extraordinarily lame pun. "Asynchronous" sounds like it has a "sink" in it, and sinks contain dishes. See, I told you it was lame.


  [long-polling]: http://en.wikipedia.org/wiki/Long_polling#Long_polling "Long polling at Wikipedia"
  [bosh]: http://en.wikipedia.org/wiki/BOSH "BOSH at Wikipedia"
  [thin]: http://code.macournoyer.com/thin/ "The Thin webserver"