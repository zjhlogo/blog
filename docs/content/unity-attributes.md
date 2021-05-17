# Unity 手册 Attributes

## 菜单 Menu

- AddComponentMenu
  作用于类上，将脚本置于 UnityEditor 顶部菜单栏 Component 菜单中的任意选项，而不局限于 Component->Scripts 选项下
   - 参数：menuName 菜单名称

  ``` csharp
  [AddComponentMenu("WarlGComponent/WarlGAttribute")]
  public class WarlGAttributeSample : MonoBehaviour
  {
  }
  ```

  
  
- MenuItem

  作用于静态方法，为主菜单和 Inspector context menu 添加选项。可添加快捷键：%（ctrl 或 command，区别于 Windows 或 MacOS）#（Shift）&（Alt）LEFT （左Shift）LEFT, RIGHT, UP, DOWN, F1 .. F12, HOME, END, PGUP, PGDN等

  如：`WarlGMenu/Item #&g` 即 `shift-alt-G` `WarlGMenu/Item _g` 即仅适用 `G` 键

  ``` csharp
  [MenuItem("WarlGMenu/Item #&g")]
  static void WarlGMenuItem()
  {
  }
  ```
  
  
  
- CreateAssetMenu(fileName="file name", menuName="menu name")
  Mark a ScriptableObject-derived type to be automatically listed in the Assets/Create submenu, so that instances of the type can be easily created and stored in the project as ".asset" files.
  
  ```csharp
  // fileName: 新建asset默认文件名
  // menuName: 在菜单中显示的菜单名
  [CreateAssetMenu(fileName = "Card", menuName = "Card")]
  public class Card : ScriptableObject
  {
  	public string cardName;
  	public int hp;
  	...
  }
  ```


## 其他

- RuntimeInitializeOnLoadMethod: Calls a method once before or after the first scene has loaded. Good for initializing Singletons without having to place objects in the scene.

  ``` csharp
  // 执行顺序:
  // SubsystemRegistration -> BeforeSplashScreen -> AfterAssembliesLoaded -> BeforeSceneLoad -> AfterSceneLoad
  [RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.BeforeSceneLoad)]
  static void OnLoad()
  {
      Debug.Log("Create Singletons");
  }
  ```



- InitializeOnLoadAttribute

  作用于静态方法（构造方法），当 Unity 加载时或脚本重编译时初始化编辑器类
  
  


- InitializeOnLoadMethodAttribute

  作用于静态方法，Unity 加载时执行编辑器类方法