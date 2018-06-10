package coconut.ww;

/**
 * Named after the `tail -f` command, this class displays a list of entries,
 * while maintaining scroll position at the bottom. The scroll locking is 
 * disabled as soon as the user scrolls up and reenabled when the user scroll
 * back to the bottom.
 */
@:less('tail.less')
class Tail<Entry> extends View {
  
  @:attribute var className:ClassName = null;
  @:attribute var entries:List<Entry>;
  @:attribute var renderer:Entry->Children;
  
  var isAtBottom:Bool = true;

  function scroll(e:Element)
    isAtBottom = e.scrollTop + e.clientHeight >= e.scrollHeight - 1;

  function render() '
    <ol class={className.add("tail")} onscroll={scroll(event.currentTarget)}>
      <for {m in entries}>
        <li>{...renderer(m)}</li>
      </for>
    </ol>
  ';

  override function afterPatching(e:Element) 
    if (isAtBottom)
      e.scrollTop = e.scrollHeight;
}