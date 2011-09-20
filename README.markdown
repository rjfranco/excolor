# ExColor - The jquery color picker plugin.
## A fork of the modcoders\_excolor plugin for jquery.

[Modcoders\_excolor](http://modcoder.org/?ptab=jquery&item=excolor) is a color picker with some really great features, but slightly lacking in documentation and functionality ( no rgb input/output method for instance, and the default style isn't the greatest. ) So I've taken the code, converted it to coffeescript, and now i'm working on adding that missing feature, and improving the style.

Work has only just started, input is welcome :-)

To get started using it, make sure you've got jquery, the excolor plugin, and the excolor css file linked. If your images are not in the same place as the javascript ( not sure why anyone would put those in the same place ...) just pass root\_path to the file like so:

~~~
$('input.myinput').excolor({
  root\_path: 'img/'
});
~~~

Yours,
[Ramiro Jr. Franco](mailto:rjfranco@gmail.com)