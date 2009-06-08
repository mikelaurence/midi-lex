# MidiLex

http://github.com/mikelaurence/midi-lex/tree/master

## DESCRIPTION:

A soon-to-be-cross-platform library for Ruby MIDI input & output (full dupLEX, get it? Hey, you gotta come up with a name somehow!)

*MidiLex is currently in heavy development and only has drivers for MacRuby, as that is the author's main priority at the moment :-)

Note:
This project owes a great deal to earlier efforts by fellow ruby MIDIists, including but not limited to:

* Topher Cyll, whose "Practical Ruby Projects" book jumpstarted the whole Ruby MIDI movement, and whose core external (DL) code is still utilized by this library
* Ben Bleything, whose MIDIator gem inspired the cross-platform-ness and structural design of this library
* Pete Yandell, whose PYMIDI framework is encapsulated in MidiLex's macruby-midi framework (and which made it *much* easier to get MIDI working in MacRuby!)

## ISSUES:

* Needs DL output drivers ported over
* rbcoremidi driver is un-tested - newest version of the bundle not working on my machine yet, for some reason...
* rbcoremidi doesn't provide full source names (e.g., 'PORT A' instead of 'KONTROL49 PORT A')
* Needs some kind of Windows input - possibly starting with a simple TCP bridge to a Max patch, since that's easiest!

## INSTALL:

Since this isn't gem-i-fied yet, you're encouraged to just clone it to your hard drive and then add it to your project's load path:  
`$LOAD_PATH << '/src/ruby/midi-lex/lib'`

## LICENSE:

(The MIT License)

Copyright (c) 2009 Mike Laurence

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
