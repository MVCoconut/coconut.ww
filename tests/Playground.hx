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
    var value = new tink.state.State(1);

    new Tab({
      title: ['foo'],
      content: _ -> ['bar']
    });

    coconut.Ui.hxx('
      <div>
        <Tail entries={[{ name: "John Doe" }]}>
          <renderer>{name}</renderer>
        </Tail>
        <Stack></Stack>
        <DropdownSelect options={[1,2,3]} onchange={value.set} value={value}>
          <renderer option>
            ${option}
          </renderer>
        </DropdownSelect>
      </div>
    ');

    coconut.ui.Renderer.mount(js.Browser.document.body, coconut.Ui.hxx('
      <TabSwitcher>
        <Tab class="home">
          <title>Home</title>
          <content>
            <Popover side={PopoverSide.Right}>
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
        </Tab>
        <Tab class="search">
          <title>Search</title>
          <content>
            Tab content 2
          </content>
        </Tab>
        <Tab class="notifications">
          <title>Notifications</title>
          <content>
            Tab content 3
          </content>
        </Tab>
        <Tab class="messages">
          <title>Messages</title>
          <content>
            Tab content 4
          </content>
        </Tab>
      </TabSwitcher>
    '));//.mount();
  }
}