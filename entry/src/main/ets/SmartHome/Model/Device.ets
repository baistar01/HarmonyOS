// 定义了IDevice接口以及Device抽象基类

import { DeviceType, Location } from '../Common/Types'

export interface IDevice {
  id: string; // 设备唯一标识符
  name: string; // 设备名称
  type: DeviceType; // 设备类型
  location: Location; // 设备位置
  turnOn(): Promise<void>; // 打开设备方法，支持异步操作
  turnOff(): Promise<void>; // 关闭设备方法，支持异步操作
}

/**
 * 设备抽象基类
 * 所有设备类型都继承此类
 */
export abstract class Device implements IDevice {
  id: string = '';
  name: string = '';
  type: DeviceType = DeviceType.Light;
  location: Location = Location.All;
  protected status: 'on' | 'off' = 'off'; // 类型约束

  // 构造函数
  constructor(id: string, name: string, type: DeviceType, location: Location) {
    this.id = id;
    this.name = name;
    this.type = type;
    this.location = location;
  }

  getStatus(): 'on' | 'off' {
    return this.status;
  }

  abstract turnOn(): Promise<void>;

  abstract turnOff(): Promise<void>;

  getInfo(): string {
    return `${this.name} (${Location[this.location]} 位置的 ${DeviceType[this.status]} 设备)`;
  }
}