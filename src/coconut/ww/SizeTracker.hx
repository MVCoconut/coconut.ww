package coconut.ww;

import tink.geom2.Size;

class SizeTracker extends View {
  static final useIframe = ResizeObserver == null;
  static var counter = 0;
  static final ROOT = css('
    position: relative
  ');

  static final IFRAME = css('
    position: absolute;
    top: 0;
    bottom: 0;
    height: 100%;
    right: 100%;
    visibility: hidden;
  ');

  @:ref var iframe:IFrameElement;
  @:ref var root:Element;

  var iframeVDom:RenderResult =
    if (useIframe)
      hxx('<iframe title="size-iframe-${counter++}" class=${IFRAME} ref=${iframe} />');
    else 
      null;
  
  var observer:ResizeObserver;
  var window:Window;

  @:state var _size:Size = new Size(0, 0);
  @:computed public var size:Size = _size;

  @:attribute var className:ClassName = null;
  @:attribute var onResize:Callback<Size> = null;
  @:children var content:Children;

  function render() '
    <div ref=$root class=${ROOT.add(className)}>
      ${iframeVDom}
      ${...content}
    </div>
  ';

  function triggerResize(width, height) 
    switch onResize {
      case null:
      case cb: cb.invoke(_size = new Size(width, height));
    }

  function handleResize() 
    triggerResize(root.clientWidth, root.clientHeight);

  function viewDidMount() {
    if (useIframe) {
      function useWindow(w) {
        window = w;
        window.addEventListener('resize', handleResize);
        haxe.Timer.delay(handleResize, 0);//libreact's SizeSensor uses 35 msecs here ... not sure if that has any meaning
      }
      switch iframe.contentWindow {
        case null:
          iframe.addEventListener("load", function onLoad() {
            iframe.removeEventListener("load", onLoad);
            useWindow(iframe.contentWindow);
          });        
        case v: useWindow(v);
      }

    }
    else {
      observer = new ResizeObserver(handleResize);
      observer.observe(root);
    }
  }

  function viewWillUnmount() {
    if (window != null) {
      window.removeEventListener("resize", this.handleResize);
      window = null;
    }
    if (observer != null) {
      observer.disconnect();
      observer = null;
    }
  }  
}

@:native('window.ResizeObserver')
private extern class ResizeObserver {
  public function new(handler:Void->Void):Void;
  function observe(target:Node):Void;
  function disconnect():Void;
}