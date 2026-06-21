// 实现初始化设备接口

/**
 *设备服务核心接口
 * @template T 设备类型 约束为Device类
 */

export interface IDeviceService<T> {
  initialize(): void; // 初始化设备

  getDevices(): Promise<T[]>; //获取设备原始列表，Promise表示异步返回

  getFilteredDevices(): T[]; // 得到筛选后的设备列表

  getLocations(): string[]; // 获取所有设备位置

  getSelectedLocation(): string; // 获取选中的筛选位置

  filterDevicesByLocation(location: string): void; //根据位置筛选设备
}