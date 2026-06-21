// 枚举设备/安装位置类型

/**
 * 设备类型枚举
 * 灯、空调、锁
 */
export enum DeviceType {
  Light = 'light',
  AirConditioner = 'ac',
  Lock = 'Lock',
}

/**
 * 安装位置枚举
 * 客厅、卧室、通道
 */
export enum Location {
  All = 'all',
  LivingRoom = 'livingRoom',
  BedRoom = 'bedroom',
  Entrance = 'entrance',
}