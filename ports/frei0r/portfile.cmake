include(vcpkg_common_functions)

vcpkg_fail_port_install(ON_TARGET "UWP")

if(VCPKG_CMAKE_SYSTEM_NAME STREQUAL "Windows")
    set(FREI0R_OS "win64")
    set(FREI0R_EXT "zip")
    set(FREI0R_HASH "da06ac6896c2085c33e3ffab05e836d3e2f685d859324e9feda7fe4140d645a835e8de45cc2bbf2310ce185961cb404c3af4c2ea5e57d8570013f9c9da9e2d8e")
elseif(VCPKG_CMAKE_SYSTEM_NAME STREQUAL "Linux")
    set(FREI0R_OS "linux")
    set(FREI0R_EXT "tar.gz")
    set(FREI0R_HASH "c24f6d37fdfd83a422e6db62504e8f5ca66eaf301634a2f0e14d0d7496ca114835e110066f8ca61bae60aa1a35bfb8754c9f86287ffb3be1187361df99f569da")
elseif(VCPKG_CMAKE_SYSTEM_NAME STREQUAL "Darwin")
    set(FREI0R_OS "osx")
    set(FREI0R_EXT "zip")
    set(FREI0R_HASH "1c4ed9e221fcf6e184d899c05dd7bbcd0a2c1fb528d1fbeddda4c05a8963006921bb95ce946ec85c3e7a91e698a88ae8b6c543a87c6accaea961a6372e8b357f")
else()
    message(FATAL_ERROR "Unsupported system: ${VCPKG_CMAKE_SYSTEM_NAME}")
endif()

set(FREI0R_VERSION "v2.3.3")
set(FREI0R_FILENAME "frei0r-${FREI0R_VERSION}_${FREI0R_OS}.${FREI0R_EXT}")
set(FREI0R_URL "https://github.com/dyne/frei0r/releases/download/v2.3.3/${FREI0R_FILENAME}")

vcpkg_download_distfile(ARCHIVE
    URLS "${FREI0R_URL}"
    FILENAME "${FREI0R_FILENAME}"
    SHA512 "${FREI0R_HASH}"
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE "${ARCHIVE}"
)

# Assuming the structure of the archive matches the expected layout
file(GLOB H_FILES "${SOURCE_PATH}/*.h" "${SOURCE_PATH}/*.hpp")
file(COPY ${H_FILES} DESTINATION ${CURRENT_PACKAGES_DIR}/include)

file(COPY ${SOURCE_PATH}/filter/ DESTINATION ${CURRENT_PACKAGES_DIR}/bin/frei0r/filter)
file(COPY ${SOURCE_PATH}/generator/ DESTINATION ${CURRENT_PACKAGES_DIR}/bin/frei0r/generator)
file(COPY ${SOURCE_PATH}/mixer2/ DESTINATION ${CURRENT_PACKAGES_DIR}/bin/frei0r/mixer2)
file(COPY ${SOURCE_PATH}/mixer3/ DESTINATION ${CURRENT_PACKAGES_DIR}/bin/frei0r/mixer3)

file(COPY ${SOURCE_PATH}/LICENSE.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/frei0r/copyright)  
vcpkg_copy_pdbs()