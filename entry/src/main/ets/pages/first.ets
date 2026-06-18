import { BusinessError } from '@kit.BasicServicesKit';

@Preview
@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  build() {
    RelativeContainer() { // 相对布局容器
      Text(this.message)
        .id('HelloWorld') // 初始化id
        .fontSize($r('app.float.page_text_font_size')) // 大小
        .fontWeight(FontWeight.Bold) // 粗体
        .alignRules({
          // 垂直居中
          center: { anchor: '__container__', align: VerticalAlign.Center },
          // 水平居中
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        // 文本点击事件回调
        .onClick(() => {

          // 第一种
          // 页面重新渲染，修改id
          //this.message = 'Welcome';

          // 第二种
          // 页面跳转
          console.info(`Succeeded in clicking the 'Next' button.`) // 打印日志
          // 使用“getUIContext”获取当前组件所属独立UI运行环境上下文，包含当前页面的所有能力（路由、弹窗、测量、主题等）。
          let uiContext: UIContext = this.getUIContext();
          // 使用“getRoute”获取当前上下文的路由能力
          let router = uiContext.getRouter();
          // 使用“pushUrl”打开新页面，保留原页面，支持返回。
          // pushUrl是异步操作，返回Promise。
          // then表示异步操作成功时运行，catch表示异步操作失败时运行。
          router.pushUrl({ url: 'pages/third' }).then(() => {
            console.info('Succeeded in jumping to the second page.')
          }).catch((err: BusinessError) => {
            console.error('Failed to jump to the second page. Code is ${err.code}, message is ${err.message}')
          })
        })
    }
    .height('100%')
    .width('100%')
  }
}