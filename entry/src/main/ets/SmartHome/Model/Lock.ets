import { DeviceType, Location } from '../Common/Types'
import { Device } from './Device'
import { delay, logAction } from '../utils/DeviceUtils'

/**
 * 锁子类，扩展温度调节功能
 */
export class Lock extends Device {
  constructor(id: string, name: string, location: Location) {
    super(id, name, DeviceType.Lock, location);
  }

  // 实现开锁逻辑
  async turnOn(): Promise<void> {
    try {
      await delay(100); // 模拟延迟开灯
      this.status = 'on';
      logAction(`${this.getInfo()} 已开锁`);
    } catch (error) {
      console.log(`error:${(error as Error).message}`);
    }
  }

  // 实现关锁逻辑
  async turnOff(): Promise<void> {
    try {
      await delay(100);
      this.status = 'off';
      logAction(`${this.getInfo()}已关闭}`);
    } catch (error) {
      console.log(`error:${(error as Error).message}`);
    }
  }
}