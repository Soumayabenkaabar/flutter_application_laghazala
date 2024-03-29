# Version minimale de CMake requise
cmake_minimum_required(VERSION 3.20)

# Nom du projet
project(flutter_application_laghazala LANGUAGES CXX)

# Nom du binaire de l'application
set(BINARY_NAME "flutter_application_laghazala")

# Utilisation de politiques de CMake modernes
cmake_policy(VERSION 3.20)

# Définition des configurations de construction
set(CMAKE_CONFIGURATION_TYPES "Debug;Profile;Release" CACHE STRING "" FORCE)
if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
  set(CMAKE_BUILD_TYPE "Debug" CACHE STRING "Flutter build mode" FORCE)
  set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Profile" "Release")
endif()

# Utilisation d'Unicode pour tous les projets
add_definitions(-DUNICODE -D_UNICODE)

# Fonction pour appliquer les paramètres de compilation standard
function(APPLY_STANDARD_SETTINGS TARGET)
  target_compile_features(${TARGET} PUBLIC cxx_std_17)
  target_compile_options(${TARGET} PRIVATE /W4 /WX /wd"4100")
  target_compile_options(${TARGET} PRIVATE /EHsc)
  target_compile_definitions(${TARGET} PRIVATE "_HAS_EXCEPTIONS=0")
  target_compile_definitions(${TARGET} PRIVATE "$<$<CONFIG:Debug>:_DEBUG>")
endfunction()

# Règles de construction pour la bibliothèque Flutter et les outils
set(FLUTTER_MANAGED_DIR "${CMAKE_CURRENT_SOURCE_DIR}/flutter")
add_subdirectory(${FLUTTER_MANAGED_DIR})

# Règles de construction pour l'application
add_subdirectory("runner")

# Règles de construction des plugins générés
include(flutter/generated_plugins.cmake)

# Installation des fichiers nécessaires
set(BUILD_BUNDLE_DIR "$<TARGET_FILE_DIR:${BINARY_NAME}>")
set(CMAKE_VS_INCLUDE_INSTALL_TO_DEFAULT_BUILD 1)
if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
  set(CMAKE_INSTALL_PREFIX "${BUILD_BUNDLE_DIR}" CACHE PATH "..." FORCE)
endif()

set(INSTALL_BUNDLE_DATA_DIR "${CMAKE_INSTALL_PREFIX}/data")
set(INSTALL_BUNDLE_LIB_DIR "${CMAKE_INSTALL_PREFIX}")

install(TARGETS ${BINARY_NAME} RUNTIME DESTINATION "${CMAKE_INSTALL_PREFIX}" COMPONENT Runtime)

install(FILES "${FLUTTER_ICU_DATA_FILE}" DESTINATION "${INSTALL_BUNDLE_DATA_DIR}" COMPONENT Runtime)

install(FILES "${FLUTTER_LIBRARY}" DESTINATION "${INSTALL_BUNDLE_LIB_DIR}" COMPONENT Runtime)

if(PLUGIN_BUNDLED_LIBRARIES)
  install(FILES "${PLUGIN_BUNDLED_LIBRARIES}" DESTINATION "${INSTALL_BUNDLE_LIB_DIR}" COMPONENT Runtime)
endif()

set(NATIVE_ASSETS_DIR "${PROJECT_BUILD_DIR}native_assets/windows/")
install(DIRECTORY "${NATIVE_ASSETS_DIR}" DESTINATION "${INSTALL_BUNDLE_LIB_DIR}" COMPONENT Runtime)

set(FLUTTER_ASSET_DIR_NAME "flutter_assets")
install(CODE "file(REMOVE_RECURSE \"${INSTALL_BUNDLE_DATA_DIR}/${FLUTTER_ASSET_DIR_NAME}\")" COMPONENT Runtime)
install(DIRECTORY "${PROJECT_BUILD_DIR}/${FLUTTER_ASSET_DIR_NAME}" DESTINATION "${INSTALL_BUNDLE_DATA_DIR}" COMPONENT Runtime)

install(FILES "${AOT_LIBRARY}" DESTINATION "${INSTALL_BUNDLE_DATA_DIR}" CONFIGURATIONS Profile;Release COMPONENT Runtime)
