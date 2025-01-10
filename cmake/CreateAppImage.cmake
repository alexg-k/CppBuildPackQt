message(STATUS "Creating AppImage")

set(APPDIR_PATH "${CMAKE_BINARY_DIR}/AppDir")
set(LINUXDEPLOY_PATH "${CMAKE_BINARY_DIR}/linuxdeploy-x86_64.AppImage")

if(NOT EXISTS "${LINUXDEPLOY_PATH}")
    file(DOWNLOAD https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage "${LINUXDEPLOY_PATH}")
    execute_process(COMMAND chmod a+x "${LINUXDEPLOY_PATH}")
endif()

execute_process(COMMAND ${LINUXDEPLOY_PATH}
    --appimage-extract-and-run #workaround to execute in docker container
    --appdir ${APPDIR_PATH}
    --executable ${APPDIR_PATH}/usr/bin/CppBuildPackQt
    --desktop-file ${APPDIR_PATH}/usr/share/applications/CppBuildPackQt.desktop
    --custom-apprun ${CMAKE_BINARY_DIR}/AppRun
    --output appimage
)