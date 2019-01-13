workspace "Hazel"
	architecture "x64"

	configurations
	{
		"Debug",
		"Release",
		"Dist"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

project "Hazel"
	location "Hazel"
	kind "StaticLib"
	language "C++"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	pchheader "hzpch.h"
	pchsource "Hazel/src/hzpch.cpp"

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"%{prj.name}/src",
		"%{prj.name}/vendor/spdlog/include"
	}

	filter "system:linux"
		pic "On"
		cppdialect "C++17"
		staticruntime "On"
		systemversion "latest"

		defines
		{
			"HZ_PLATFORM_LINUX",
			"HZ_BUILD_DLL"
		}

	filter "system:windows"
		cppdialect "C++17"
		staticruntime "On"
		systemversion "latest"

		defines
		{
			"HZ_PLATFORM_WINDOWS",
			"HZ_BUILD_DLL"
		}

		postbuildcommands
		{
			("{COPY} %{cfg.buildtarget.relpath} ../bin/" .. outputdir .. "/Sandbox")
		}

	filter "configurations:Debug"
		defines "HZ_DEBUG"
		runtime "Debug"
		staticruntime "Off"
		symbols "On"
	filter { "system:windows", "configurations:Debug" }
		runtime "Debug"
		staticruntime "Off"

	filter "configurations:Release"
		defines "HZ_RELEASE"
		runtime "Debug"
		staticruntime "Off"
		optimize "On"
	filter { "system:windows", "configurations:Release" }
		runtime "Debug"
		staticruntime "Off"

	filter "configurations:Dist"
		defines "HZ_DIST"
		runtime "Debug"
		staticruntime "Off"
		optimize "On"
	filter { "system:windows", "configurations:Dist" }
		runtime "Debug"
		staticruntime "Off"

project "Sandbox"
	location "Sandbox"
	kind "ConsoleApp"
	language "C++"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"Hazel/vendor/spdlog/include",
		"Hazel/src"
	}

	links
	{
		"Hazel"
	}

	filter "system:linux"
		cppdialect "C++17"
		staticruntime "On"
		systemversion "latest"

		defines
		{
			"HZ_PLATFORM_LINUX"
		}

	filter "system:windows"
		cppdialect "C++17"
		staticruntime "On"
		systemversion "latest"

		defines
		{
			"HZ_PLATFORM_WINDOWS"
		}

	filter "configurations:Debug"
		defines "HZ_DEBUG"
		runtime "Debug"
		staticruntime "Off"
		symbols "On"
	filter { "system:windows", "configurations:Debug" }
		runtime "Debug"
		staticruntime "Off"

	filter "configurations:Release"
		defines "HZ_RELEASE"
		runtime "Debug"
		staticruntime "Off"
		optimize "On"
	filter { "system:windows", "configurations:Release" }
		runtime "Debug"
		staticruntime "Off"

	filter "configurations:Dist"
		defines "HZ_DIST"
		runtime "Debug"
		staticruntime "Off"
		optimize "On"
	filter { "system:windows", "configurations:Dist" }
		runtime "Debug"
		staticruntime "Off"