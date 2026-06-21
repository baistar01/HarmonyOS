import { Light } from '../Model/Light'
import { Device } from '../Model/Device'

@Observed
export class LightViewModel {
  private light: Light;
  name: string = '';
  status: 'on' | 'off' = 'off';
  brightness: number = 50;

  constructor(device: Device) {
    this.light = device as Light;
    this.name = device.name;
    this.status = this.light.getStatus();
    this.brightness = this.light.getBrightness();
  }

  getBrightness(): number {
    return this.light.getBrightness();
  }

  async turnOn(): Promise<void> {
    await this.light.turnOn();
    this.status = 'on';
  }

  async turnOff(): Promise<void> {
    await this.light.turnOff();
    this.status = 'off';
  }

  setBrightness(level: number): void {
    this.brightness = level;
    this.light.setBrightness(level);
  }
}