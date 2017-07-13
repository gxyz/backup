---
title: 【翻译】使用React和D3–ReactJSNews
date: 2017-04-27 16:12:58
tags:
    - 翻译
    - React
    - D3.js
nocopyright: true
---

> 本文转载自：[众成翻译](http://www.zcfy.cc)
> 译者：[gdb](http://www.zcfy.cc/@lllll)
> 链接：[http://www.zcfy.cc/article/2702](http://www.zcfy.cc/article/2702)
> 原文：[https://reactjsnews.com/playing-with-react-and-d3](https://reactjsnews.com/playing-with-react-and-d3)

现在，我们可以说 [React](https://facebook.github.io/react/) 是用于构建用户界面的首选JavaScript库。它几乎可以用在在任何地方，甚至和 [jQuery](https://jquery.com/) 一样广泛使用。它拥有简单，强大，易于学习的API。并且它的性能指标也令人印象深刻，这都归功于虚拟DOM及其状态变化之后巧妙的[diff算法](https://facebook.github.io/react/docs/reconciliation.html)。然而，没有什么是完美的，React 也有它的局限性。React 的最大优点之一是它可以非常方便的集成第三方库，但是有一些库，尤其是那些自以为是的，相比其它更加难以集成。


有一个非常受欢迎的第三方库，就很难与React集成，那就是[D3.JS](https://d3js.org/)。D3是一个优秀的数据可视化库，具有丰富和强大的API。它是数据可视化的黄金标准。然而，由于这个库对数据是固执己见的，所以要使它与 React 一起工作, 不是一个容易的事。有一些简单的策略允许这两个库以非常强大的方式一起工作。

**编者注**：看看我们下面的实例，[React 和 D3](http://bit.ly/1T0PG3b)，这是一个速成课程，学习如何用着两个库来创建数据可视化的效果。现在在Eventbrite预订您的位置并获得20％的入场费。 在[Eventbrite页面](http://bit.ly/1T0PG3b)了解更多信息

## 什么是React?


React 是一个开源的 JavaScript 库，用于构建用户界面，解决了构建数据随着时间变化的大型应用程序的挑战。最初在 facebook 开发，如今在许多最常用的Web应用程序，包括Instagram、Netflix、Airbnb，和hellosign都广泛的使用。

## 为什么 React 如此受欢迎?


React 帮助开发人员通过 管理应用程序状态来构建应用程序。它是一个简单的，声明式的并且可组合。React 不是传统的 MVC 框架，因为 React 只对构建用户界面感兴趣。有人认为它是 MVC 中的 V(view)，但是这有点误导人。React 的观点不同。随着应用程序的逻辑重新定向到客户端，开发人员已经将更多的结构应用于前端的JavaScript中。我们应用了一个我们已经从服务器（MVC）理解到浏览器的范例。当然，浏览器环境与服务器有很大的不同。React 承认客户端应用程序实际上是UI组件的集合，它们应该对用户交互的事件做出反应。

React 鼓励构建应用程序的从独立的，可重用的组件开始，它们只关心一小部分的UI。其他框架，如 Angular 也试图这样做，但 React 更加突出，因为它强制使用从从父组件到子组件的单向数据流。这使得调试更容易。调试是应用程序开发中最困难的部分，尽管 React 的用法比其他库或框架更为冗长，但却节省了大量的时间。在像Angular这样的框架中，很难弄清楚错误来自哪里：视图？模型？控制器？指令？指令控制器？ Angular流中的数据在许多方向上流动，这使得很难对您的应用程序的状态进行推理。而在 React 中，当有一个错误产生时（将有！），您可以快速确定错误源于何处，因为数据只朝一个方向移动。定位一个bug就像连接编号的点一样简单，直到你找到罪魁祸首。


## 什么是 D3?

D3（Data-Driven Documents - 数据驱动的文档）是一个用于生成动态，交互式，数据可视化的JavaScript 库。这是比较低的水平，开发人员对最终展现结果有很大的控制能力。需要做一些工作才能让D3完成你要的效果，所以如果你正在寻找一个更好的预先封装的解决方案，你可能会更喜欢使用 highcharts.js。也就是说，一旦你掌握了它的窍门，它就相当简单了。

D3会做4件主要的事情:

1.  导入: D3具有从CSV文档导入数据的简便方法。
2.  绑定: D3可以通过JavaScript和SVG将数据元素绑定到DOM。
3.  变换: 数据可以根据您的视觉要求进行调整。
4.  转换: D3可以响应用户输入和基于该输入的动画元素

## 为什么我们要一起使用 React 和 D3?

D3 擅长于数据可视化，但它是直接操纵 DOM 来显示数据。而渲染DOM元素正是 React 擅长的地方。它使用虚拟的DOM表示（虚拟DOM）和超高性能差异比较算法，以确定更新DOM最快的方式。我们想利用 React 的高效，声明式和可重用的组件 与 D3的数据实用功能来实现更好的体验。此外，一旦我们创建了一个图表组件，我们就可以在应用程序的任何地方使用不同数据来重用该图表。


## 怎样同时使用 React 和 D3?

D3，跟React一样，是声明式的。D3使用数据绑定，而React使用单向数据流范式。使这两个库共同工作需要一些工作，但是方法是相当简单的：由于SVG存在在DOM中，所以让 React 处理显示数据的SVG表示，而让 D3处理所有的数据的渲染。

当然，我们必须做出妥协。React 是无限制并且十分灵活的，从而允许您完成任何需要做的事情。 一些任务，如创建轴，是很乏味的。 我们可以让D3直接访问DOM并创建。它可以很好地处理轴，由于我们只需要创建很少的结构，因此这种策略不会影响性能。

我们来看一个简单的例子。 我创建了一个仓库：[play-with-react-and-d3](https://github.com/freddyrangel/playing-with-react-and-d3)。 您可以在`unfinished`目录中查看，如果卡住了，可以查看`finished`目录。

让我们生成一个随机的X-Y坐标点列表，并在ScatterPlot图上显示它们。 如果您正在阅读本教程，在`finish`目录下为您提供一个完整的示例，不过您也可以在`unfinished`下执行。我帮您完成所有设置。 该构建将自动从`unfinished/src/index.jsx`创建

让我们从创建一个简单的“Hello World” React 组件开始。在 `components` 下，创建一个文件，命名为`chart.jsx`.

```javascript
// unfinished/src/components/chart.jsx
import React from 'react';

export default (props) => {
  return <h1>Hello, World!</h1>;
}
```

这个例子很简单，不过我们还是来解释一下。 因为我们渲染一个没有状态的简单的 h1，我们只是导出了一个返回我们期望的HTML的函数。 如果您熟悉 Angular 或 Ember，可能对将HTML直接插入到我们的JS代码中感到很奇怪。 一方面，这违反了我们所学到的不引人注意的JavaScript的知识。 但另一方面，它实际上是有意义的：我们不是将JavaScript放在我们的HTML中，我们将HTML放入我们的JavaScript中。 React将HTML和客户端JavaScript作为根本的联结在一起。 他们都关心一件事 - 向用户呈现UI组件。 如果它们被分离，看起来就不会一目了然。 因此这种方法的巨大好处就是，您可以准确描述渲染时组件的外观。

另外，请记住，只有 JSX 才可以将 HTML元素 转换为 将HTML渲染到页面的React函数。

现在，我们继续,并将组件挂载到DOM上。打开`index.JSX`:

```javascript
// unfinished/src/index.jsx
import './main.css';
import React    from 'react';
import ReactDOM from 'react-dom';
import Chart    from './components/chart.jsx';

const mountingPoint = document.createElement('div');
mountingPoint.className = 'react-app';
document.body.appendChild(mountingPoint);
ReactDOM.render(<Chart/>, mountingPoint);
```

你可能注意到了几件事情。 你可能想知道为什么我们需要一个CSS文件。我们使用Webpack，它允许我们导入CSS文件。 当我们模块化我们的样式表和JavaScript时，这非常有用。我们还创建了一个用来挂载我们的React应用程序的 div元素。 如果你想在页面上执行其他操作，然后渲染一个React组件，这是一个很好的做法。 最后，我们在ReactDOM上调用`render`方法，它有两个参数，即组件的名称和我们要挂载的DOM元素。

现在，我们通过进入到`unfinished`目录并运行`npm i`来安装所有的依赖。然后，用`npm run start`启动服务器，然后在浏览器中打开`localhost:8080'

![Basic Render Image](http://p5.qhimg.com/t01410029a36803df93.png)

真棒！ 我们已经渲染了我们的第一个React组件！ 现在让我们做一些不那么琐碎的事情。


我们来定义一些函数，创建一个随机数据点的数组，然后渲染一个[散点图](https://en.wikipedia.org/wiki/Scatter_plot)。在我们这样做的时候，我们将添加一个按钮来随机生成数据集并触发我们应用程序的重新渲染。 我们打开我们的`Chart`组件并添加以下内容：


```javascript
// unfinished/src/components/chart.jsx
import React       from 'react';
import ScatterPlot from './scatter-plot';

const styles = {
  width   : 500,
  height  : 300,
  padding : 30,
};

// 图表中的数据点数
const numDataPoints = 50;

// 用来返回从0到1000的随机数的函数
const randomNum     = () => Math.floor(Math.random() * 1000);

// 用来创建50个（x，y）坐标元素的数组的函数。
const randomDataSet = () => {
  return Array.apply(null, {length: numDataPoints}).map(() => [randomNum(), randomNum()]);
}

export default class Chart extends React.Component{
  constructor(props) {
    super(props);
    this.state = { data: randomDataSet() };
  }

  randomizeData() {
    this.setState({ data: randomDataSet() });
  }

  render() {
    return <div>
      <h1>Playing With React and D3</h1>
      <ScatterPlot {...this.state} {...styles} />
      <div className="controls">
        <button className="btn randomize" onClick={() => this.randomizeData()}>
          Randomize Data
        </button>
      </div>
    </div>
  }
}

```

由于我们希望我们的组件能管理它自己的状态，所以我们需要添加一些比之前的“Hello World”无状态功能组件更多的代码。而不是只是一个函数，我们将继承`React.Component`并在`render()`方法中描述我们的组件。 `render()`是所有React组件的核心。它描述了我们的组件应该是什么样子的。React 将在第一次挂载和每次状态更改时调用`render()`。

在`render()`中，我们渲染了一个散点图组件，它就像是一个HTML元素，并设置了一些属性或着说`props`。 `...` 语法是一个方便的JSX和ES2015扩展运算符，可以展开数组或对象的属性，而不是明确地列出所有。 有关更多信息，请查看：[JSX Spread Attributes](https://facebook.github.io/react/docs/jsx-spread.html)。 我们将使用`render()`函数，并传入我们的数据和我们子组件使用的一些样式对象。

另外，我们还渲染了一个带有 onClick 事件处理程序的按钮。我们将用一个箭头函数包装`this.randomizeData()`，并将`this`的值绑定到`Chart`组件。 当点击按钮时，`randomizeData()`将调用`this.setState()`并传入一些新的数据。

我们来聊一聊`this.setState()`。 如果`render()`是React组件的核心，那么`setState()`就是组件的大脑。 `setState` 明确地告诉React我们正在改变状态，从而引发组件及其子组件的重新渲染。这实质上是将UI组件转换为状态机，随着状态的变化而变化。

在`setState()`的内部，我们传递一个对象，其中 `data` 被设置为`randomDataSet()`。 这意味着如果我们要检索我们的应用程序的状态，我们只需要调用`this.state.whateverStateWereLookingFor`。 在这种情况下，我们可以通过调用`this.state.data`来检索 randomData。

关于 React 如何工作的一点注意事项： React 通过实现一个差异比较算法，将内存中的虚拟DOM与实际的DOM进行比较，为渲染UI组件提供了极好的性能。你可以想象，DOM是一个很大的树结构。 如果从几十年的计算机科学研究中我们学到了一件事，那就是如何比较和操作树。React 利用了巧妙的树差异算法，也因此为了能正常工作，每个组件只能渲染一个父元素（即不能渲染兄弟元素）。这就是为什么在render函数中，我们将所有元素都包含在一个父 div 中。

让我们开始定义散点图组件。创建一个文件 `unfinished/src/components/scatter-plot.jsx`:

```javascript
// unfinished/src/components/scatter-plot.jsx
import React        from 'react';
import d3           from 'd3';
import DataCircles  from './data-circles';

// 从数据集中返回最大的 X 坐标
const xMax   = (data)  => d3.max(data, (d) => d[0]);

// 从数据集返回最大的 Y 坐标
const yMax   = (data)  => d3.max(data, (d) => d[1]);

// 返回将数据缩放X坐标以适合图表的函数
const xScale = (props) => {
  return d3.scale.linear()
    .domain([0, xMax(props.data)])
    .range([props.padding, props.width - props.padding * 2]);
};

// 返回将数据缩放Y坐标以适合图表的函数
const yScale = (props) => {
  return d3.scale.linear()
    .domain([0, yMax(props.data)])
    .range([props.height - props.padding, props.padding]);
};

export default (props) => {
  const scales = { xScale: xScale(props), yScale: yScale(props) };
  return <svg width={props.width} height={props.height}>
    <DataCircles {...props} {...scales} />
  </svg>
}

```

这里做了很多事情，所以让我们从我们导出的无状态功能组件开始吧。 D3 使用 SVG 渲染可视化的数据。它具有创建SVG元素并将数据绑定到这些元素的特殊方法 - 但是我们要让React处理这些。 我们使用了通过`Chart`组件传递的属性创建一个SVG元素，可以通过`this.props`访问它。 然后我们创建一个`DataCircles`组件（下面有更多的内容），它将渲染散点图的点。

我们来谈谈D3的缩放。 这是 D3 很闪耀的地方。 Scales 负责将您的数据转换为可以在图表上显示的格式。如果您的数据点值为189281，但是您的图表仅为200像素宽，则D3缩放将该值转换为可以使用的数字。

`d3.scale.linear()`返回一个线性缩放。 D3还支持其他类型的缩放（顺序，对数，平方根等），但是我们不会在这里讨论这些。 `domain`是`input domain`的缩写，即可能的输入值的范围。它需要可能的最小输入值的和最大输入值作为参数。 `range`本身就是可能的输出值的范围。 所以在`domain`中，我们从随机数据中设置可能的数据值范围，在`range`中，我们将D3的范围告诉我们的 chart。 `d3.max` 是D3中用于确定数据集的最大值的方法。 它可以用于给出X和Y坐标的最大值。

We use the scales to render the data circles and our axes.

我们使用刻度来渲染数据圈和轴。

我们在`unfinished/src/components/data-circles.jsx`中创建`DataCircles`组件

```javascript
// unfinished/src/components/data-circles.jsx
import React from 'react';

const renderCircles = (props) => {
  return (coords, index) => {
    const circleProps = {
      cx: props.xScale(coords[0]),
      cy: props.yScale(coords[1]),
      r: 2,
      key: index
    };
    return <circle {...circleProps} />;
  };
};

export default (props) => {
  return <g>{ props.data.map(renderCircles(props)) }</g>
}

```

在这个组件中，我们渲染了一个`g`元素，在 SVG 中相当于`div`。 因为我们想为每一组X-Y坐标渲染一个点，所以必须用`g`元素包裹多个同级元素,然后再进行渲染。 在`g`里面，我们将 map 数据，并使用`renderCircles`为每一组数据渲染一个圆。 `renderCircles`会创建一个具有多个属性的SVG`circle`元素。这里是我们用散点图组件传入的D3刻度来设置x和y坐标（分别为“cx”和“cy”）的位置。 `r`是我们圆的半径，`key`是React需要我们做的事情。由于我们会渲染多个相同的兄弟组件，所以React的差异化算法需要一种跟踪它们的方法，因为它会反复更新DOM。您可以使用任何您喜欢的键，只要它是列表唯一的。 这里我们可以使用每个元素的索引。

现在，我们看看浏览器，就像下面这样:

![Plot Points Image](http://p9.qhimg.com/t016773b10bb679def3.png)

我们可以看到我们随机产生的数据，并可以通过用户输入将该数据随机化。 真棒！ 但是我们没有方法来读取这些数据。我们需要一个轴。 现在我们来创建它们。

我们 `ScatterPlot.jsx`，然后添加一个`XYAxis`组件

```javascript
// unfinished/src/components/scatter-plot.jsx

// ...

import XYAxis       from './x-y-axis';

// ...

export default (props) => {
  const scales = { xScale: xScale(props), yScale: yScale(props) };
  return <svg width={props.width} height={props.height}>
    <DataCircles {...props} {...scales} />
    <XYAxis {...props} {...scales} />
  </svg>
}

```

现在，我们来创建 `XYAxis` 组件;

```javascript
// unfinished/src/components/x-y-axis.jsx
import React  from 'react';
import Axis   from './axis';

export default (props) => {
  const xSettings = {
    translate: `translate(0, ${props.height - props.padding})`,
    scale: props.xScale,
    orient: 'bottom'
  };
  const ySettings = {
    translate: `translate(${props.padding}, 0)`,
    scale: props.yScale,
    orient: 'left'
  };
  return <g className="xy-axis">
    <Axis {...xSettings}/>
    <Axis {...ySettings}/>
  </g>
}

```

为了简单起见，我们创建了两个对象，这些对象将保存我们每个 X-Y 轴的 props。 我们将创建一个轴组件来解释这些props是做什么的。 继续创建`axis.jsx`

```javascript
// unfinished/src/components/x-y-axis.jsx
import React from 'react';
import d3    from 'd3';

export default class Axis extends React.Component {
  componentDidMount() {
    this.renderAxis();
  }

  componentDidUpdate() {
    this.renderAxis();
  }

  renderAxis() {
    var node  = this.refs.axis;
    var axis = d3.svg.axis().orient(this.props.orient).ticks(5).scale(this.props.scale);
    d3.select(node).call(axis);
  }

  render() {
    return <g className="axis" ref="axis" transform={this.props.translate}></g>
  }
}

```

到目前为止，我们的策略是让React专注于处理DOM。这是一个很好规则，但我们应该留下细微的空间。在这种情况下，为了渲染一个轴所必需的数学知识和工作是相当复杂的，而且 D3 很好地将它们抽象了。在这种情况下，我们可以让D3来访问DOM。而且，由于我们只会渲染最多2个轴，所以在性能方面的影响是微不足道的。

我们要创建一个`g`元素来交给 D3及其DOM操作。 `transform`是`g`的属性，它定义了应用于元素和子元素变换定义的列表。我们传递一个`translate`属性，将`g`元素移动到我们想要的位置。 SVG类似于canvas，x坐标从顶部而不是底部开始，所以我们必须考虑到这一点。否则，我们的X轴将位于图表的顶部。对于Y轴，我们想留下一些渲染 tickmark 值的空间。

`componentDidMount()` 是一个特殊的 React 生命周期方法，在React组件挂载到DOM之后立即被调用。它只会在第一次渲染时调用。当这个组件现在呈现在DOM中时，我们将把一个真正的DOM节点传递给D3，这样它就可以发挥其魔力。 通过在`g`元素中添加一个`ref`属性，我们稍后就可以通过`this.refs`来引用它。 每次重新渲染此组件时，我们都希望D3重新绘制轴。 这就是要用到`componentDidUpdate()`的地方，每次重新渲染一个组件时都会调用它。 您可以在这里了解有关生命周期方法的更多信息（https://facebook.github.io/react/docs/component-specs.html）。

现在，如果再次查看浏览器，我们可以看到轴，当我们随机产生数据时，它们会自动更新以反映更改。

![Complete Chart Image](http://p9.qhimg.com/t014e105cea0f84aa01.png)

## 结论

这只是React和D3 的简短介绍。 如果您想了解更多信息，请查看我们即将举行的研讨会[React和D3](http://bit.ly/1T0PG3b)，这是一个学习如何在需求库中创建数据可视化效果的课程。 现在在Eventbrite预订您的位置并获得20％的入场费。 在[Eventbrite页面](http://bit.ly/1T0PG3b)了解更多信息

请启用JavaScript以查看[由Disqus提供的评论](http://disqus.com/?ref_noscript)
