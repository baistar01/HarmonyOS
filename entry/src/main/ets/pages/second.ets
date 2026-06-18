import { BusinessError } from '@kit.BasicServicesKit';
import { UIContext } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
        // 添加按钮，以响应用户onClick事件
        Button() {
          Text('Next')
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
        }
        .type(ButtonType.Capsule)
        .margin({
          top: 20
        })
        .backgroundColor('#0D9FFB')
        .width('40%')
        .height('5%')
        // 创建按钮点击事件
        .onClick(() => {
          // 第一种，修改id
          //this.message = 'Hello';
          // 第二种，页面跳转
          let uiContext: UIContext = this.getUIContext();
          let router = uiContext.getRouter();
          router.pushUrl({url: 'pages/third'}).then(() =>{
            console.info('Succeeded in jumping to the second page.')
          }).catch((err: BusinessError) =>{
            console.error('Failed to jump to the second page. Code is ${err.code}, message is ${err.message}')
          })
        })
      }
      .width('100%')
    }
    .height('100%')
  }
}