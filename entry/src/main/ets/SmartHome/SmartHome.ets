import { LocalDeviceService } from './Services/LocalDeviceServices'
import { Device } from './Model/Device'
import { ACView } from './view/ACView'
import { LightView } from './view/LightView'
import { LockView } from './view/LockView'
import { logAction } from './utils/DeviceUtils'

@Entry
@Component
struct Index {
  @State deviceService: LocalDeviceService<Device> = new LocalDeviceService<Device>();

  // 生命周期回调函数：组件实例创建完成，即将渲染到页面，界面还没显示出来
  aboutToAppear() {
    this.initSystem();
  }

  // 初始化系统：调用服务层进行初始化
  async initSystem() {
    this.deviceService.initialize();
    try {
      // 触发设备加载，延迟模拟
      await this.deviceService.getDevices();
    } catch (error) {
      console.error(`设备加载失败:${(error as Error).message}`)
    }
  }

  // 位置显示名称转换
  getLocationDisplayName(location: string): string | ResourceStr {
    // Record是手动显示标注的 字典 类型
    const locationMap: Record<string, Resource> = {
      'livingRoom': $r('app.string.livingRoom'),
      'bedroom': $r('app.string.bedroom'),
      'entrance': $r('app.string.entrance'),
      'all': $r('app.string.all')
    };
    return locationMap[location] || location;
  }

  build() {
    Column() {
      // 标题栏
      Column() {
        Text($r('app.string.smart_home_control'))
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 10, left: 16 })
      }

      // 位置筛选器（数据和逻辑都来自service）
      // space:8：表示所有子组件之间，统一留出8vp的间距
      Row({ space: 8 }) {
        Button(this.getLocationDisplayName('all'))
          .width(60)
          .height(36)
          .backgroundColor(this.deviceService.getSelectedLocation() === 'all' ? '#0A59F7' : '#0D000000')
          .fontSize(14)
          .fontColor(this.deviceService.getSelectedLocation() === 'all' ? '#ffffff' : '#E6000000')
          .onClick(() => this.deviceService.filterDevicesByLocation('all'))

        // ForEach(数据源, 渲染回调箭头函数)
        ForEach(this.deviceService.getLocations(), (location: string) => {
          Button(this.getLocationDisplayName(location))
            .width(60)
            .height(36)
            .backgroundColor(this.deviceService.getSelectedLocation() === location ? '#0A59F7' : '#0D000000')
            .fontSize(14)
            .fontColor(this.deviceService.getSelectedLocation() === location ? '#ffffff' : '#E6000000')
            .onClick(() => this.deviceService.filterDevicesByLocation(location))
        })
      }
      .margin({ top: 10, left: 16, bottom: 15 })

      // 设备列表（展示筛选后的设备）
      List() {
        if (this.deviceService.getFilteredDevices().length === 0) {
          ListItem() {
            Text($r('app.string.device_not_found'))
              .fontSize(16)
              .fontColor('#666')
              .padding(20)
              .width('100%')
              .textAlign(TextAlign.Center)
          }
        } else {
          ForEach(this.deviceService.getFilteredDevices(), (device: Device) => {
            ListItem() {
              // 根据设备类型渲染对应组件
              if (device.type === 'ac') {
                ACView({
                  device: device,
                })
              } else if (device.type === 'light') {
                LightView({
                  device: device,
                })
              } else {
                LockView({
                  device: device,
                })
              }
            }
            .margin({ left: 8, right: 8, bottom: 12 })
          })
        }
      }
      .scrollBar(BarState.Off) // 滚动容器设置滚动条状态
      .layoutWeight(1)
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .ignoreLayoutSafeArea() // 忽略安全区限制
    .height(LayoutPolicy.matchParent)
    .padding({ top: 48 }) // 内边距，组件内部内容与组件自身边框之间的距离
    .width('100%')
    // linearGradient:线性渐变背景
    // direction: GradientDirection.Bottom：从顶部到底部渐变
    // colors:[[color,pos],[color,pos]]：渐变色值数组
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['#CBD9F3', 0], [Color.White, 1]]
    })
  }
}