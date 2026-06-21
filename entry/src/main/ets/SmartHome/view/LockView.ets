import { Device } from '../Model/Device';
import { LockViewModel } from '../viewModel/LockViewModel';
// 调试可选
import { Lock } from '../Model/Lock';
import { Location } from '../Common/Types'

/**
 * 智能锁卡片组件：Lock，提供开关控制和状态显示
 */
//@Entry
@Component
export struct LockView {
  /**
   * @ObjectLink：父子组件状态联动，设备状态变化时自动刷新 UI
   * 接收父组件传递的 Device 实例，向下转型为 Lock（需确保类型正确）
   * Lock 原始数据封装为ViewModel，为View层的组件提供数据（推荐使用MVVM架构）
   */
  @ObjectLink device: Device; // 接收父类对象
  // @State device:Device = new Lock('LockDemo001', '客厅门锁', Location.LivingRoom);
  @State lock: LockViewModel = new LockViewModel(this.device);

  build() {
    Column() {
      Row() {
        Column() {
          Row() {
            Text(this.lock.name)
              .fontSize(18)
              .fontColor(Color.Black)
              .fontWeight(FontWeight.Bold)
              .margin({ right: 12 })
            // 开关控件：绑定设备 status 状态，切换时调用 turnOn()/turnOff()
            Toggle({ type: ToggleType.Switch, isOn: this.lock.status === 'on' })
              .onChange((isOn: boolean) => {
                if (isOn) {
                  this.lock.turnOn();
                } else {
                  this.lock.turnOff();
                }
              })
          }
          .margin({ top: 24 })
          .justifyContent(FlexAlign.Start)

          Text(this.lock.status === 'on' ? '已打开' : '已关闭')
            .margin({ top: 8 })
            .fontSize(14)
            .fontColor('#666666')
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: 12 })

        // 弹性占位：推挤右侧图片到最右边
        Blank()
          .layoutWeight(1)

        // 状态图标：根据设备状态切换开锁/关锁图标
        Image((this.lock.status === 'on' ? $r('app.media.ic_unlock') : $r('app.media.ic_locked')))
          .width(80)
      }
    }
    .backgroundColor(Color.White)
    .borderRadius(15)
    .shadow({ radius: 16, color: '#5ec0d4f6', offsetY: 16 })
    .height(99)
    .margin({ left: 8, right: 8 })
  }
}