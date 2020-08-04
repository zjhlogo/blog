---
title: Unity手册 Attributes
date: 2020-08-04 17:15:03
tags:
- Unity
- Attribute
---

## 菜单 Menu

- AddComponentMenu
  作用于类上，将脚本置于 UnityEditor 顶部菜单栏 Component 菜单中的任意选项，而不局限于 Component->Scripts 选项下
   - 参数：menuName 菜单名称

  ```c#
  [AddComponentMenu("WarlGComponent/WarlGAttribute")]
  public class WarlGAttributeSample : MonoBehaviour
  {
  }
  ```

- MenuItem

  作用于静态方法，为主菜单和 Inspector context menu 添加选项。可添加快捷键：%（ctrl 或 command，区别于 Windows 或 MacOS）#（Shift）&（Alt）LEFT （左Shift）LEFT, RIGHT, UP, DOWN, F1 .. F12, HOME, END, PGUP, PGDN等

  如：`WarlGMenu/Item #&g` 即 `shift-alt-G` `WarlGMenu/Item _g` 即仅适用 `G` 键

  ```c#
  [MenuItem("WarlGMenu/Item #&g")]
  static void WarlGMenuItem()
  {
  }
  ```


## 其他

- InitializeOnLoadAttribute

  作用于静态方法（构造方法），当 Unity 加载时或脚本重编译时初始化编辑器类

- InitializeOnLoadMethodAttribute

  作用于静态方法，Unity 加载时执行编辑器类方法