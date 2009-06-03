# MidiMix

http://github.com/mikelaurence/midi-mix/tree/master

## DESCRIPTION:

Cross-platform MIDI input & output for all varieties of Ruby.

This project is currently in heavy development, and only has drivers for MacRuby, as that is the author's main priority at the moment :-)

## FEATURES/PROBLEMS:

* Needs all that MIDIator driver love ported over!
* Needs rbcoremidi ported over!
* Needs some kind of windows input - possibly starting with a simple TCP bridge to a Max patch, since that's easiest!

## INSTALL:

Since this isn't gem-i-fied yet, you're encouraged to just clone it to your hard drive and then add it to your project's load path:  
`$LOAD_PATH << '/src/ruby/midi-mix/lib'`

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
