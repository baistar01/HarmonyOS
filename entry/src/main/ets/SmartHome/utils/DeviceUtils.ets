/**
 * 模拟异步延迟
 */

export function delay(time: number): Promise<void> {
  // resole，Promise中的回调函数
  // setTimeout，延迟time毫秒后执行resolve回调函数
  return new Promise(resolve => setTimeout(resolve, time));
}

/**
 * 设备操作日志
 */

export const logAction = (msg: string): void => {
  // new Date().toISOString()，表示标准UTC时间格式
  // DeviceLog，表示日志格式开头
  console.log(`[DeviceLog] ${new Date().toISOString()}:${msg}`);
};