(function() {
  $(function() {
    prettyPrint();
    console.log('Pretty Print should be loaded');
    return $('input.color-input').excolor();
  });
}).call(this);
