---
title: 【翻译】使用Vue.js和Axios从第三方API获取数据-SitePoint
date: 2017-04-30 09:56:15
tags:
    - 翻译
    - vue.js
    - axios
nocopyright: true
---

> 本文转载自：[众成翻译](http://www.zcfy.cc)
> 译者：[gdb](http://www.zcfy.cc/@lllll)
> 链接：[http://www.zcfy.cc/article/2706](http://www.zcfy.cc/article/2706)
> 原文：[https://www.sitepoint.com/fetching-data-third-party-api-vue-axios/](https://www.sitepoint.com/fetching-data-third-party-api-vue-axios/)

![从图书馆货架收集数据的女人](http://p0.qhimg.com/t01167e5bc03efd7cae.png)

通常情况下，在构建 JavaScript 应用程序时，您希望从远程源或从[API](https://en.wikipedia.org/wiki/Application_programming_interface)获取数据。我最近研究了一些[公开的API](https://github.com/toddmotto/public-apis)，发现可以使用这些数据源完成很多很酷的东西。

## 更多来自作者的提示


- [快速提示：如何在JavaScript中排序对象数组](https://www.sitepoint.com/sort-an-array-of-objects-in-javascript/?utm_source=sitepoint&utm_medium=relatedinline&utm_term=&utm_campaign=relatedauthor)

使用[Vue.js](https://vuejs.org/)，可以逐步地构建围绕其中一个服务的应用程序，并在几分钟内就可以开始向用户提供内容服务。

我将演示如何构建一个简单的新闻应用程序，它可以显示当天的热门新闻文章，并允许用户按照他们的兴趣类别进行过滤，从[纽约时报API](https://developer.nytimes.com/)获取数据。您可以在[这里](https://github.com/sitepoint-editors/vuejs-news)找到本教程的完整代码。

下面是最终应用的外观：

![Vue.js news web app](http://p0.qhimg.com/t015594503a78bd0a75.gif)

要学习本教程，您将需要一些非常基本的Vue.js的知识。 您可以在[这里](https://www.sitepoint.com/up-and-running-vue-js-2-0/)找到一个很棒的“入门指南”。 我还将使用ES6语法，您可以到这里进一步学习：[https://www.sitepoint.com/tag/es6/](https://www.sitepoint.com/tag/es6/) 。

## 项目结构

为了保持简单，我们只使用2个文件:

```
./app.js
./index.html
```

`app.js`将包含我们应用程序的所有逻辑，`index.html` 文件将包含我们应用程序的主视图。


我们先在 `index.html` 中写一些基本的标记:

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>The greatest news app ever</title>
  </head>
  <body>
    <div class="container" id="app">
      <h3 class="text-center">VueNews</h3> 
    </div>
  </body>
</html>

```

然后，在`index.html`的底部导入 `Vue.js`和`app.js`，就在`</body>`标签之前：

```
`<script src="https://unpkg.com/vue">`</script>
`<script src="app.js">`</script>
```

可选的，我们还可以导入[Foundation](http://foundation.zurb.com/)，以利用一些预先创建的样式，来使我们的视图看起来更好一点。

```
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/foundation/6.3.1/css/foundation.min.css">
```

## 创建一个简单的 Vue App

首先，我们将在`div#app` 元素上创建一个新的 Vue 实例，并使用一些测试数据来模拟新闻API的响应：

```javascript
// ./app.js
const vm = new Vue({
  el: '#app',
  data: {
    results: [
      {title: "the very first post", abstract: "lorem ipsum some test dimpsum"},
      {title: "and then there was the second", abstract: "lorem ipsum some test dimsum"},
      {title: "third time's a charm", abstract: "lorem ipsum some test dimsum"},
      {title: "four the last time", abstract: "lorem ipsum some test dimsum"}
    ]
  }
});

```

我们通过[el](https://vuejs.org/v2/api/#el)选项告诉 Vue 要挂载的目标元素，并通过[data](https://vuejs.org/v2/api/#data)选项指定我们的应用程序用到的数据。

要在我们的应用程序视图中显示这些模拟数据，我们可以在`#app`元素中写入下面的标记：

```html
<!-- ./index.html -->
<div class="columns medium-3" v-for="result in results">
  <div class="card">
    <div class="card-divider">
      {{ result.title }}
    </div>
    <div class="card-section">
      <p>{{ result.abstract }}.</p>
    </div>
  </div>
</div>
```

`v-for` [指令](https://vuejs.org/v2/guide/list.html)用于渲染我们的 results 列表。 我们使用双花括号来显示每一项的内容。

> 您可以在 Vue 模板语法 [这里](https://vuejs.org/v2/guide/syntax.html)阅读更多内容

我们现在已经完成了基本的布局工作：

![使用模拟数据的新闻App](http://p0.qhimg.com/t0170601954051e7777.jpg)

## 从 API 获取数据

要使用 纽约时报API，您需要获得一个API密钥。所以如果你还没有，请到这里：[https://developer.nytimes.com/signup](https://developer.nytimes.com/signup) ，注册并获取一个[热点事件API](https://developer.nytimes.com/top_stories_v2.json)的API密钥。

### 创建Ajax请求和处理响应

[Axios](https://github.com/mzabriskie/axios)是一个基于 Promise 的HTTP客户端，用于创建 Ajax请求，并且非常适合我们的应用。它提供了一些简单而丰富的API。 它与`fetch`[API](https://developer.mozilla.org/en/docs/Web/API/Fetch_API)非常相似，但不需要为旧版浏览器额外的添加一个polyfill，另外还有一些[很巧妙的地方](https://github.com/mzabriskie/axios/issues/314)。

> 以前，`vue-resource` 通常用于Vue项目，但现在已经[退休了](https://medium.com/the-vue-point/retiring-vue-resource-871a82880af4#.q5lkhpmwp)。

导入 axios:

```html
<!-- ./index.html -->
`<script src="https://unpkg.com/axios/dist/axios.min.js">`</script>
```

现在，一旦我们的Vue应用被[挂载 - mounted](https://vuejs.org/v2/api/#mounted)到页面，我们就可以创建`home`部分获取热点事件列表的请求：

```javascript
// ./app.js

const vm = new Vue({
  el: '#app',
  data: {
    results: []
  },
  mounted() {
    axios.get("https://api.nytimes.com/svc/topstories/v2/home.json?api-key=your_api_key")
    .then(response => {this.results = response.data.results})
  }
});

```

> **记住**: 将`your_api_key`替换为之前获取的实际API密钥。

现在我们可以在我们的应用主页上看到新闻列表。不要担心扭曲的视图，我们之后再说：

![News Feed](http://p0.qhimg.com/t0189e99e554a504021.jpg)

来自纽约时报 API 的响应通过 Vue Devtools 查看起来像下面这样：

![纽约时报 API返回的响应 - Vue.js news app](http://p0.qhimg.com/t015bc300cc964519ce.jpg)

> **提示**: 获取 Vue [Devtools](https://github.com/vuejs/vue-devtools)，来使Vue应用调试更加简单。

为了使我们的工作更加整洁，可重用，我们将做一些小小的重构，并创建一个辅助函数来构建我们的URL。我们还将注册`getPosts`作为我们应用程序的一个方法，将其添加到[methods对象](https://vuejs.org/v2/api/#methods)中：


```javascript
const NYTBaseUrl = "https://api.nytimes.com/svc/topstories/v2/";
const ApiKey = "your_api_key";

function buildUrl (url) {
  return NYTBaseUrl + url + ".json?api-key=" + ApiKey
}

const vm = new Vue({
  el: '#app',
  data: {
    results: []
  },
  mounted () {
    this.getPosts('home');
  },
  methods: {
    getPosts(section) {
      let url = buildUrl(section);
      axios.get(url).then((response) => {
        this.results = response.data.results;
      }).catch( error => { console.log(error); });
    }
  }
});

```

通过引入 [计算属性](https://vuejs.org/v2/guide/computed.html) 对API获取的原始results来进行一些修改，然后对我们的视图进行一些更改。


```javascript
// ./app.js

const vm = new Vue({
  el: '#app',
  data: {
    results: []
  },
  mounted () {
    this.getPosts('home');
  },
  methods: {
    getPosts(section) {
      let url = buildUrl(section);
      axios.get(url).then((response) => {
        this.results = response.data.results;
      }).catch( error => { console.log(error); });
    }
  },
  computed: {
    processedPosts() {
      let posts = this.results;

      // Add image_url attribute
      posts.map(post => {
        let imgObj = post.multimedia.find(media => media.format === "superJumbo");
        post.image_url = imgObj ? imgObj.url : "http://placehold.it/300x200?text=N/A";
      });

      // Put Array into Chunks
      let i, j, chunkedArray = [], chunk = 4;
      for (i=0, j=0; i < posts.length; i += chunk, j++) {
        chunkedArray[j] = posts.slice(i,i+chunk);
      }
      return chunkedArray;
    }
  }
});

```

在上面的代码，在`processedPosts`的计算属性中，我们为每个新闻文章对象添加了一个`image_url`属性。 我们通过循环遍历API中的`results`，并在单个结果中搜索`multimedia`数组，找到所需格式的媒体类型，然后将该媒体的URL分配给“image_url”属性 。 如果媒体不可用，我们会将默认网址设为[Placehold.it](http://placehold.it/)的图像。

我们还写了一个循环，将我们的`results`数组分组成4块。这将改善我们前面看到的扭曲的视图。

> **注意**:您也可以轻松地使用[Lodash](https://lodash.com/docs/#chunk)等库进行分块


计算属性非常适合操纵数据。而不用创建一个方法，并且每次在我们需要将我们的帖子数组分块时，我们可以简单地将它定义为一个计算属性，并根据需要使用它，因为Vue会随时自动更新`processedPosts`计算属性的变化。

计算的属性也是基于它们的依赖关系缓存的，所以只要`results`不变，`processedPosts`属性返回一个自己的缓存版本。这将有助于提升性能，特别是在进行复杂的数据操作时。

接下来，我们在`index.html`中编辑我们的html来显示我们的计算结果：


```html
<!-- ./index.html -->
<div class="row" v-for="posts in processedPosts">
  <div class="columns large-3 medium-6" v-for="post in posts">
    <div class="card">
    <div class="card-divider">
      {{ post.title }}
    </div>
    <a :href="post.url" target="_blank"><img :src="post.image_url"></a>
    <div class="card-section">
      <p>{{ post.abstract }}</p>
    </div>
  </div>
  </div>
</div>

```

现在应用程序看起来更好了：

![NYT News App - Vue.js](http://p0.qhimg.com/t01e69641206c13f1ac.jpg)

## 介绍新闻列表组件

[组件](https://vuejs.org/v2/guide/components.html#What-are-Components) 可用于使应用程序的更加模块化，并且扩展了HTML。 `新闻列表`可以重构为一个组件，例如，如果应用程序增长，并且可能会在其他地方的使用新闻列表，那将很容易实现。


```javascript
// ./app.js
Vue.component('news-list', {
  props: ['results'],
  template: `
    <section>
      <div class="row" v-for="posts in processedPosts">
        <div class="columns large-3 medium-6" v-for="post in posts">
          <div class="card">
          <div class="card-divider">
          {{ post.title }}
          </div>
          <a :href="post.url" target="_blank"><img :src="post.image_url"></a>
          <div class="card-section">
            <p>{{ post.abstract }}</p>
          </div>
        </div>
        </div>
      </div>
  </section>
  `,
  computed: {
    processedPosts() {
      let posts = this.results;

      // 添加 image_url 属性
      posts.map(post => {
        let imgObj = post.multimedia.find(media => media.format === "superJumbo");
        post.image_url = imgObj ? imgObj.url : "http://placehold.it/300x200?text=N/A";
      });

      // Put Array into Chunks
      let i, j, chunkedArray = [], chunk = 4;
      for (i=0, j=0; i < posts.length; i += chunk, j++) {
        chunkedArray[j] = posts.slice(i,i+chunk);
      }
      return chunkedArray;
    }
  }
});
const vm = new Vue({
  el: '#app',
  data: {
    results: []
  },
  mounted () {
    this.getPosts('home');
  },
  methods: {
    getPosts(section) {
      let url = buildUrl(section);
      axios.get(url).then((response) => {
        this.results = response.data.results;
      }).catch( error => { console.log(error); });
    }
  }
});
```

在上面的代码中，我们使用以下的语法注册了 [全局组件](https://vuejs.org/v2/guide/components.html#Registration)：`Vue.component(tagName, options)`。建议在定义标签名称时使用连字符，因此它们不会与任何当前或将来的标准HTML标签发生冲突。


下面介绍一些其他选项如下：

- Props: 它包含可能从父作用域传递到当前组件组件数据的数组。我们添加了`results`，因为我们想要从主程序实例加载它。

- Template: 这里是我们定义的新闻列表的html结构。请注意，我们将html包装在反引号中。这是因为组件需要有一个单独的根元素，而不是多个元素（这将由我们的`div.row`迭代创建）。

调整我们的标记以使用我们的`news-list`组件，并传递'results'数据，如下所示：


```html
<!-- ./index.html -->

<div class="container" id="app">
  <h3 class="text-center">VueNews</h3>
  <news-list :results="results"></news-list>
</div>
```

> **注意**: 组件也可以创建为[单文件组件](https://vuejs.org/v2/guide/single-file-components.html)（`.vue`文件），然后由构建工具解析，如[webpack](https://webpack.github.io/)。 虽然这超出了本教程的范围，但建议在更大或更复杂的应用程序中使用。


更进一步，您可以决定甚至将每篇文章做成一个单独的组件，使我们的应用更加模块化。


## 实现分类过滤器

为了使我们的应用程序更加丰富，我们现在可以引入分类过滤器，以便用户选择显示某些特定类别的新闻。

首先，我们将在我们的应用程序中注册 sections 列表和当前正在查看的部分：


```javascript
const SECTIONS = "home, arts, automobiles, books, business, fashion, food, health, insider, magazine, movies, national, nyregion, obituaries, opinion, politics, realestate, science, sports, sundayreview, technology, theater, tmagazine, travel, upshot, world"; // From NYTimes

const vm = new Vue({
  el: '#app',
  data: {
    results: [],
    sections: SECTIONS.split(', '), // 从SECTIONS创建一个数组
    section: 'home', // 设置默认的 section为 home
  },
  mounted () {
    this.getPosts(this.section);
  },
  // ....
});

```

接下来，我们可以将它添加到我们的`div#app`容器中：

```html
<!-- ./index.html -->
<section class="callout secondary">
  <h5 class="text-center">Filter by Category</h5>
  <form>
    <div class="row">
      <div class="large-6 columns">
        <select v-model="section">
          <option v-for="section in sections" :value="section">{{ section }}</option>
        </select>
      </div>
      <div class="medium-6 columns">
        <a @click="getPosts(section)" class="button expanded">Retrieve</a>
      </div>
    </div>
  </form>
</section>

```

当单击“Retrieve”按钮时，我们通过侦听“click”事件来触发所选部分的`getPosts`方法，语法如下：`@click`。

## 最终改进和演示

我决定添加一些小的（可选的）效果，使应用程序体验更好一些，如引入加载图片。

您可以在下面的CodePen中看到一个演示（有限的功能）：

查看 codepen [VueJS and NYTimes News App](https://codepen.io/SitePoint/pen/pPojGY/) by SitePoint ([@SitePoint](http://codepen.io/SitePoint)) on [CodePen](http://codepen.io).

也可以查看在线的版本 [here](http://vuejs-news.herokuapp.com/).

## 结论

在本教程中，我们已经学会了如何从头开始创建Vue.js项目，如何使用[axios](https://github.com/mzabriskie/axios)从API获取数据，以及如何处理响应、操作组件和计算属性的数据。

现在我们已经有一个功能齐全的Vue.js 2.0的应用程序，它围绕着 API 服务构建。 通过插入其他API可以进行大量的改进。例如，我们可以：

*   使用[Buffer API](https://buffer.com/developers/api)自动从类别中排列社交媒体帖子

*   使用[Pocket API](https://getpocket.com/developer/)，来标记阅读后的帖子

这个项目的完整代码在Github上托管的（https://github.com/sitepoint-editors/vuejs-news） ，所以如果你愿意的话， 你可以克隆，运行和改进。

你有没有其他有趣的想法可以通过连接到第三方API来实现？可以在评论中分享您的想法！

_这篇文章被[Joan Yin](https://github.com/newjs)同行评议。 感谢SitePoint的同行评议人员，使SitePoint的内容变得更好！_