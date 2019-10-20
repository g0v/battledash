// Generated by LiveScript 1.3.1
(function(){
  return ldc.register('navtop', [], function(){
    var navbar, dotst, tstTgt;
    navbar = document.querySelector('#nav-top nav');
    dotst = (navbar.getAttribute('data-transition') || "").split(';').map(function(it){
      return it.split(' ').filter(function(it){
        return it;
      });
    });
    tstTgt = ld$.find(document, navbar.getAttribute('data-transition-target'), 0);
    if (!(dotst.length && tstTgt)) {
      return;
    }
    return new IntersectionObserver(function(it){
      var n;
      if (!(n = it[0])) {
        return;
      }
      dotst[0].map(function(c){
        return navbar.classList.toggle(c, n.isIntersecting);
      });
      return dotst[1].map(function(c){
        return navbar.classList.toggle(c, !n.isIntersecting);
      });
    }, {
      threshold: 0.1
    }).observe(tstTgt);
  });
})();