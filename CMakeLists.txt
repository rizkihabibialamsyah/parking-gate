cmake_minimum_required(VERSION 3.16)

project(parkinggate VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)

find_package(Qt5 REQUIRED Qml Quick Sql)

qt5_add_resources(qml_QRC src/qml.qrc)
qt5_add_resources(images_QRC src/images.qrc)

set(SOURCES 
    src/modules/parkingdb/parkingdb.cpp
	src/main.cpp
)

add_executable(parkinggateapp
    ${SOURCES}
    ${qml_QRC}
    ${images_QRC}
)

target_link_libraries(parkinggateapp
    PRIVATE Qt5::Qml
    PRIVATE Qt5::Quick
    PRIVATE Qt5::Sql
)
