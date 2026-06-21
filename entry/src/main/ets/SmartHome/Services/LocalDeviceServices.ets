import { Light } from '../Model/Light'
import { AirConditioner } from '../Model/AirConditioner'
import { Lock } from '../Model/Lock'
import { delay } from '../utils/DeviceUtils'
import { IDeviceService } from '../Services/IDeviceService'
import { Location } from '../Common/Types'
import { Device } from '../Model/Device'

/**
 *泛型本地设备服务类
 * @template T - 设备类型，约束为Device的子类
 * 包含：设备初始化、设备获取、设备操作、设备筛选、位置管理
 **/

@Observed
export class LocalDeviceService<T extends Device> implements IDeviceService<T> {
  private devices: T[] = []; // 私有设备列表：内部维持原始数据
  private filteredDevices: T[] = []; // 筛选后的设备列表：供外部查询
  private locations: string[] = []; // 所有位置列表：自动从设备中提取
  private selectedLocation: string = 'all'; // 当前选中的位置筛选条件

  // 初始化设备
  initialize(): void {
    this.devices = [
      new Light('Light1', '客厅主灯', Location.LivingRoom),
      new AirConditioner('AC1', '卧室空调', Location.BedRoom),
      new Lock('LOCK1', '门锁', Location.Entrance)
    ] as T[];

    // 初始化位置列表和筛选设备
    this.updateLocations(); // 从设备列表中提取所有位置
    this.filterDevicesByLocation('all'); // 筛选all位置的设备
    console.log('本地设备服务初始化完成，已加载默认设备');
  }

  // 获取所有设备
  async getDevices(): Promise<T[]> {
    await delay(100); // 延迟运行
    // ...是展开运算符，进行浅拷贝
    return [...this.devices];
  }

  // 获取筛选后的设备列表
  getFilteredDevices(): T[] {
    return [...this.filteredDevices];
  }

  // 获取所有位置
  getLocations(): string[] {
    return [...this.locations];
  }

  // 获取当前选中的位置
  getSelectedLocation(): string {
    return this.selectedLocation;
  }

  // 根据位置筛选设备
  filterDevicesByLocation(location: string): void {
    this.selectedLocation = location;
    if (location === 'all') {
      this.filteredDevices = [...this.devices];
    } else {
      // filter是数组过滤方法，遍历数组，只保留满足条件的设备
      // toLowerCase是内置方法，将大写字母转换为小写字母
      this.filteredDevices = this.devices.filter(device => device.location.toLowerCase() === location.toLowerCase())
    }
  }

  // 从设备列表中提取所有位置，自动去除重复元素
  private updateLocations(): void {
    // set是集合容器，不允许重复元素
    const locationSet = new Set<string>();
    // forEach循环取出设备元素，将设备元素的位置放进集合
    this.devices.forEach(device => locationSet.add(device.location));
    // from内置方法，将set容器转换为array数组容器
    this.locations = Array.from(locationSet);
  }
}