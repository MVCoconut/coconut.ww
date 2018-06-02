package coconut.ww;

typedef PaneInfo = {
  var index(default, never):Int;
  var status(default, never):PaneStatus;
}

@:less("pane-switcher.less")
class PaneSwitcher extends View {

  @:attribute var className:ClassName = null;
  @:attribute var pane:PaneInfo->Null<Children>;
  @:attribute var total:Int;
  @:attribute var selectedIndex:Int = -1;
  // @:attribute var wraparound:Bool = false; //TODO: implement
  
  @:attribute function onselect(index:Int);
  
  @:state var position:Float = Math.NaN;
  @:state var _ownIndex:Int = 0;
  @:state var dragging:Bool = false;

  @:computed var index:Int = switch selectedIndex {
    case -1: _ownIndex;
    case v: v;
  }

  function doSelect(index:Int) {
    if (index < 0) index = 0;
    else if (index >= total) index = total - 1;
    this._ownIndex = index;
    onselect(index);
  }

  static inline var MAX_SPEED = 1001.25;

  static function float(f:Float) {
    return Math.round(f * 1000) / 1000;
  }

  function render() {
    if (Math.isNaN(position))
      position = index;
    var count = total;

    if (!dragging && position != index) {
      var now = stamp();
      @in(.0) @do {
        position = 
          if (Math.abs(position - index) < .01) index;
          else {
            var delta = index - position;
            delta /= 5;
            if (Math.abs(delta) > .25) delta /= 5;
            position += delta;
          }
      }
    }

    inline function isVisible(pos:Int)
      return Math.abs(pos - position) <= 1;

    inline function style(pos:Int):Style 
      return 
        if (isVisible(pos))
          { transform: 'translateX(${100 * (pos - position)}%)' }
        else
          { visibility: 'hidden' }

    return @hxx'
      <div class=${className.add("cc-pane-switcher")}>
        <ol 
            onmousedown={startDrag(MOUSE, event, event.target.ownerDocument)}
            ontouchstart={startDrag(TOUCH, event, event.target.ownerDocument)}
          >
          <for ${pos in 0...count}>
            <switch ${pane({ index: pos, status: if (pos == index) Active else if (isVisible(pos)) Visible else Invisible })}>
              <case ${null}>
              <case ${c}>
                <li 
                    key=${pos} 
                    style=${style(pos)}
                  >
                  ${...c}
                </li>
            </switch>
          </for>
        </ol>
      </div>
    ';
  }

  static var MOUSE:InputMethod<MouseEvent> = {
    getPos: function (m:MouseEvent) {
      return m.clientX;
    },
    move: 'mousemove',
    end: 'mouseup',
    isFinal: function (_) return true,
  }

  static var TOUCH:InputMethod<TouchEvent> = {
    getPos: function (e:TouchEvent) {
      return e.touches[0].clientX;
    },
    move: 'touchmove',
    end: 'touchend',
    isFinal: function (e:TouchEvent) {
      return e.touches.length == 0;
    }
  }

  static function stamp()
    return Date.now().getTime() / 1000;

  var speed = .0;
  function startDrag<T:Event>(method:InputMethod<T>, initial:T, root:Node) {
    
    var cur = method.getPos(initial),
        at = stamp();

    function drag(event:T) {
      var next = method.getPos(event);
      var delta = (next - cur) / this.toElement().clientWidth,
          deltaT = stamp() - at;
      at += deltaT;
      if (delta != 0)
        dragging = true;
      if (dragging) {
        event.preventDefault();
        event.stopImmediatePropagation();
      }
      cur = next;
      this.position -= delta;
      this.speed = 
        if (deltaT > .5) 0;
        else -delta / deltaT;
      doSelect(Math.round(this.position));
    }

    root.addEventListener(method.move, drag);
    root.addEventListener(method.end, function (e) if (method.isFinal(e)) {
      root.removeEventListener(method.move, drag);
      if (Math.abs(speed) > 2) {
        var s = sign(speed);
        if (s != sign(this.index - this.position)) {
          doSelect(this.index - s);
        }
      }
      dragging = false;
    });
  }

  function sign(f:Float)
    return if (f > 0) -1 else if (f < 0) 1 else 0;
}

typedef InputMethod<T:Event> = {
  function getPos(event:T):Float;
  function isFinal(event:T):Bool;
  var move(default, never):String;
  var end(default, never):String;
}