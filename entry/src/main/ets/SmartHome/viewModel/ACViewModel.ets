import { AirConditioner } from '../Model/AirConditioner'
import { Device } from '../Model/Device'

@Observed
export class ACViewModel {
  private AC: AirConditioner;
  name: string = '';
  status: 'on' | 'off' = 'off';
  temperature: number = 26;

  constructor(device: Device) {
    this.AC = device as AirConditioner;
    this.name = device.name;
    this.status = this.AC.getStatus();
    this.temperature = this.AC.getTemperature();
  }

  getTemperature(): number {
    return this.AC.getTemperature();
  }

  async turnOn(): Promise<void> {
    await this.AC.turnOn();
    this.status = 'on';
  }

  async turnOff(): Promise<void> {
    await this.AC.turnOff();
    this.status = 'off';
  }

  setTemperature(level: number): void {
    this.temperature = level;
    this.AC.setTemperature(level);
  }
}