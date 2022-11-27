# cmake 最小版本
cmake_minimum_required(VERSION 3.10)

# 包含颜色头文件
include(cmake/colors.cmake)

# project 名称
project(test)

# C++ 标准
set(CMAKE_C_FLAGS "-std=c99")
set(CMAKE_CXX_FLAGS "-std=c++11")

# 是否编译动态库
option(BUILD_SHARED_LIBS "Build shared libraries" OFF)   # 编译动态库
message("${Green} - Is allow build shared libraries? ${BUILD_SHARED_LIBS} ${ColourReset}")

# 设置编译输出
# 如果动态库存在，则不设置输出路径
# 如果需要编译新的动态库，则需要删除旧的动态库
if(BUILD_SHARED_LIBS AND NOT EXISTS ${PROJECT_SOURCE_DIR}/lib/libutils.so)
    # set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)
    set(EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/bin)
    set(LIBRARY_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/lib)
    message("${Green} - Executable output path: ${EXECUTABLE_OUTPUT_PATH} ${ColourReset}")
    message("${Green} - Libraries output path: ${LIBRARY_OUTPUT_PATH} ${ColourReset}")
elseif(EXISTS ${PROJECT_SOURCE_DIR}/lib/libutils.so)
    set(EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/bin)
    # message("${Yellow} - Shared libraries exist, and the file need to be remove if you want to build new libraries. ${ColourReset}")
    message("${Green} - Executable output path: ${EXECUTABLE_OUTPUT_PATH} ${ColourReset}")
    # message("${Green} - Libraries output path: ${LIBRARY_OUTPUT_PATH} ${ColourReset}")
endif()


# 编译动态库
# 如果编译库存在，则不用编译
# 如果编译库不存在，则需添加待编译的头文件和源代码
# 如果不编译动态库，则添加正常的第三方头文件和源代码
if(BUILD_SHARED_LIBS AND EXISTS ${PROJECT_SOURCE_DIR}/lib/libutils.so AND ${CMAKE_SYSTEM_PROCESSOR} MATCHES "x86_64")
    message("${Yellow} - Shared libraries exist. ${ColourReset}")
    message("${Yellow} - If you want to build new libraries, please delete the old libraries. Otherwise, take make cmd. ${ColourReset}")
    # message("${Green} - Found libraries header file in: ${UTILS_INCLUDE_DIRS} ${ColourReset}")
    # message("${Green} - Found libraries cc file in: ${UTILS_SOURCE} ${ColourReset}")
elseif(NOT EXISTS ${PROJECT_SOURCE_DIR}/lib/libutils.so AND BUILD_SHARED_LIBS)
    # message("${Green} - Allow build shared libraries. ${ColourReset}")
    set(UTILS_INCLUDE_DIRS 
        ${PROJECT_SOURCE_DIR}/src/utils.h
        ${PROJECT_SOURCE_DIR}/src/a.h
        ${PROJECT_SOURCE_DIR}/src/b.h
    )

    set(UTILS_SOURCE 
        ${PROJECT_SOURCE_DIR}/src/interface.cc
        ${PROJECT_SOURCE_DIR}/src/utils.cc
    )

    include_directories(${UTILS_INCLUDE_DIRS})
    add_library(utils SHARED ${UTILS_SOURCE})

    message("${Green} - Found libraries header file in: ${UTILS_INCLUDE_DIRS} ${ColourReset}")
    message("${Green} - Found libraries cc file in: ${UTILS_SOURCE} ${ColourReset}")
elseif(NOT EXISTS ${PROJECT_SOURCE_DIR}/lib/libutils.so AND NOT BUILD_SHARED_LIBS)
    message("${Green} - Don't allow build shared libraries. ${ColourReset}")
    set(UTILS_INCLUDE_DIRS 
        ${PROJECT_SOURCE_DIR}/src/utils.h
        ${PROJECT_SOURCE_DIR}/src/a.h
        ${PROJECT_SOURCE_DIR}/src/b.h
    )

    set(UTILS_SOURCE 
        ${PROJECT_SOURCE_DIR}/src/interface.cc
        ${PROJECT_SOURCE_DIR}/src/utils.cc
    )

    include_directories(${UTILS_INCLUDE_DIRS})

    message("${Green} - Found header file in: ${UTILS_INCLUDE_DIRS} ${ColourReset}")
    message("${Green} - Found cc file in: ${UTILS_SOURCE} ${ColourReset}")
endif()


############################### Build demo ###########################################
# 添加头文件 
include_directories(include)

set(test_source ./test/test.cpp)

if(EXISTS ${PROJECT_SOURCE_DIR}/lib/libutils.so)
    message("${Green} - Shared libraries are exist. ${ColourReset}")
    message("-- Found ${Red}libs${ColourReset} in:" ${PROJECT_SOURCE_DIR}/lib/libutils.so)
    add_executable(test ${test_source})
    target_link_libraries(test ${PROJECT_SOURCE_DIR}/lib/libutils.so)
elseif(NOT EXISTS ${PROJECT_SOURCE_DIR}/lib/libutils.so AND BUILD_SHARED_LIBS)
    message("${Green} - Please take make, cmake .. and make cmd. ${ColourReset}")
else()
    message("${Green} - Shared libraries are not exist. ${ColourReset}")
    add_executable(test ${test_source} ${UTILS_SOURCE})
endif()