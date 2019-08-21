import coconut.ww.*;
import coconut.ui.*;
import coconut.data.*;
import tink.pure.Slice;

using tink.CoreApi;

abstract TwitterHandle(String) from String to String {

}

class User implements Model {
  @:constant var handle:TwitterHandle;
  @:external var name:String;
  @:external var bio:String;
  @:external var picture:String;
  @:constant var followers:Followers;
}

typedef Followers = LazyList<User>;

interface LazyList<T> extends Model {
  var total:Int;
  function get(range:IntIterator):Slice<T>;
}

abstract Yo(Dynamic) {
  public function new(o:{ foo: Int })
    this = null;
}

class FakeLazyList<T> implements LazyList<T> {
  @:constant var data:Slice<T>;
  @:computed var total:Int = data.length;
  public function get(range:IntIterator)
    return data.skip(@:privateAccess range.min).limit(@:privateAccess range.max);
}

class Tweet implements Model {
  @:constant var id:String;
  @:constant var text:String;
  @:constant var mentions:List<TwitterHandle>;
  @:constant var author:User;
  @:constant var created:Date;
  @:constant var replies:LazyList<Tweet>;
  @:external var likes:Int;
}

class TweetListItem extends View {
  
  @:attribute var tweet:Tweet;

  function render() '
    <li class="tweet">
      
    </li>
  ';
}

class ExpandedTweet extends View {

  @:attribute var tweet:Tweet;

  function render() '
    <div class="expanded-tweet">
      
    </div>
  ';
  
}

class Playground {
  static function main() {

    coconut.ui.Renderer.mount(js.Browser.document.body, coconut.Ui.hxx('
      <TabSwitcher class=${cix.Style.rule('width: 400px')}>
        <tabs>
          <tab style=${_ -> ["foo" => true, "bar" => false]}>
            <title>Home</title>
            <content>
              <Popover side={Right}>
                <toggler>Test</toggler>
                <content>
                  <ul>
                    <li>Lorem Ipsum</li>
                    <li>Bar Foo</li>
                  </ul>
                </content>
              </Popover>

              <ol>
                <for {i in 0...50}>
                  <li>

                  </li>
                </for>
              </ol>
            </content>
          </tab>
          <tab>
            <title>Search</title>
            <content>
              tab content 2
            </content>
          </tab>
          <tab>
            <title>Notifications</title>
            <content>
              tab content 3
            </content>
          </tab>
          <tab>
            <title>Messages</title>
            <content>
              tab content 4
            </content>
          </tab>
        </tabs>
      </TabSwitcher>
    '));
  }
}