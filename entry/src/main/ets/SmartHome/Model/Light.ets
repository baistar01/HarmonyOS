import { DeviceType, Location } from '../Common/Types'
import { Device } from './Device'
import { delay, logAction } from '../utils/DeviceUtils'

/**
 * 灯光子类，扩展亮度调节功能，支持UI联动
 */
export class Light extends Device {
  private brightness: number = 50;

  constructor(id: string, name: string, location: Location) {
    super(id, name, DeviceType.Light, location);
  }

  // 实现开灯逻辑
  async turnOn(): Promise<void> {
    try {
      await delay(100); // 模拟延迟开灯
      this.brightness = 50;
      this.status = 'on';
      logAction(`${this.getInfo()} 已开启，当前亮度为${this.brightness}%`);
    } catch (error) {
      console.log(`error:${(error as Error).message}`);
    }
  }

  // 实现关灯逻辑
  async turnOff(): Promise<void> {
    try {
      await delay(100);
      this.status = 'off';
      logAction(`${this.getInfo()}已关闭}`);
    } catch (error) {
      console.log(`error:${(error as Error).message}`);
    }
  }

  // 获取当前亮度
  getBrightness(): number {
    return this.brightness;
  }

  // 设置亮度
  setBrightness(level: number): void {
    this.brightness = Math.max(0, Math.min(100, level));
    if (this.status == 'on') {
      logAction(`${this.getInfo()}的亮度已经调整为${this.brightness}%`);
    }
  }
}