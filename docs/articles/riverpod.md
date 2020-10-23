# Flutter Riverpod

- Flutter Hooks
  - useState hook
  - useEffect hook
- Riverpod
  - Create Provider
  - Read Provider
  - Combine Provider

---

## 1. Flutter Hooks

Hooks 是前端 React 框架新加入的特性，用来分离 状态逻辑 和 视图逻辑。后来 Flutter 也将其内如它的生态当中。  
使用 Hooks 可以基本舍弃 StatefulWidget，转而通过 hooks 来管理组件的状态。

### 1\. useState hook

useState hook 类似于 StateWidget 中的 setState()，它用来获取组件的当前状态，以官网的 Counter 实例为例：

```dart
class HooksExample extends HookWidget {
  @override
  Widget build(BuildContext context) {

    final counter = useState(0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('useState example'),
      ),
      body: Center(
        child: Text('Button tapped ${counter.value} times'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:() => counter.value++,
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

1\. 首先要使用 HookWidget，它是继承自 StatelessWidget 的一个类，底层实现了 Hooks 的管理和运行方式。  
2\. 其次初始化状态，状态从 0 开始：

```dart
  final counter = useState(0);
```

3\. 事件的处理，只需要返回一个新的 state 就可以触发更新，完全不需要调用 setState() 方法。

```dart
  floatingActionButton: FloatingActionButton(
    onPressed:() => counter.value++,
    child: const Icon(Icons.add),
  ),
```
我们可以在组件中对应多个 Hooks，每个 Hooks 管理的都是自己的状态。  

### 2\. useEffect hook
useEffect hook 类似于 StatefulWidget 组件中的生命周期，比如 init， didUpdate 和 dispose等。  
```dart
Widget _buildBody(BuildContext context) {
  ArticlesModelPod articlesModel = useProvider(articlesProvider);
  useEffect(() {
    articlesModel.init();
    return articlesModel.dispose;
  }, const []);
  List<ArticleModel> articles = articlesModel.articles;
  return Container(
    child: ListView.separated(
        itemCount: articles.length,
        itemBuilder: (BuildContext context, int index) {
          return ArticleItem(articles[index], articlesModel.toggleStar);
        },
        separatorBuilder: (BuildContext context, int index) => Divider(
              height: 0.5,
              color: Colors.black26,
            )),
  );
}
```
1\. 首先依然使用 HookWidget。  
2\. 其次在回调中写明要使用的副作用，比如初始化监听一个流，切记返回一个取消监听流的方法。第二参数代表只会在生命周期的开始和结束各调用一次，如果不传，则每次build时都会被调用。

```dart
  useEffect(() {
    articlesModel.init();
    return articlesModel.dispose;
  }, const []);
```

## 2. Riverpod
Riverpod 是 Provider 的作者重写的状态管理库，来实现原本不可能的一些功能。
可以把 Riverpod 理解为 Provide r的升级版，解决了Provider的一些痛点：
- Provider 是 InheritedWidget 的封装，所以在读取状态时需要 BuildContext。这导致了许多的限制，许多新手在不理解 InheritedWidget 和 BuildContext 时，跨页面获取状态经常会 ProviderNotFoundException。而 Riverpod 不再依赖 Flutter，也就是没有使用 InheritedWidget，所以也不需要 BuildContext。
- 读取对象是编译安全的。没有那么多的运行时异常。
- 能够有多个相同类型的 provider。
- provider 可以是私有的。
- 当不再使用 provider 的状态时，将其自动回收。

### 1\. Create Provider
```dart
Provider((ref) {
  return state;
})
```
ref 可以理解成 Provider 的上下文（类似 BuildContext），使用它监听其他Provider 的状态，如：
```dart
final filterProvider = StateProvider((ref) => Filter.none);
final filteredTodoListProvider = Provider<List<Todo>>((ref) {
  final todos = ref.watch(todoListProvider.state);

  switch (ref.watch(filterProvider)) {
    case Filter.none:
      return todos;
    case Filter.completed:
      return todos.where((todo) => todo.completed).toList();
    case Filter.uncompleted:
      return todos.where((todo) => !todo.completed).toList();
  }
});
```
变式：  
```dart
final myProvider = FutureProvider.autoDispose((ref) async {
  
  final cancelToken = CancelToken();
  // 当provider被销毁时，取消http请求
  ref.onDispose(() => cancelToken.cancel());

  // http请求
  final response = await dio.get('path', cancelToken: cancelToken);
  // 如果请求成功完成，则保持该状态。
  ref.maintainState = true;
  return response;
});
final myFamilyProvider = Provider.family<String, int>((ref, id) => '$id');
// use
useProvider(myFamilyProvider(12));
```

### 2\. Read Provider
### 3\. Combine Provider
