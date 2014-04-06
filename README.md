# slush-static [![NPM version][npm-image]][npm-url] [![Build Status][travis-image]][travis-url] [![Dependency Status][depstat-image]][depstat-url]


> generate static web page project using:
 - CoffeeScript + lint + uglify
 - Livereload + Server
 - stylus + nib
 - imagemin

## Getting Started
 

 

### Installation

Install `slush-static` globally:

```bash
npm install -g slush-static
```

Remember to install `slush` globally as well, if you haven't already:

```bash
npm install -g slush
```

### Usage

Create a new folder for your project:

```bash
mkdir my-slush-static
```

Run the generator from within the new folder:

```bash
cd my-slush-static && slush static
```

## Getting To Know Slush

Slush is a tool to be able to use Gulp for project scaffolding.

Slush does not contain anything "out of the box", except the ability to locate installed slush generators and to run them with liftoff.

To be able to provide functionality like Yeoman, see: [Yeoman like behavior below.](https://github.com/klei/slush#yeoman-like-behavior)

## Contributing

See the [CONTRIBUTING Guidelines](https://github.com/Safareli/slush-static/blob/master/CONTRIBUTING.md)

## Support
If you have any problem or suggestion please open an issue [here](https://github.com/Safareli/slush-static/issues).

## License 

The MIT License

Copyright (c) 2014, Irakli Safareli

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

 

[npm-url]: https://npmjs.org/package/slush-static
[npm-image]: https://badge.fury.io/js/slush-static.png

[travis-url]: http://travis-ci.org/Safareli/slush-static
[travis-image]: https://secure.travis-ci.org/Safareli/slush-static.png?branch=master

[depstat-url]: https://gemnasium.com/Safareli/slush-static
[depstat-image]: http://img.shields.io/gemnasium/Safareli/slush-static.svg
