(->
  ldc.register \navtop, <[]>, ({}) ->
    navbar = document.querySelector '#nav-top nav'
    # navtop change style if data-transition and data-transition-target is defined.
    # data-transition = "class1 class2 ...;class1 class2 ..." for before and after transition classs.
    # data-transition-target: node to monitor for visibility and thus reflect the whether state should be change.
    # these can be set by ctrl.navtop.transition and ctrl.navtop.transitionTarget config.
    dotst = (navbar.getAttribute(\data-transition) or "").split(';').map(->it.split(' ').filter(->it))
    tst-tgt = ld$.find document, navbar.getAttribute(\data-transition-target), 0
    if !(dotst.length and tst-tgt) => return
    (new IntersectionObserver (->
      if !(n = it.0) => return
      dotst.0.map (c) -> navbar.classList.toggle c, n.isIntersecting
      dotst.1.map (c) -> navbar.classList.toggle c, !n.isIntersecting
    ), {threshold: 0.1}).observe tst-tgt

)!
