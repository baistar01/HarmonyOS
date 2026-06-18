// third.ets
@Preview
@Entry
@Component
struct Third {
  @State message: string = 'Hello';

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(70)
          .fontWeight(FontWeight.Bold)
          //.borderStyle(BorderStyle.Dashed) // 边框线型
          //.backgroundImageSize(ImageSize.Auto) // 背景图片的缩放原则
          //.backgroundColor(Color.Green) // 背景颜色
        Button() {
          Text('Back')
            .fontSize(50)
            .fontWeight(FontWeight.Bold)
        }
        .type(ButtonType.Capsule)
        .margin({
          top: 30
        })
        .backgroundColor('#0D9FFB')
        .width('45%')
        .height('10%')
        .onClick(() => {
          console.info(`Succeeded in clicking the 'Back' button.`)
          // 获取UIContext
          let uiContext: UIContext = this.getUIContext();
          let router = uiContext.getRouter();
          try {
            // 返回上一页
            router.back()
            console.info('Succeeded in returning to the first page.')
          } catch (err) {
            let code = (err as BusinessError).code;
            let message = (err as BusinessError).message;
            console.error(`Failed to return to the first page. Code is ${code}, message is ${message}`)
          }
        })
      }
      .width('100%')
    }
    .height('100%')
  }
}