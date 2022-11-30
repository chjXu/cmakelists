echo "Please select platform:"
echo -e "1. x86_64  2. orin  3. 8255 \n"

platforms=(x86_64 orin 8255)
read -p "" index
platform=${platforms[index - 1]}
echo "Select ${platforms[index - 1]}"

BUILD=./build

if [ ${platform} == x86_64 ] 
then
    echo "Build on x86_64"
    cmake -B ${BUILD} -DBUILD_PALTFORM=x86_64 -DBUILD_SHARED_LIBS=ON ..
elif [ ${platform} == orin ]
then
    echo "Build on orin"
    cmake -B ${BUILD} -DBUILD_PALTFORM=orin -DBUILD_SHARED_LIBS=ON ..
elif [ ${platform} == 8255 ]
then
    echo "Build on 8255"
    cmake -B ${BUILD} -DBUILD_PALTFORM=8255 -DBUILD_SHARED_LIBS=ON ..
fi

cd ./build
make -j

echo "Build test"
cmake -DBUILD_TEST=ON ..
make -j