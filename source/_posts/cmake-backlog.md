---
title: Cmake 备忘录
date: 2019-09-23 20:49:00
tags:
- cmake
- build system
---

## 指定安装库目录

```bash
cmake -DCMAKE_INSTALL_PREFIX=d:/code/libraries ..
```
之后就可以在 ` CMakeLists.txt ` 中使用该变量
```cmake
# find glfw3 from library
find_package(glfw3 PATHS ${CMAKE_INSTALL_PREFIX} NO_DEFAULT_PATH REQUIRED)
```

## 安装源代码
```cmake
# generate export target
install(TARGETS ${PROJECT_NAME}
        EXPORT ${PROJECT_NAME}-targets
        RUNTIME DESTINATION bin COMPONENT bin
        LIBRARY DESTINATION lib COMPONENT bin
        ARCHIVE DESTINATION lib COMPONENT dev)

# generate config file from export target
install(EXPORT ${PROJECT_NAME}-targets
        FILE ${PROJECT_NAME}-config.cmake
        DESTINATION lib/cmake/${PROJECT_NAME})

# copy header files
install(DIRECTORY include DESTINATION include/${PROJECT_NAME})
```

## 判断编译位数
```cmake
if(CMAKE_SIZEOF_VOID_P EQUAL 8)
    set(ARCH_BITS "64") # 64 bit
else()
    set(ARCH_BITS "32") # 32 bit
endif()
```

## 设置输出文件名
```cmake
# set output name for 'debug' build
set_target_properties(${PROJECT_NAME} PROPERTIES OUTPUT_NAME_DEBUG ${PROJECT_NAME}d)
# set output name for 'release' build
set_target_properties(${PROJECT_NAME} PROPERTIES OUTPUT_NAME_RELEASE ${PROJECT_NAME})
```

## 设置输出文件目录
```cmake
# set output path to bin folder
set(OUTPUT_PATH bin)
# set output path for runtime binary
set_target_properties(${PROJECT_NAME} PROPERTIES RUNTIME_OUTPUT_DIRECTORY_DEBUG ${OUTPUT_PATH})
set_target_properties(${PROJECT_NAME} PROPERTIES RUNTIME_OUTPUT_DIRECTORY_RELEASE ${OUTPUT_PATH})
set_target_properties(${PROJECT_NAME} PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${OUTPUT_PATH})
```

## 文件按目录分组
```cmake
# macro to group source file by folder
macro(group_sources SOURCE_FILES)
    foreach(FILE ${SOURCE_FILES})
        get_filename_component(PARENT_DIR "${FILE}" PATH)
        # skip source and changes /'s to \\'s
        string(REGEX REPLACE "(\\./)?(source)/?" "" GROUP "${PARENT_DIR}")
        string(REPLACE "/" "\\" GROUP "${GROUP}")
        source_group("${GROUP}" FILES "${FILE}")
    endforeach()
endmacro()
```

之后在 ` CMakeLists.txt ` 中使用宏
```cmake
set(SOURCE_FILES
HelloWorldApp.cpp
HelloWorldApp.h)

group_sources("${SOURCE_FILES}")
```

## 显示缓存中的变量
to list all options and cache variables do:
``` bash
mkdir build
cd build
cmake ..
cmake -LA
```

you can do ` cmake -LAH ` too. The H flag will provide you help for each options

