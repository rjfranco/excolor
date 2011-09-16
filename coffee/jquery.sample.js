(function() {
  $(function() {
    prettyPrint();
    console.log('Pretty Print should be loaded');
    $('input.color-input').excolor();
    return console.log('Excolor should have happened.');
  });
}).call(this);
