package coconut.ww;

/**
 * Named after the `tail -f` command, this view displays a list of entries,
 * while maintaining scroll position at the bottom. The scroll locking is 
 * disabled as soon as the user scrolls up and reenabled when the user scroll
 * back to the bottom.
 */
class Tail<Entry> extends View {

  static final TAIL = css('
    overflow: hidden auto;
    listStyle: none;
    maxHeight: 100%;
  ');
  
  @:attribute var className:ClassName = null;
  @:attribute var entries:List<Entry>;
  @:attribute var renderer:Entry->Children;
  
  @:ref var root:Element;

  var isAtBottom:Bool = true;

  function scroll(e:Element)
    isAtBottom = e.scrollTop + e.clientHeight >= e.scrollHeight - 1;

  function render() '
    <ol ref=${root} class=${TAIL.add(className)} onscroll=${scroll(event.currentTarget)}>
      <for ${m in entries}>
        <li>${...renderer(m)}</li>
      </for>
    </ol>
  ';

  override function viewDidMount() 
    if (isAtBottom)
      root.scrollTop = root.scrollHeight;
}