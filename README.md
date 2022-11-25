# CMakeLists
# 0. 编译
-S	指定源文件根目录，必须包含一个CMakeLists.txt文件

-B	指定构建目录，构建生成的中间文件和目标文件的生成路径

-D	指定变量，格式为-D <var>=<value>，-D后面的空格可以省略

> cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug


# 1. 指定 cmake 最小版本
> cmake_minimum_required(VERSION 3.10)

# 2. 设置项目名称
它会引起两个变量 demo_BINARY_DIR 和 demo_SOURCE_DIR;

同时， cmake自动定义了两个等价的变量 PROJECT_BINARY_DIR 和 PROJECT_SOURCE_DIR.

> project(test)
> project(test LANGUAGE C CXX CUDA)


# 3. 设置编译类型， add_library 默认生成的是静态库
add_library(utils STATIC ./test/utils.cc)
add_library(utils SHARED ./test/utils.cc)


# 5. 设置变量
# 5.1 set 直接设置变量的值

# 5.2 set 环境变量
set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)
set(EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/bin)
set(LIBRARY_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/lib)
# set(CMAKE_C_FLAGS )
set(CMAKE_CXX_FLAGS "-std=c++11")
add_definitions("-std=c++11")


# 12. 条件控制
# 12.1 if...elseif...else...endif
if(expression)                          # expression 不为空
if(not exp)                             # exp 为空
if(var1 AND var2)
if(var1 OR var2)
if(COMMAND cmd)                         # 如果 cmd 为命令，则为真
if(EXISTS dir/file)                     # 如果目录或文件存在为真
if(file1 IS_NEWER_THAN file2)           # 当 file1 比 file2 新时，为真
if(IS_DIRECTORY dir)                    # 当 dir 为目录时，为真
if(DEFINED var)                         # 如果变量被定义，为真
if(var MATCHES regex)                   # 正则表达式匹配

# 12.2 数字比较
if(variable LESS number)                # 小于
if(variable GREATER number)             # 大于
if(variable EQUAL number)               # 等于


# 13. 常用变量
# 13.1 预定义变量
message(STATUS ${PROJECT_SOURCE_DIR})                   # 工程根目录 （/home/xcj/Desktop/cmkelists）
message(WARNING ${PROJECT_BINARY_DIR})                  # 运行 cmake 命令的目录 （/home/xcj/Desktop/cmkelists/build）
message(SEND_ERROR ${PROJECT_NAME})                     # 工程名称 （test）
message(FATAL_ERROR ${CMAKE_CURRENT_SOURCE_DIR})        # 当前处理 CMakeLists.txt 所在的路径 （/home/xcj/Desktop/cmkelists）
message(${CMAKE_CURRENT_BINARY_DIR})                    # target 编译目录 （/home/xcj/Desktop/cmkelists/build）
message(${CMAKE_CURRENT_LIST_DIR})                      # CMakeLists.txt 的完整路径 （/home/xcj/Desktop/cmkelists）
message(${CMAKE_CURRENT_LIST_LINE})                     # 当前所在行 （27）
message(${CMAKE_MODULE_PATH})                           # 定义自己的 cmake 模块所在的路径 (/home/xcj/Desktop/cmkelists/cmake)
message(${EXECUTABLE_OUTPUT_PATH})                      # 重新定义目标二进制可执行文件的存放位置 (/home/xcj/Desktop/cmkelists/bin)
message(${LIBRARY_OUTPUT_PATH})                         # 重新定义目标链接库文件的存放位置 (/home/xcj/Desktop/cmkelists/lib)


# 13.2 环境变量
# $ENV{Name}
set(ENV{Name} QNX)
message($ENV{Name})


# 13.3 系统信息
message(${CMAKE_MAJOR_VERSION})         # cmake 主版本号 （3）
message(${CMAKE_MINOR_VERSION})         # cmake 次版本号 （16）
message(${CMAKE_PATCH_VERSION})         # cmake 补丁等级 （3）
message(${CMAKE_SYSTEM})                # 系统名称 （Linux-5.15.0-53-generic）
message(${CMAKE_SYSTEM_NAME})           # 不包含版本的系统名 （Linux）
message(${CMAKE_SYSTEM_VERSION})        # 系统版本 （5.15.0-53-generic）
message(${CMAKE_SYSTEM_PROCESSOR})      # 处理器名称 （x86_64）
message(${UNIX})                        # 在所有的类 UNIX 平台下该值为 True，包括 OS X 和 cygwin （1）
message(${WIN32})                       # 在所有的类 win32 平台下该值为 True，包括 cygwin （1）


# 14. 主要开关选项
option(BUILD_SHARED_LIBS "Build shared libraries" ON)   # 编译动态库