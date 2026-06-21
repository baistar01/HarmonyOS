import { DeviceType, Location } from '../Common/Types'
import { Device } from './Device'
import { delay, logAction } from '../utils/DeviceUtils'

/**
 * 空调子类，扩展温度调节功能
 */
export class AirConditioner extends Device {
  private temperature: number = 26;

  constructor(id: string, name: string, location: Location) {
    super(id, name, DeviceType.AirConditioner, location);
  }

  // 实现开空调逻辑
  async turnOn(): Promise<void> {
    try {
      await delay(200); // 模拟延迟开灯
      this.temperature = 26;
      this.status = 'on';
      logAction(`${this.getInfo()} 已开启，当前亮度为${this.temperature}%`);
    } catch (error) {
      console.log(`error:${(error as Error).message}`);
    }
  }

  // 实现关空调逻辑
  async turnOff(): Promise<void> {
    try {
      await delay(100);
      this.status = 'off';
      logAction(`${this.getInfo()}已关闭}`);
    } catch (error) {
      console.log(`error:${(error as Error).message}`);
    }
  }

  // 获取当前温度
  getTemperature(): number {
    return this.temperature;
  }

  // 设置温度
  setTemperature(temp: number): void {
    if (this.status == 'on') {
      if (temp < 26) {
        this.temperature = 26;
      } else if (temp > 30) {
        this.temperature = 30;
      } else {
        this.temperature = temp;
      }
      logAction(`${this.getInfo()} 温度已经调整为：${this.temperature}°C`);
    }
  }
}