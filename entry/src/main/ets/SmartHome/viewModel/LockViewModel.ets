import { Lock } from '../Model/Lock'
import { Device } from '../Model/Device'

@Observed
export class LockViewModel {
  private lock: Lock;
  name: string = '';
  status: 'on' | 'off' = 'off';

  constructor(device: Device) {
    this.lock = device as Lock;
    this.name = device.name;
    this.status = this.lock.getStatus();
  }

  async turnOn(): Promise<void> {
    await this.lock.turnOn();
    this.status = 'on';
  }

  async turnOff(): Promise<void> {
    await this.lock.turnOff();
    this.status = 'off';
  }
}