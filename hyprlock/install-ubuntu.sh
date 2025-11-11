#! /usr/bin/env bash

# some apt deps for the following builds
apt-get install libgtest-dev libmagic-dev librsvg2-dev libpugixml-dev

# hyprutils is a dependency of hyprlock and isn't available on apt
git clone https://github.com/hyprwm/hyprutils.git
cd hyprutils/
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf NPROCESSORS_CONF`
cmake --install build
cd -
rm -rf hyprutils

# hyprgraphics is a dependency of hyprlock and isn't available on apt
git clone https://github.com/hyprwm/hyprgraphics
cd hyprgraphics/
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target hyprgraphics -j`nproc 2>/dev/null || getconf NPROCESSORS_CONF`
cmake --install build
cd -
rm -rf hyprgraphics

# hyprwayland-scanner is a dependency of hyprlock and isn't available on apt
git clone https://github.com/hyprwm/hyprwayland-scanner.git
cd hyprwayland-scanner
cmake -DCMAKE_INSTALL_PREFIX=/usr -B build
cmake --build build -j `nproc`
cmake --install build
cd -
rm -rf hyprwayland-scanner

# hyprlang is a dependency of hyprlock and isn't available on apt
git clone https://github.com/hyprwm/hyprlang.git
cd hyprlang
# As of Nov/2025 hyprlang uses a newer gcc than is stock on ubuntu 24. These oneliners let me build
grep -R 'std::print' include src | awk -F: '{print $1}' | sort -u | xargs -I{} sed -i 's|std::print(|std::cout << |g' {}
grep -R 'std::println' include src | awk -F: '{print $1}' | sort -u | xargs -I{} sed -i 's|std::println(|std::cout << |g'
grep -q '#include <optional>' src/config.hpp || sed -i '/#include <expected>/a #include <optional>' src/config.hpp
grep -q '#include <iostream>' include/hyprlang.hpp || sed -i '1i #include <iostream>' include/hyprlang.hpp
sed -i 's|#include <print>|#include <iostream>|g' include/hyprlang.hpp
sed -i 's|std::println("CSimpleConfigValue: value not found");|std::cout << "CSimpleConfigValue: value not found" << std::endl;|g' include/hyprlang.hpp
sed -i 's|std::println("CSimpleConfigValue: Mismatched type in CConfigValue<T>, got {} but has {}", typeid(T).name(), TYPE.name());|std::cout << "CSimpleConfigValue: Mismatched type in CConfigValue<T>" << std::endl;|g' include/hyprlang.hpp
sed -i 's|std::cout << "Impossible to implement ptr() of CConfigValue<std::string>")|std::cout << "Impossible to implement ptr() of CConfigValue<std::string>" << std::endl;|g' include/hyprlang.hpp
sed -i 's|std::cout << "Impossible to implement operator* of CConfigValue<Hyprlang::CUSTOMTYPE>, use ptr()")|std::cout << "Impossible to implement operator* of CConfigValue<Hyprlang::CUSTOMTYPE>, use ptr()" << std::endl;|g' include/hyprlang.hpp
sed -i 's|std::cout << "Impossible to implement operator\* of CConfigValue<Hyprlang::CUSTOMTYPE>, use ptr()")|std::cout << "Impossible to implement operator* of CConfigValue<Hyprlang::CUSTOMTYPE>, use ptr()" << std::endl;|g' include/hyprlang.hpp
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target hyprlang -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
cmake --install ./build
cd -
rm -rf hyprlang

# sdbus-c++ is a dependency of hyprlock and the version on apt is too old
git clone https://github.com/Kistler-Group/sdbus-cpp.git
cd sdbus-cpp
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr .
cmake --build .
cmake --build . --target install
cd ../..
rm -rf sdbus-cpp

# hyprlock itself
git clone https://github.com/hyprwm/hyprlock.git
cd hyprlock
# hyprlock depends on a newer version of gcc than is stock with Ubuntu 24. These oneliners downgrade some parts of the code to make it work.
sed -i 's|#include <print>|#include <iostream>|g' src/helpers/Log.hpp
sed -i 's|std::print(|std::cout << |g' src/helpers/Log.hpp
sed -i 's|std::println(|std::cout << |g' src/helpers/Log.hpp
sed -i 's|#include <print>|#include <iostream>|g' src/helpers/Log.hpp
sed -i 's|std::cout << "[{}] {}", logLevelString(level), std::vformat(fmt, std::make_format_args(args...)));|std::cout << "[" << logLevelString(level) << "] " << std::vformat(fmt, std::make_format_args(args...)) << std::endl;|g' src/helpers/Log.hpp
sed -i 's|std::cout << "[{}] {}", logLevelString(level), std::vformat(fmt, std::make_format_args(args...)));|std::cout << "[" << logLevelString(level) << "] " << std::vformat(fmt, std::make_format_args(args...)) << std::endl;|g' src/helpers/Log.hpp

sed -i 's|std::println("Hyprlock version v{}"|std::cout << "Hyprlock version v"|g' src/main.cpp
sed -i 's|std::println("Hyprlock version v{} (commit {})"|std::cout << "Hyprlock version v" << HYPRLOCK_VERSION << " (commit " << HYPRLOCK_COMMIT << ")"|g' src/main.cpp
sed -i 's|std::println(stderr, "Error: Missing value for {} option.", flag)|std::cerr << "Error: Missing value for " << flag << " option."|g' src/main.cpp
sed -i 's|std::println(stderr, "Error: Grace period must be non-negative.")|std::cerr << "Error: Grace period must be non-negative."|g' src/main.cpp
sed -i 's|std::println(stderr, "Error: Invalid grace period value: {}", \*value)|std::cerr << "Error: Invalid grace period value: " << \*value|g' src/main.cpp
sed -i 's|std::println(stderr, "Unknown option: {}", arg)|std::cerr << "Unknown option: " << arg|g' src/main.cpp
sed -i '/std::cout/d;/std::cerr/d;s|<< std::endl;||g' src/main.cpp
sed -i 's|std::println(|std::cout << |g' src/main.cpp

cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -S . -B ./build
cmake --build ./build --config Release --target hyprlock -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
cd -
rm -rf hyprlock

ln -s $PWD/hyprlock.conf $HOME/.config/hypr/hyprlock.conf
