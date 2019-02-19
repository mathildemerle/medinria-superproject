################################################################################
#
# medInria
#
# Copyright (c) INRIA 2013. All rights reserved.
# See LICENSE.txt for details.
#
#  This software is distributed WITHOUT ANY WARRANTY; without even
#  the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
#  PURPOSE.
#
################################################################################

function(ffmpeg_project)
set(ep ffmpeg)

## #############################################################################
## List the dependencies of the project
## #############################################################################

list(APPEND ${ep}_dependencies
  )

## #############################################################################
## Prepare the project
## #############################################################################

EP_Initialisation(${ep}
  USE_SYSTEM OFF
  BUILD_SHARED_LIBS OFF
  REQUIRED_FOR_PLUGINS OFF
  )

if (NOT USE_SYSTEM_${ep})
## #############################################################################
## Set directories
## #############################################################################

EP_SetDirectories(${ep}
  EP_DIRECTORIES ep_dirs
  )

## #############################################################################
## Define repository where get the sources
## #############################################################################

if (WIN32)
  if (NOT DEFINED ${ep}_SOURCE_DIR)
      set(location URL "https://ffmpeg.zeranoe.com/builds/win64/static/ffmpeg-20190217-9326117-win64-static.zip")
  endif()
else()
  set(tag "release/0.7") # cf. ${GITHUB_PREFIX}FFmpeg/FFmpeg.git for release numbers
  if (NOT DEFINED ${ep}_SOURCE_DIR)
      set(location GIT_REPOSITORY "https://git.ffmpeg.org/ffmpeg.git" GIT_TAG ${tag})
  endif()
endif()

## #############################################################################
## Add external-project
## #############################################################################
if (WIN32)
  ExternalProject_Add(${ep}
    ${ep_dirs}
    ${location}
    CONFIGURE_COMMAND ""
    INSTALL_COMMAND ""
    BUILD_COMMAND mv ${CMAKE_CURRENT_SOURCE_DIR}/${ep}/bin/ffmpeg.exe ${CMAKE_CURRENT_SOURCE_DIR}/build/${ep}/build
  )
else()
  ExternalProject_Add(${ep}
    ${ep_dirs}
    ${location}
    CONFIGURE_COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/${ep}/configure
	--disable-yasm --disable-static --disable-network --disable-zlib --disable-ffserver
	--disable-ffplay --disable-decoders
	--enable-shared --prefix=${CMAKE_CURRENT_SOURCE_DIR}/build/${ep}/build
    PREFIX ${CMAKE_CURRENT_SOURCE_DIR}/build/${ep}/build
    BUILD_COMMAND make install
  )
endif()

## #############################################################################
## Set variable to provide infos about the project
## #############################################################################

ExternalProject_Get_Property(${ep} binary_dir)
set(${ep}_DIR ${binary_dir} PARENT_SCOPE)

## #############################################################################
## Add custom targets
## #############################################################################

EP_AddCustomTargets(${ep})

endif() #NOT USE_SYSTEM_ep

endfunction()
