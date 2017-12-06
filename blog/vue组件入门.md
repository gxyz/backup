author: me
title: vue组件入门
date: 2017-02-06 15:32:44
tags: 
    - vue
---

## Vue组件(Component)概述

Vue.js中的组件可以扩展HTML元素，用来定义自定义元素，可以封装可重用的代码，提高代码复用性。

## 注册组件

#### 注册全局组件

要注册全局组件，直接使用 `Vue.component(tagName, options)`，不过需要注意的是全局组件需要在根实例初始化之前注册,才可以正常使用,如下 

```html
<div>
    <my-component></my-component>
</div>
```

```javascript
// 注册全局组件
Vue.component('my-component', {
    template: '<span>A custom component!</span>'
})

// 创建根实例
new Vue({
    el: "#example"
})
```

将渲染为:

```html
<div id="example">
    <span>A custom component!</span>
</div>
```

这里注册组件使用的 tagName 虽然不强制要求遵循 W3C规则 （小写，并且包含一个短杠），但是遵循这个规则比较好。

#### 注册局部组件

除了定义全局组件，还可以在组件实例中通过 components 选项来组成局部组件，局部组件只能在另一个实例或者组件作用域中才可以使用

```
var Child = {
  template: '<div>A custom component!</div>'
}

new Vue({
  components: {
    'my-component': Child
  }
})
```

此时这个 `<my-component></my-component>` 就只可以在父模板中使用

## 组件之间的通信

我们经常会将多个组件组合使用，这是就需要组件之间能够相互通信,父组件要给子组件传递数据，子组件需要将它内部发生的事情告知给父组件等等

#### 父组件使用props给子组件传递数据

组件之间的作用域是独立的，因此即使在子组件中也不可以之间访问父组件之中的属性，因此就需要使用 props 来将数据传递给子组件

使用方式:

```
Vue.component('child', {
  // 声明 props
  props: ['message', 'myMessage'],
  // 就像 data 一样，prop 可以用在模板内
  // 同样也可以在 vm 实例中像 “this.message” 这样使用
  template: '<span>{{ message }} - {{ my-message }}</span>'
})
```

即在子组件中声明 props 选项,　其中的值代表着 父组件用来给子组件传递数据的自定义属性。这些自定义使用也可以使用 `v-bind`来绑定

使用方式:

```
<child message="hello" my-message="world"></child>
```

渲染之后:

```
<span>hello - world</span>
```

> 注意：这里 props 中的名字形式会从`camelCase`(驼峰式) 转换为 `kebab-case`(短横线); 不过如果你使用字符串模版，不用在意这些限制。

使用 props 只能从父组件给子组件传递数据，这只是单向的；每次父组件更新，子组件的prop也会更新，我们不应该在子组件内部改变 prop，不然会发出警告.

**prop验证**

组件可以为 props 指定验证要求。如果未指定验证要求，Vue 会发出警告。当组件给其他人使用时这很有用。

prop 是一个对象而不是字符串数组时，它可以包含验证要求：

```
Vue.component('example', {
  props: {

    prop1: {
      type: String,   // prop类型
      required: true,  // 是否是必须的
      default: "hello",   // 设置默认值
    },
    
    prop2: {
      type: Object,
      default: function () {    // 默认值可以由一个工厂函数的返回值确定
        return { message: 'hello' }
      }
    },
    prop3: { 
      validator: function (value) {   // 还可以自定义验证函数
        return value > 10
      }
    }
  }
})
```

type 可以是下面原生构造器：

- String
- Number
- Boolean
- Function
- Object
- Array

type 也可以是一个自定义构造器，使用 instanceof 检测。

#### 子组件通过自定义事件来与父组件通信

子组件通过自定义事件来与父组件进行通信

每个 Vue 实例都实现了事件接口(Events interface)：

- 使用 $on(eventName) 监听事件
- 使用 $emit(eventName) 触发事件

父组件可以在使用子组件的地方直接用 v-on 来监听子组件触发的事件。


```html
<div id="counter-event-example">
  <p>{{ total }}</p>
  <!-- 在根模板中监听自定义事件 -->
  <button-counter v-on:increment="incrementTotal"></button-counter>
  <button-counter v-on:increment="incrementTotal"></button-counter>
</div>
```

```javascript
Vue.component('button-counter', {
    template: '<button v-on:click="increment">{{counter}}</button>',
    data: function() {
        return {
            counter: 0
        }
    },
    methods: {
        increment: function() {
            this.counter += 1

            // 触发自定义事件
            this.$emit('increment')
        }
    }
})

new Vue({
    el: "#counter-event-example",
    data: {
        total: 0
    },
    methods: {
        incrementTotal: function() {
            this.total += 1
        }
    }
})
```

在本例中，子组件已经和它外部完全解耦了。它所做的只是触发一个父组件关心的内部事件。


#### 非父子组件之间的通信

如果非父子关系的组件需要通信。在简单的场景下，使用一个空的 Vue 实例作为中央事件总线：

```
var bus = new Vue()

// 触发组件 A 中的事件
bus.$emit('id-selected', 1)

// 在组件 B 创建的钩子中监听事件
bus.$on('id-selected', function (id) {
  // ...
})
```
复杂的情况下，你应该考虑使用专门的 状态管理。


## 组件选项

#### template - 模板

template 用来指定组件使用的HTML模板，可以是直接是一个字符串模板

```
template: '<div>hello world</div>'
```

也可以用来引用 html 中的 template 元素内容:

```html
<template id="tmpl">
    <div>hello world</div>
</template>
```

```
template: "#tmpl"
```

这里需要注意当使用 DOM 作为模版时（例如，将 el 选项挂载到一个已存在的元素上）,会受到 HTML 的一些限制,因为 Vue 只有在浏览器解析和标准化 HTML 后才能获取模版内容, 因此有些 html 标签会限制子元素，此时可以使用 is 选项来指定组件的名字，来解决这种限制 

不过，如果您使用来自以下来源之一的字符串模板，这些限制将不适用：

- JavaScript内联模版字符串
- .vue 组件

因此，有必要的话就使用字符串模版。

#### data 必须是函数

在定义组件时，使用的data必须是函数

```javascript
Vue.component('simple-counter', {
  template: '<button v-on:click="counter += 1">{{ counter }}</button>',
  // data 是一个函数，因此 Vue 不会警告，
  // 但是我们为每一个组件返回了同一个对象引用
  data: function () {
    return {
        name: 'gdb'
    }
  }
})
```

如果data是一个对象，那么如果定义了多个组件实例，那么这几个组件都会共享这一个对象，那么这几个组件的数据变化就是同步的了，没有意义，因此不能使用对象;
而 data 是函数是，直接返回一个对象，此时每次调用函数返回的对象都是一个新的对象，因此多个对象就有自己的数据了

