import { LightViewModel } from '../viewModel/LightViewModel'
import { Device } from '../Model/Device'
//调试可选
import { Location } from '../Common/Types'
import { Light } from '../Model/Light'

// 灯光卡片组件：支持开关控制和调节亮度
//调试需要添加@Entry
@Component
export struct LightView {
  // 子组件需要使用@ObjectLink
  @ObjectLink device: Device;
  // 调试需要自行创建Light设备
  // @State device:Device = new Light('LightDemo001', '客厅灯', Location.LivingRoom);
  @State light: LightViewModel = new LightViewModel(this.device);

  build() {
    Column() {
      Row() {
        Column() {
          Row() {
            Text(this.light.name)
              .fontSize(18)
              .fontColor(Color.Black)
              .fontWeight(FontWeight.Bold)
              .margin({ right: 12 })
            // ToggleType.Switch：滑动开关
            // 扩展：ToggleType.Checkbox:复选框，ToggleType.Button:状态按钮
            Toggle({ type: ToggleType.Switch, isOn: this.light.status === 'on' })
              .width(36)
              .height(20)
              .onChange((isOn: boolean) => {
                if (isOn) {
                  this.light.turnOn();
                } else {
                  this.light.turnOff();
                }
              })
          }
          .margin({ top: 24 })
          // FlexAlign.Start：主轴起始点位置对齐
          .justifyContent(FlexAlign.Start)

          Text(`亮度${this.light.brightness}%`)
            .margin({ top: 8 })
            .fontSize(14)
            .fontColor('#666666')
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: 12 })

        Blank()
          .layoutWeight(1)

        Image(this.light.status === 'on' ? $r('app.media.ic_bulb_on') : $r('app.media.ic_bulb_off'))
          .width(80)
      }
      .justifyContent(FlexAlign.Start)

      Row() {
        Image($r('app.media.minus_sun'))
          .height(21)
          .margin({ left: 12 })

        // 滑块组件：用于连续调节亮度（0~100）
        Slider({
          value: this.light.getBrightness(),
          min: 0,
          max: 100,
          step: 1,
          style: SliderStyle.InSet // 内嵌在滑轨中
        })
          .enabled(this.light.status === 'on') // 控制滑块是否可拖动
          .showTips(this.light.status === 'on') // 拖动滑块时，是否可以弹出数字提示气泡
          .layoutWeight(1) // 弹性占比
          .blockColor(Color.White) // 滑块小圆点，设置为小白点
          .selectedColor(this.light.status === 'on' ? '#0A59F7' : '#0d000000') // 灯开启蓝色进度条，灯关闭白色进度条
          .trackThickness(20) // 滑轨粗细
          .width(120)
          // 回调：监听滑块拖动变化事件
          .onChange(value => {
            this.light.setBrightness(value);
          })
          .margin({ left: 12, right: 12 })

        Image($r('app.media.plus_sun'))
          .height(21)
          .margin({ right: 12 })
      }
      .margin({ top: 24, bottom: 16 })
      .alignItems(VerticalAlign.Center) // 外层Row容器，所有元素在垂直方向居中对齐
      .width('100%')
    }
    .backgroundColor(Color.White) // 组件背景为纯白色
    .borderRadius(15) // 圆角，四个角的弧度为15
    .shadow({ radius: 16, color: '#5ec0d4f6', offsetY: 16 }) // 给卡片添加阴影效果
    .height(155)
    .margin({ left: 8, right: 8 })
  }
}