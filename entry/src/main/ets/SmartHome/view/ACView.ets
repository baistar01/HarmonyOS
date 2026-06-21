import { BusinessError } from '@kit.BasicServicesKit';
import { Device } from '../Model/Device';
import { ACViewModel } from '../viewModel/ACViewModel';
import { promptAction } from '@kit.ArkUI';
// 调试可选
import { AirConditioner } from '../Model/AirConditioner';
import { Location } from '../Common/Types'

/**
 * 空调卡片组件：支持开关控制和温度设置
 */
//@Entry
@Component
export struct ACView {
  @ObjectLink device: Device;
  //@State device:Device = new AirConditioner('ACDemo001', '客厅空调', Location.LivingRoom);
  @State ac: ACViewModel = new ACViewModel(this.device);

  // 温度调节按钮组件（+-）
  // 自定义Ui函数，可复用
  @Builder
  SetButton(isAdd: boolean) {
    Image(isAdd ? $r('app.media.ic_plus') : $r('app.media.ic_minus'))
      .width(28)
      .height(28)
      .onClick(() => {
        if (this.ac.status === 'on') {
          if (isAdd) {
            this.ac.setTemperature(Math.min(30, this.ac.temperature + 1));
          } else {
            this.ac.setTemperature(Math.max(16, this.ac.temperature - 1));
          }
        } else {
          // promptAction是内置弹窗工具对象
          // openToast：短暂弹出文字提示，自动消失，无交互
          promptAction.openToast({
            message: '设备已关闭',
            duration: 2000
          }).catch((error: BusinessError) => {
            console.error(`openToast error code is ${error.code}, message is ${error.message}`);
          });
        }
      })
  }

  build() {
    Column() {
      Row() {
        Column() {
          Row() {
            Text(this.device.name)
              .fontSize(18)
              .fontColor(Color.Black)
              .fontWeight(FontWeight.Bold)
              .margin({ right: 12 })
            Toggle({ type: ToggleType.Switch, isOn: this.ac.status === 'on' })
              .onChange((isOn: boolean) => {
                if (isOn) {
                  this.ac.turnOn();
                } else {
                  this.ac.turnOff();
                }
              })
          }
          .margin({ top: 24 })
          .justifyContent(FlexAlign.Start)

          Text(this.ac.status === 'on' ? '已开启' : '已关闭')
            .margin({ top: 8 })
            .fontSize(14)
            .fontColor('#666666')
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: 12 })

        Blank()
          .layoutWeight(1)

        Image((this.ac.status === 'on' ? $r('app.media.ic_ac_on') : $r('app.media.ic_ac_off')))
          .width(80)
      }
      .justifyContent(FlexAlign.Start)

      // 温度控制区域
      Row() {
        // 减号按钮
        this.SetButton(false)

        Text(`${this.ac.temperature}°C`)
          .fontSize(16)
          .margin({ left: 20, right: 20 })

        // 加号按钮
        this.SetButton(true)
      }
      .margin({ top: 24, bottom: 16 })
    }
    .backgroundColor(Color.White)
    .borderRadius(15)
    .shadow({ radius: 16, color: '#5ec0d4f6', offsetY: 16 })
    .height(155)
    .margin({ left: 8, right: 8, })
  }
}