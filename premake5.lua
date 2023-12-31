workspace "Fractiz"
    architecture "x64"
    configurations { "Debug", "Release" }

    ExtLibs = {}
    ExtLibs["GLFW"]  = "Build/Vendor/glfw/include"

    outDir = "%{cfg.buildcfg}_%{cfg.system}_%{cfg.architecture}"

    include "Build/Vendor/glfw"

    project "Fractiz"
        location "Build"
        language "C"

        targetdir   ( "Binaries/" .. outDir .. "/%{prj.name}" )
        objdir      ( "Binaries/Objects/" .. outDir .. "/%{prj.name}" )

        files { "Build/Source/**.c", "Build/Include/**.h" }
        includedirs { "Build/Source", "Build/Include", "%{ExtLibs.GLFW}" }

        links { "GLFW" }

        filter "system:Windows"
            staticruntime "On"
            systemversion "latest"
            system "windows"
            defines { "FCT_WIN" }

            links { "GLFW", "opengl32.lib" }

        filter "system:Macosx"
            system "macosx"
            defines { "FCT_MACOS" }

        filter "system:Linux"
            pic "On"
            system "Linux"
            defines { "FCT_LINUX" }

        filter { "configurations:Debug" }
            defines { "FCT_DEBUG", "DEBUG" }
            kind "ConsoleApp"
            optimize "Debug"
            symbols "On"

        filter { "configurations:Release" }
            defines { "FCT_RELEASE", "NDEBUG" }
            kind "WindowedApp"
            optimize "Full"
            symbols "Off"
