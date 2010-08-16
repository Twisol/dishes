*Dishes is a Rack-based Ruby framework that makes it easy to write real-time web applications.*

Why Dishes?
===========
Classically, the HTTP protocol is strictly request/response based. The client __always__ sends a request first; the server can't send data to a client arbitrarily. Workarounds using Ajax exist (such as [long polling][long-polling]), but they almost always tie up a whole connection until the server has something to say. Some browsers allow only a small number of active connections, placing a heavy upper-limit on what can be done simultaneously.

Dishes takes a different approach to this problem, requiring __only two connections__. One connection is used to send a request to the server, which is *immediately* closed so it can be reused. A second connection uses long-polling to stay open, which the server uses to send results back to the client. Whenever the long-polling connection is closed, it is re-opened to wait for updates. (This is the same model that the [BOSH protocol][bosh] uses.) This makes Dishes a perfect fit for rich applications like real-time chat and other applications with a lot of client/server communication.

Dishes is written specifically for *my* needs, so it may not fit yours exactly. There are other Comet-based alternatives, including (but not limited to):

- [node.js](http://nodejs.org/ Node.js) - An asynchronous server-side framework written in Javascript.
- [Meteor](http://meteorserver.org/ Meteor Server) - A Comet server written in Perl.

Dishes can be dropped right into a Rack server with minimal pain, coexisting with other applications (such as a Sinatra app) on the same port and domain. You only need to map one URL to a Dishes app, for example "/dishes".


How to Use
==========
Dishes is under heavy development at this time, so there is no official RubyGems package. Feel free to clone or fork it and play around though!

At this time, [Thin][thin] is required to use Dishes. Hopefully other (evented) webservers will be supported in the future!


Misc
====
See [basic.ru](http://github.com/Twisol/dishes/blob/master/examples/basic.ru "A basic Dishes app") for the current target syntax/feature-set. It's practically guaranteed not to work at this time, but it paints a pretty picture.

The name "Dishes" is an extraordinarily lame pun. "Asynchronous" sounds like it has a "sink" in it, and sinks contain dishes. See, I told you it was lame.


  [long-polling]: http://en.wikipedia.org/wiki/Long_polling#Long_polling "Long polling at Wikipedia"
  [bosh]: http://en.wikipedia.org/wiki/BOSH "BOSH at Wikipedia"
  [thin]: http://code.macournoyer.com/thin/ "The Thin webserver"