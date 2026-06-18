/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

@Entry
@ComponentV2
struct GreetingCard {
  build() {
    Column() {
      GreetingTitle()
      GreetingDetail()
    }
    .width('100%')
    .height('100%')
    .padding({
      left: 16,
      right: 16
    })
  }
}

@Preview
@ComponentV2
struct GreetingTitle {
  build() {
    Row() {
      Text('Greeting Card')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontFamily('HarmonyHeiTi') // 鸿蒙黑体
    }
    .width('100%')
    .height(56)
  }
}

@Preview
@ComponentV2
struct GreetingDetail {
  @Local message: string = 'Hello World';

  build() {
    Column() {
      Column() {
        Image($r('app.media.card_icon'))
          .width(260)
        Text(this.message)
          .fontSize(24)
          .fontWeight(FontWeight.Normal) // 400字重，字体粗细正常
          .fontFamily('HarmonyHeiTi') // 鸿蒙黑体
          .textAlign(TextAlign.Center)
          .margin({ top: 16 })
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)

      Button('Click Me')
        .width('100%')
        .constraintSize({ maxWidth: '448vp' }) // 最大宽度不超过448vp
        .fontColor('#0A59F7')
        .fontSize(16)
        .fontWeight(FontWeight.Medium) // 500字重，字体粗细适中
        .fontFamily('HarmonyHeiTi')
        .backgroundColor('#260A59F7') // 设置为浅蓝色背景
        .margin({
          top: 16,
          bottom: 16
        })
        .onClick(() => {
          // this.message变量在Hello World和Hello HarmonyOS之间变化
          if (this.message === 'Hello World') {
            this.message = 'Hello HarmonyOS';
          } else {
            this.message = 'Hello World';
          }
        })
    }
    .width('100%')
    .layoutWeight(1)
  }
}