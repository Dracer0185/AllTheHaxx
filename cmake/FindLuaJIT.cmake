find_package(PkgConfig QUIET)
pkg_check_modules(PC_LUAJIT luajit)
set_extra_dirs(LUAJIT luajit)

find_path(LUAJIT_INCLUDEDIR luajit.h
        PATH_SUFFIXES luajit
        HINTS ${PC_LUAJIT_INCLUDEDIR} ${PC_LUAJIT_INCLUDE_DIRS}
        PATHS ${EXTRA_LUAJIT_INCLUDEDIR}
        )
find_library(LUAJIT_LIBRARY
        NAMES luajit libluajit
        HINTS ${PC_LUAJIT_LIBDIR} ${PC_LUAJIT_LIBRARY_DIRS}
        PATHS ${EXTRA_LUAJIT_LIBDIR}
        )

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(LuaJIT DEFAULT_MSG LUAJIT_LIBRARY LUAJIT_INCLUDEDIR)

mark_as_advanced(LUAJIT_LIBRARY LUAJIT_INCLUDEDIR)

set(LUAJIT_LIBRARIES ${LUAJIT_LIBRARY})
set(LUAJIT_INCLUDE_DIRS ${LUAJIT_INCLUDEDIR})

string(FIND "${LUAJIT_LIBRARY}" "${PROJECT_SOURCE_DIR}" LOCAL_PATH_POS)
if(LOCAL_PATH_POS EQUAL 0 AND TARGET_OS STREQUAL "windows")
  set(LUAJIT_COPY_FILES "${EXTRA_LUAJIT_LIBDIR}/lua51.dll" )
else()
  set(LUAJIT_COPY_FILES)
endif()
